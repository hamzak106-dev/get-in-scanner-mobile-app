// Automatic FlutterFlow imports
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:math';

// Imports other custom actions
// Imports custom functions
import 'package:flutter/material.dart';
import 'package:random_password_generator/random_password_generator.dart';

import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';

// import 'init_power_sync.dart';

Future generateAccessCodeIfNot(Function(bool)? callback) async {
  // Add your function code here!

  debugPrint("User ID ====>> ${FFAppState().user.userId.toString()}");

  // check user exist
  bool userExist = false;
  try {
    var rows = await CreatorsTable().queryRows(
      queryFn: (q) => q.eq(
        'user_id',
        FFAppState().user.userId,
      ),
    );
    if (rows.isNotEmpty) {
      userExist = true;
    }
  } catch (e) {
    debugPrint("ERROR User Exist ====>> ${e.toString()}");
  }

  if (!userExist) {
    try {
      await CreatorsTable().insert({
        'user_id': FFAppState().user.userId,
        'name':
            '${FFAppState().user.user.firstName} ${FFAppState().user.user.lastName}',
        'email': FFAppState().user.user.email,
        'refresh_token': FFAppState().user.auth.refresh,
        'session_token': FFAppState().user.auth.session,
        'phone': FFAppState().user.user.phone,
        'phone_country_code': FFAppState().user.user.phoneCountryCode,
        'profile_img': FFAppState().user.user.profileImg,
      });
    } catch (e) {
      debugPrint("ERROR Insert User ====>> ${e.toString()}");
    }
  }
  bool newPin = false;
  try {
    // var rowData = await db
    //     .get("SELECT * FROM pin WHERE user_id = ${FFAppState().user.userId}");

    var rowData = await PinTable().queryRows(
      queryFn: (q) => q.eq(
        'user_id',
        FFAppState().user.userId,
      ),
    );
    if (rowData.isNotEmpty) {

    } else {
      await generateAccessCode();
      newPin = true;
    }
  } catch (e) {
    debugPrint("ERROR Pin where  ====>> ${e.toString()}");
    if (e.toString() == "Bad state: No element") {
      await generateAccessCode();
    } else {
      debugPrint("ERROR Select Pin with User ID ====>> ${e.toString()}");
      return null;
    }
  } finally {
    callback?.call(newPin);
  }
}

Future generateAccessCode() async {
  String accessCode = "", pin = "";
  final passwordGenerator = RandomPasswordGenerator();
  while (accessCode.isEmpty || pin.isEmpty) {
    // generate Access Code
    String aCode = passwordGenerator.randomPassword();
    debugPrint("Access Code ====>> $aCode");
    if (aCode.isNotEmpty) {
      try {
        // var rows =
        //     await db.get("SELECT * FROM pin WHERE access_code = '$aCode'");
        var rows = await PinTable().queryRows(
          queryFn: (q) => q.eq(
            'access_code',
            aCode,
          ),
        );
        if (rows.isEmpty) {
          accessCode = aCode;
        }
      } catch (e) {
        if (e.toString() == "Bad state: No element") {
          accessCode = aCode;
        } else {
          debugPrint(
              "ERROR Select Pin with access_code ====>> ${e.toString()}");
        }
      }
    }

    // generate Pin
    String pn = generatePasscode();
    debugPrint("PIN ====>> $pn");
    if (pn.isNotEmpty) {
      try {
        // var rows = await db.get("SELECT * FROM pin WHERE pin = $pn");
        var rows = await PinTable().queryRows(
          queryFn: (q) => q.eq(
            'pin',
            pn,
          ),
        );
        if (rows.isEmpty) {
          pin = pn;
        }
      } catch (e) {
        if (e.toString() == "Bad state: No element") {
          pin = pn;
        } else {
          debugPrint("ERROR ERROR ====>> ${e.toString()}");
        }
      }
    }

    // check access code and pin combination found

    try {
      // var rows = await db.get(
      //     "SELECT * FROM pin WHERE access_code = '$accessCode' and pin = $pin");
      var rows = await PinTable().queryRows(
        queryFn: (q) => q
            .eq(
              'access_code',
              accessCode,
            )
            .eq(
              'pin',
              pin,
            ),
      );
      if (rows.isNotEmpty) {
        accessCode = "";
        pin = "";
      }
    } catch (e) {
      debugPrint("ERROR ERROR ====>> ${e.toString()}");
    }
  }

  try {
    await PinTable().insert({
      'user_id': FFAppState().user.userId,
      'access_code': accessCode,
      'pin': pin,
      'type': 'SYSTEM',
    });
  } catch (e) {
    debugPrint("ERROR ERROR ====>> ${e.toString()}");
  }
}

String generatePasscode() {
  int i = 0;
  String numbers = "123456789";
  String result = "";
  while (i < 4) {
    int randomInt = Random.secure().nextInt(numbers.length);
    result += numbers[randomInt];
    i++;
  }
  return result;
}

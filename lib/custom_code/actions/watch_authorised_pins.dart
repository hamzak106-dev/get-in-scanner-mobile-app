// Automatic FlutterFlow imports
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';

// Imports other custom actions
// Imports custom functions

// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '../actions/init_power_sync.dart';

import 'dart:async';

import 'index.dart';

Future<void> watchAuthorisedPins(Future Function(List<PinRow>? result) callback) async {
  // Determine if the user has full access
  bool hasFullAccess = FFAppState().user.profile == Profile.admin || FFAppState().user.profile == Profile.producer;

  String? watchQuery;

  if (hasFullAccess) {
    watchQuery = 'SELECT * FROM pin WHERE user_id = ${FFAppState().user.userId}';
  } else if (FFAppState().user.profile == Profile.manager) {
    if (FFAppState().selectedProducer.userId != null) {
      // Set the query to fetch pins created by the associated producers
      // watchQuery =
      //     'SELECT * FROM pin WHERE user_id = ${FFAppState().selectedProducer.userId} ${FFAppState().user.userId != FFAppState().selectedProducer.userId ? 'AND created_by = ${FFAppState().user.userId}' : ''}';
      watchQuery =
      'SELECT * FROM pin WHERE user_id = ${FFAppState().selectedProducer.userId}';
    }
  } else {
    var pinId = FFAppState().user.pinId;

    if (pinId > 0) {
      var pinData = await db.get('SELECT * FROM pin WHERE uid = $pinId');
      PinRow pin = PinRow(pinData);

      // Grant full access if the pin type is SYSTEM
      hasFullAccess = pin.type == 'SYSTEM';
    }
    // Set query based on access level
    watchQuery = hasFullAccess
        ? 'SELECT * FROM pin WHERE user_id = ${FFAppState().user.userId}'
        : 'SELECT * FROM pin WHERE uid = ${FFAppState().user.pinId}';
  }

  print('WatchAuthorisedPins: $watchQuery');

  if (watchQuery != null) {
    // Subscribe to database changes
    var stream = db.watch(watchQuery);
    listsSubscription = stream.listen((data) {
      print("PIN DATA LENGTH ==>> ${data.length}");
      callback(data.map((json) => PinRow(Map<String, dynamic>.from(json))).toList());
    });
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!

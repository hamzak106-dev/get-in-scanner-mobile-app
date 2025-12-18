// Automatic FlutterFlow imports
import 'package:flutter/foundation.dart';

// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:firebase_app_check/firebase_app_check.dart';

Future<String?> getFBAppCheckToken() async {
  try {
    await FirebaseAppCheck.instance.activate(
        webProvider: ReCaptchaEnterpriseProvider(
            '6LefZpYnAAAAAEb7C5mjJrhfCarZVgTLq4iOIUoT'),
        androidProvider:
            kDebugMode ? AndroidProvider.debug : AndroidProvider.playIntegrity,
        appleProvider: AppleProvider.deviceCheck);

    // Add your function code here!
    String? token = await FirebaseAppCheck.instance.getToken(true);

    print("\n ========== AppCheck Token ========== ");
    print("\nToken $token");
    print("\n ========== AppCheck Token ========== ");
    return token;
  } catch (e) {
    print("\n ========== AppCheck Error ========== ");
    print(e);
    print("\n ========== AppCheck Error ========== ");
    return null;
  }
}

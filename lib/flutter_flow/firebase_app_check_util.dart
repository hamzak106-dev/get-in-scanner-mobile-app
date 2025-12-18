import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/foundation.dart';

Future initializeFirebaseAppCheck() => FirebaseAppCheck.instance.activate(
      webProvider: ReCaptchaEnterpriseProvider(
          '6LefZpYnAAAAAEb7C5mjJrhfCarZVgTLq4iOIUoT'),
      androidProvider: kDebugMode? AndroidProvider.debug : AndroidProvider.playIntegrity,
      appleProvider: kDebugMode? AppleProvider.debug: AppleProvider.deviceCheck,
    );

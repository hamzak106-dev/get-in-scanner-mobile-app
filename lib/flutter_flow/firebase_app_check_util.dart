import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/foundation.dart';

Future initializeFirebaseAppCheck() => FirebaseAppCheck.instance.activate(
      webProvider: ReCaptchaEnterpriseProvider(
          '6LefZpYnAAAAAEb7C5mjJrhfCarZVgTLq4iOIUoT'),
      providerAndroid: kDebugMode? AndroidDebugProvider(debugToken: '925dfebe-6655-497e-a5e1-4566c1c2861c') : AndroidPlayIntegrityProvider(),
      providerApple: kDebugMode? AppleDebugProvider(debugToken: '925dfebe-6655-497e-a5e1-4566c1c2861c'): AppleDeviceCheckProvider(),
    );

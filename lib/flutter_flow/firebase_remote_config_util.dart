import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

Future initializeFirebaseRemoteConfig() async {
  try {
    await FirebaseRemoteConfig.instance.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 60),
      minimumFetchInterval: const Duration(hours: 1),
    ));
    if (kDebugMode) {
      await FirebaseRemoteConfig.instance.setDefaults(const {
        'apiVersion': 'V5',
        'GetInBaseUrl': 'https://api.getin-nextgen.com',
        'ImageBaseUrl': 'https://static.getin-nextgen.com',
        'powerSyncUrl':
            'https://673ad860ea6f3c0961fddcad.powersync.journeyapps.com',
        'sbEmail': 'qc@get-in.com',
        'sbPassword': 'Getin12*',
        'ScannerApiBaseUrl': 'https://scanner.getin-nextgen.com/api/v1/events',
        'scannerApiKey': '5c578ce23c24d16ea1d95b2fd248b3a6',
        'scannerApiToken': 'ix2UttqrXW/YvtNIw171pSFaMwt8hj\$Ffa0mVBwZffc=',
        'allow_tap_to_pay': '',
        'is_available_pos': false,
        'disable_timezone_adjustment': false,
      });
    }
    await FirebaseRemoteConfig.instance.fetchAndActivate();
  } catch (error) {
    print(error);
  }
}

String getRemoteConfigString(String key) =>
    FirebaseRemoteConfig.instance.getString(key);

bool getRemoteConfigBool(String key) =>
    FirebaseRemoteConfig.instance.getBool(key);

int getRemoteConfigInt(String key) => FirebaseRemoteConfig.instance.getInt(key);

double getRemoteConfigDouble(String key) =>
    FirebaseRemoteConfig.instance.getDouble(key);

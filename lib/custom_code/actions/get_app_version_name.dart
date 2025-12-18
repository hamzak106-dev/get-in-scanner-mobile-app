// Automatic FlutterFlow imports
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:package_info_plus/package_info_plus.dart';

Future<String?> getAppVersionName() async {
  // Add your function code here!
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String versionNumber = packageInfo.version;
  return versionNumber;
}

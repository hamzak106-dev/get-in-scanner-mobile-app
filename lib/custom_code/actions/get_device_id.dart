// Automatic FlutterFlow imports
import 'package:device_marketing_names/device_marketing_names.dart';

import '/flutter_flow/flutter_flow_util.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!




import 'package:flutter_udid/flutter_udid.dart';

Future getDeviceId() async {
  // final deviceInfoPlugin = DeviceInfoPlugin();

  String deviceName = "";

  // if (Platform.isAndroid) {
  //   final plugin = DeviceName();
  //   var androidDeviceName = await plugin.getName();
  //   if (androidDeviceName == null) {
  //     var tempDeviceInfo = await deviceInfoPlugin.androidInfo;
  //     deviceName = tempDeviceInfo.display;
  //   } else {
  //     deviceName = androidDeviceName;
  //   }
  // } else {
  //   var tempDeviceInfo = await deviceInfoPlugin.iosInfo;
  //   deviceName = tempDeviceInfo.name;
  // }

  final deviceNames = DeviceMarketingNames();

  deviceName = await deviceNames.getSingleName();

  print("==========================");
  print(deviceName);
  print("==========================");

  var uniqueId = await FlutterUdid.udid;

  FFAppState().update(() {
    FFAppState().uuid = uniqueId;
    FFAppState().deviceName = deviceName;
  });
}

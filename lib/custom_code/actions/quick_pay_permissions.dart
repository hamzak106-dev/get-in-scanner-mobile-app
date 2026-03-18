import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

Future<bool> configureTerminalPermissions() async {
  print("permission requesting");
  final permissions = <Permission>[
    Permission.location,
    if (Platform.isAndroid) Permission.bluetoothScan,
    if (Platform.isAndroid) Permission.bluetoothConnect,
  ];

  final result = await permissions.request();

  print(result);
  print('opening settings');
  if (result[Permission.location]?.isGranted == false) {
    // If location permission is not granted, show dialog to open settings
    await openAppSettings();
    return false;
  }
  print('afetr opening settings');

  return result.values.every((p) => p.isGranted);
}

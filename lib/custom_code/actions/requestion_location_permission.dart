import 'dart:developer';

import 'package:location/location.dart';

Future<PermissionStatus> requestLocationPermissionStatus() async {
  final Location location = Location();

  bool serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      return PermissionStatus.denied;
    }
  }

  PermissionStatus permissionStatus = await location.hasPermission();
  if (permissionStatus == PermissionStatus.denied) {
    permissionStatus = await location.requestPermission();
  }

  return permissionStatus;
}

Future<bool> requestLocationPermission() async {
  final PermissionStatus status = await requestLocationPermissionStatus();
  log("Permission Status ::: ${status.name}");
  if (status != PermissionStatus.granted) return false;

  try {
    final Location location = Location();
    await location.getLocation();
    return true;
  } catch (e) {
    return false;
  }
}

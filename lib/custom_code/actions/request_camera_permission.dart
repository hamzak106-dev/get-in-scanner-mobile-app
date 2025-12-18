import 'package:flutter/material.dart';
import 'package:g_e_t_i_n_scanner/flutter_flow/flutter_flow_util.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> requestCameraPermission(BuildContext context) async {
  final permissions = await Permission.camera.request();
  final hasPermission = permissions.isGranted;
  if (!hasPermission) {
    return await showDialog(
      context: context,
      builder: (alertDialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          title: Text(
            'Camera Permission Denied',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          content: Text(
              'Please enable camera permission in settings to use the QR scanner.'),
          actions: [
            TextButton(
              onPressed: () async {
                if (isAndroid) {
                  await openAppSettings();
                }
                Navigator.pop(alertDialogContext, false);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
  return true;
}

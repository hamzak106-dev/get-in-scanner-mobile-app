import 'dart:developer';
import 'package:g_e_t_i_n_scanner/app_state.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:g_e_t_i_n_scanner/custom_code/actions/init_power_sync.dart';

Future<void> enableTapToPay(String deviceId, int userId) async {
  try {
    String id = deviceId;
    if (id.isEmpty) {
      id = await FlutterUdid.udid;
      FFAppState().uuid = id;
    }
    log("Enabling Tap to Pay on device $id for user $userId");

    await db.execute(
      "UPDATE device SET tap_to_pay_enabled = 1, updated_at = datetime('now') WHERE device_id = ? AND user_id = ?",
      [id, userId],
    );

    // Update local App State for immediate UI feedback and persistence
    FFAppState().tapToPayEnabled = true;

    log("Locally updated tap_to_pay_enabled to true for device $id");
  } catch (e) {
    log("Failed to enable Tap to Pay on device $deviceId: $e");
  }
}

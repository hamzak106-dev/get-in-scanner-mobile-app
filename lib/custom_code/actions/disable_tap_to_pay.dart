import 'dart:developer';

import 'package:g_e_t_i_n_scanner/app_state.dart';
import 'package:g_e_t_i_n_scanner/backend/supabase/database/tables/device.dart';
import 'package:g_e_t_i_n_scanner/custom_code/actions/init_power_sync.dart';

Future<void> disableTapToPay(String deviceId, int userId) async {
  try {
    log("Disabling Tap to Pay on device $deviceId");

    // Update the local database via PowerSync
    await db.execute(
      "UPDATE device SET tap_to_pay_enabled = 0, updated_at = datetime('now') WHERE device_id = ? AND user_id = ?",
      [deviceId, userId],
    );

    // Update local App State for immediate UI feedback and persistence
    FFAppState().tapToPayEnabled = false;

    print("Tap to Pay disabled successfully on device $deviceId");
  } catch (e) {
    print("Failed to disable Tap to Pay on device $deviceId: $e");
  }
}

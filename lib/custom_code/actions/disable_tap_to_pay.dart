import 'dart:developer';

import 'package:g_e_t_i_n_scanner/backend/supabase/database/tables/device.dart';
import 'package:g_e_t_i_n_scanner/backend/supabase/supabase.dart';
import 'package:g_e_t_i_n_scanner/custom_code/actions/init_power_sync.dart';

Future<void> disableTapToPay(String deviceId, int userId) async {
  // This is a placeholder for the actual implementation to disable Tap to Pay.
  // The actual implementation will depend on the specific SDK or API being used.
  try {
    log("Disabling Tap to Pay on device $deviceId");
    await DeviceTable().update(
      data: {'tap_to_pay_enabled': false},
      matchingRows: (rows) => rows.eqOrNull(
        'device_id',
        deviceId,
      ).eqOrNull('user_id', userId),
    );
    print("Tap to Pay disabled successfully on device $deviceId");
  } catch (e) {
    print("Failed to disable Tap to Pay on device $deviceId: $e");
  }
}
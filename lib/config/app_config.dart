import '../app_state.dart';
import '../backend/supabase/database/tables/device.dart';

class AppConfig {
  static bool isEnabledTTP({List<DeviceRow> devices = const []}) {
    // 1. Check if we have device data from the database
    if (devices.isNotEmpty) {
      final currentDevice = devices.firstWhere(
        (e) => e.deviceId == FFAppState().uuid && e.userId == FFAppState().user.userId,
        orElse: () => devices.firstWhere(
          (e) => e.deviceId == FFAppState().uuid,
          orElse: () => DeviceRow({}),
        ),
      );

      if (currentDevice.data.isNotEmpty) {
        // Update AppState to keep it in sync with DB
        if (FFAppState().tapToPayEnabled != currentDevice.tapToPayEnabled) {
          FFAppState().tapToPayEnabled = currentDevice.tapToPayEnabled;
        }
        return currentDevice.tapToPayEnabled;
      }
    }

    // 2. Fallback to persisted App State if DB data is not yet available
    return FFAppState().tapToPayEnabled;
  }
}

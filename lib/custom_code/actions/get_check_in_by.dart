// Automatic FlutterFlow imports
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';

// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '../actions/init_power_sync.dart';

Future<String> getCheckInBy(int attendeeId, int selectionIndex) async {
  // Determine check-in or check-out status
  String status = selectionIndex == 0 ? "CHECK_IN" : "CHECK_OUT";

  // Fetch the first matching check-in log
  var checkInLogs = await db.get(
      'SELECT * FROM check_in_logs WHERE attendee_id = $attendeeId AND status = \'$status\' ORDER BY scan_at ASC LIMIT 1');

  if (checkInLogs == null) return "No scan data available"; // Handle empty results

  CheckInLogsRow checkInLogsRow = CheckInLogsRow(Map<String, dynamic>.from(checkInLogs));
  String scanTime = dateTimeFormat("relative", checkInLogsRow.scanAt?.toLocal());

  // Check if the scan was made using a device
  if (checkInLogsRow.deviceId > 0) {
    var rowData = await db.get("SELECT * FROM device WHERE uid = ${checkInLogsRow.deviceId}");
    if (rowData == null) return "Device data not found";

    DeviceRow device = DeviceRow(Map<String, dynamic>.from(rowData));

    if (FFAppState().user.deviceId == device.uid) {
      return "Scanned $scanTime By You";
    }

    if (device.isAdmin ?? false) {
      var userData = await db.get("SELECT * FROM creators WHERE user_id = ${device.userId}");
      if (userData != null) {
        CreatorsRow user = CreatorsRow(Map<String, dynamic>.from(userData));
        return "Scanned $scanTime By ${user.name ?? ''}";
      }
    }

    return "Scanned $scanTime By ${device.name ?? ''}";
  }

  // If no device, check the user who performed the scan
  var userData = await db.get("SELECT * FROM creators WHERE user_id = ${checkInLogsRow.userId}");
  if (userData != null) {
    CreatorsRow user = CreatorsRow(Map<String, dynamic>.from(userData));
    return "Scanned $scanTime By ${user.name ?? ''}";
  }

  return "Scanned $scanTime By Unknown";
}

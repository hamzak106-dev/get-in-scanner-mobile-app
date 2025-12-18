// Automatic FlutterFlow imports
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '../actions/init_power_sync.dart';

Future<DeviceRow?> checkExistingDevice(int pinId) async {
  print(pinId);
  try {
    var rowData = await db.get(
        "SELECT * FROM device WHERE device_id = '${FFAppState().uuid}' AND pin_id = '$pinId'");

    return DeviceRow(Map<String, dynamic>.from(rowData));
  } catch (e) {
    print("ERROR ERROR ====>> ${e}");
    return null;
  }
}

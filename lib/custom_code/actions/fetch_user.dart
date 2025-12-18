// Automatic FlutterFlow imports
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '../actions/init_power_sync.dart';

Future<CreatorsRow?> fetchUser() async {
  try {
    var rowData = await db.get(
        "SELECT * FROM creators WHERE user_id = ${FFAppState().user.userId}");

    return CreatorsRow(Map<String, dynamic>.from(rowData));
  } catch (e) {
    print(FFAppState().user.userId.toString());
    print("FETCH USER ERROR ====>> ${e}");
    return null;
  }
}

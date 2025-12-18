// Automatic FlutterFlow imports
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '../actions/init_power_sync.dart';

Future<int> countAttendee(int eventId) async {
  try {
    var rowData = await db
        .get("SELECT COUNT(*) FROM attendee WHERE event_id = '$eventId'");

    print(rowData.values.first.toString());

    return rowData.values.first as int;
  } catch (e) {
    print("COUNT ATTENDEE ERROR ====>> ${e}");
    return 0;
  }
}

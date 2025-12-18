// Automatic FlutterFlow imports
import '../actions/index.dart';

import '/backend/supabase/supabase.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '../actions/init_power_sync.dart';

Future watchCheckInLogLists(
  Future Function(List<CheckInLogsRow>? result) callback,
  List<int> eventIds,
) async {
  var stream = db.watch("SELECT * FROM check_in_logs WHERE event_id IN (${eventIds.join(', ')}) ORDER BY scan_at DESC");



  checkInLogsSubscription = stream.listen((data) {
    callback(data.map((json) => CheckInLogsRow(Map<String, dynamic>.from(json))).toList());
  });
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!

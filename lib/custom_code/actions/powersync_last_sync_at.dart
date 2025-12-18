// Automatic FlutterFlow imports
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '../actions/init_power_sync.dart';

Future<DateTime?> powersyncLastSyncAt() async {
  // Add your function code here!
  return Future.value(db.currentStatus.lastSyncedAt);
}

// Automatic FlutterFlow imports
import 'dart:async';

import '/backend/supabase/supabase.dart';
// Imports other custom actions
// Imports custom functions

// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '../actions/init_power_sync.dart';

Future<void> watchAddOnsLists(String attendeeUid,
    Future Function(List<AddOnRow>? result) callback) async {
    // a.*,
  var stream = db.watch("""
 SELECT 
    aa.id AS attendee_add_on_id,
    aa.status,
    a.image_url,
    ad.name,
    ad.lang,
    ad.description
FROM add_ons a
JOIN attendee_add_ons aa 
       ON a.addon_id = aa.addon_id 
      AND aa.attendee_uid = '$attendeeUid'
LEFT JOIN add_on_descriptions ad 
       ON a.addon_id = ad.addon_id
ORDER BY ad.name ASC;

  """);
  addonsListSubscription = stream.listen((data) {
    callback(
        data.map((json) => AddOnRow(Map<String, dynamic>.from(json))).toList());
  });
}

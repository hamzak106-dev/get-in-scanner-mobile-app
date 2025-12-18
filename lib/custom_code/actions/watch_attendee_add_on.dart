// Automatic FlutterFlow imports
import 'dart:async';

import '/backend/supabase/supabase.dart';
// Imports other custom actions
// Imports custom functions

// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '../actions/init_power_sync.dart';

Future<void> watchAttendeeAddOn(
  int attendeeAddOnId,
  Future Function(AddOnRow result) callback,
) async {
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
         AND aa.id = $attendeeAddOnId
    LEFT JOIN add_on_descriptions ad 
          ON ad.addon_id = a.addon_id
    ORDER BY ad.name ASC;
  """);

  addonSubscription = stream.listen((rows) {
    if (rows.isNotEmpty) {
      final row = Map<String, dynamic>.from(rows.first);
      print('AddOn : $row');
      callback(AddOnRow(row));
    }
  });
}

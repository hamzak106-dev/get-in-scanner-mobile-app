// Automatic FlutterFlow imports
// Imports other custom actions
// Imports custom functions
import 'package:flutter/material.dart';

import '/backend/supabase/supabase.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '../actions/init_power_sync.dart';

Future<AttendeeRow?> findAttendee(
  String? barcodeHash,
  List<int> eventIdList,
) async {
  String query = """
  SELECT 
  a.*,
  COALESCE(
    json_group_array(
      json_object(
        'addon_id', ao.addon_id,
        'status', aa.status,
        'image_url', ao.image_url,
        'name', ad.name,
        'lang', ad.lang,
        'description', ad.description,
        'attendee_add_on_id', aa.id
      )
    ) FILTER (WHERE ao.addon_id IS NOT NULL),
    '[]'
  ) AS add_ons
FROM attendee a
LEFT JOIN attendee_add_ons aa
  ON a.uid = aa.attendee_uid
LEFT JOIN add_ons ao
  ON ao.addon_id = aa.addon_id
LEFT JOIN add_on_descriptions ad
  ON ad.addon_id = ao.addon_id
WHERE 
  a.ticket_hash = '$barcodeHash'
  AND a.event_id IN (${eventIdList.join(', ')}) AND a.id IS NOT NULL
GROUP BY  a.uid;
  """;
  try {
    var rowData = await db.get(query);
    // "SELECT * FROM attendee WHERE ticket_hash = '$barcodeHash' AND event_id IN (${eventIdList.join(', ')})");
    // var attendee = AttendeeRow(Map<String, dynamic>.from(rowData));
    return AttendeeRow.mapAttendeeWithAddons(rowData);
  } catch (e) {
    debugPrint("ERROR ERROR ====>> ${e.toString()}");
    return null;
  }
}

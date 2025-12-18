// Automatic FlutterFlow imports
import 'dart:async';
import 'dart:convert';

import '/backend/supabase/supabase.dart';
// Imports other custom actions
// Imports custom functions

// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '../actions/init_power_sync.dart';

Future<void> watchAttendeeDetails(
  Future Function(List<AttendeeRow>? result) callback,
  int attendeeId,
) async {
  final watchQuery = """
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
    )FILTER (WHERE ao.addon_id IS NOT NULL),
    '[]'
  ) AS add_ons
  FROM attendee a
  LEFT JOIN attendee_add_ons aa
       ON a.uid = aa.attendee_uid
  LEFT JOIN add_ons ao
       ON ao.addon_id = aa.addon_id
  LEFT JOIN add_on_descriptions ad
       ON ad.addon_id = ao.addon_id
  WHERE a.uid = $attendeeId GROUP BY a.uid""";
  var stream = db.watch(watchQuery);
  // "SELECT * FROM attendee WHERE uid = $attendeeId");

  attendeeDetailsSubscription = stream.listen((data) {
    final attendes = data.map((json)=> AttendeeRow.mapAttendeeWithAddons(json)).toList();
    callback(attendes);
  });
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!

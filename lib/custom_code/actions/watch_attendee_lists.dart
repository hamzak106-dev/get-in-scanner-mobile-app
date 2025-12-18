// Automatic FlutterFlow imports
import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import '/backend/supabase/supabase.dart';
// Imports other custom actions
// Imports custom functions

// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '../actions/init_power_sync.dart';

// Future<void> watchAttendeeLists(
//     Future Function(List<AttendeeRow>? result) callback,
//     List<int> eventId,
//     bool onlyApproved) async {
//   var watchQuery = onlyApproved
//       ? "SELECT * FROM attendee WHERE event_id IN (${eventId.join(', ')}) AND ticket_status = 2 ORDER BY name ASC"
//       : "SELECT * FROM attendee WHERE event_id IN (${eventId.join(', ')}) ORDER BY name ASC";
//   var stream = db.watch(watchQuery);
//   attendeesSubscription = stream.listen((data) {
//     log('Received ${data.length} rows from attendee view');
//     callback(data
//         .map((json) => AttendeeRow(Map<String, dynamic>.from(json)))
//         .toList());
//   });
// }

Future<void> watchAttendeeLists(
    Future Function(List<AttendeeRow>? result) callback,
    List<int> eventId,
    bool onlyApproved) async {
  var watchQuery =
      onlyApproved
          ? """
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
  WHERE a.event_id IN (${eventId.join(', ')})
      AND a.ticket_status = 2
  GROUP BY a.uid
  ORDER BY a.name ASC;
  """
          : """
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
  WHERE a.event_id IN (${eventId.join(', ')})
  GROUP BY a.uid
  ORDER BY a.name ASC
""";

  var stream = db.watch(watchQuery);
  attendeesSubscription = stream.listen((data) {
    log(data.toString(), name: 'watchAttendeeLists');
    final attendes = data.map((json) {
      final row = AttendeeRow.mapAttendeeWithAddons(json);

      return row;
    }).toList();
    callback(attendes);
  });
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!

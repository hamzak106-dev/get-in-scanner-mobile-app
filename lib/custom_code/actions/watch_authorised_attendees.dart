// Automatic FlutterFlow imports
import 'dart:async';

import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
// Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import '/flutter_flow/flutter_flow_util.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '../actions/init_power_sync.dart';

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!

Future<void> watchAuthorisedAttendees(
    Future Function(List<AttendeeRow>? result) callback,
    List<int> eventIds,
    bool onlyApproved,
    AccessPermission permission) async {
  if (eventIds.isEmpty) return;
  String baseQuery = """
  SELECT
    a.*,
     COALESCE(
    json_group_array(
      json_object(
        'addon_id', ao.addon_id,
        'event_id', ao.event_id,
        'price', CAST(ao.price AS REAL),
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
   """;

  // Full access conditions
  bool hasFullAccess = FFAppState().user.profile == Profile.admin ||
      FFAppState().user.profile == Profile.producer ||
      FFAppState().user.profile == Profile.manager;

  String watchQuery;

  if (hasFullAccess) {
    // Full access query
    watchQuery =
        "$baseQuery WHERE a.event_id IN (${eventIds.join(', ')}) ${onlyApproved ? 'AND a.ticket_status = 2' : ''} GROUP BY a.uid ORDER BY a.name ASC";
    // "SELECT * FROM attendee WHERE event_id IN (${eventIds.join(', ')}) ${onlyApproved ? 'AND ticket_status = 2' : ''} ORDER BY name ASC";
  } else {
    // Restricted access based on event and ticket permissions

    var pinId = FFAppState().user.pinId;

    var pinData = await db.get('SELECT * FROM pin WHERE uid = $pinId');
    PinRow pinRow = PinRow(pinData);
    if (pinRow.type == 'SYSTEM') {
      watchQuery =
          "$baseQuery WHERE a.event_id IN (${eventIds.join(', ')}) ${onlyApproved ? 'AND a.ticket_status = 2' : ''} GROUP BY a.uid ORDER BY a.name ASC";
      // "SELECT * FROM attendee WHERE event_id IN (${eventIds.join(', ')}) ${onlyApproved ? 'AND ticket_status = 2' : ''} ORDER BY name ASC";
    } else {
      // Full access attendee list
      bool hasAccessPermission = getAccessPermissionAllow(
          FFAppState().user.permissions, permission, FFAppState().user.profile);
      if (!hasAccessPermission) return;

      // Allow permission for all events
      bool hasAllEventPermission = getAccessPermissionAllow(
          FFAppState().user.permissions,
          AccessPermission.allEvents,
          FFAppState().user.profile);

      if (hasAllEventPermission) {
        watchQuery =
            "$baseQuery WHERE a.event_id IN (${eventIds.join(', ')}) ${onlyApproved ? 'AND a.ticket_status = 2' : ''} GROUP BY a.uid ORDER BY a.name ASC";
        // "SELECT * FROM attendee WHERE event_id IN (${eventIds.join(', ')}) ${onlyApproved ? 'AND ticket_status = 2' : ''} ORDER BY name ASC";
      } else {
        String? allowEvents;
        if (pinRow.eventIds != null &&
            pinRow.eventIds!.isNotEmpty &&
            pinRow.eventIds != "null") {
          allowEvents = pinRow.eventIds
              ?.split(",")
              .map(int.parse)
              .where(eventIds.contains)
              .join(",");
        }

        if (allowEvents?.isNotEmpty ?? false) {
          watchQuery =
              "$baseQuery WHERE a.event_id IN ($allowEvents) ${onlyApproved ? 'AND a.ticket_status = 2' : ''} GROUP BY a.uid ORDER BY a.name ASC";
          // "SELECT * FROM attendee WHERE event_id IN ($allowEvents) ${onlyApproved ? 'AND ticket_status = 2' : ''} ORDER BY name ASC";
        } else {
          // Filter by allowed ticket IDs
          String allowTicketIds = "";
          var ticketResults = await db.getAll(
              'SELECT DISTINCT ticket_id FROM attendee WHERE event_id IN(${eventIds.join(",")}) AND ticket_id IN(${pinRow.ticketIds})');
          allowTicketIds = ticketResults
              .map((json) => json['ticket_id'].toString())
              .join(",");
          //
          watchQuery =
              "$baseQuery WHERE a.ticket_id IN ($allowTicketIds) ${onlyApproved ? 'AND a.ticket_status = 2' : ''} GROUP BY a.uid ORDER BY a.name ASC";
          // "SELECT * FROM attendee WHERE ticket_id IN ($allowTicketIds) ${onlyApproved ? 'AND ticket_status = 2' : ''} ORDER BY name ASC";
        }
      }
    }
  }

  // Start watching database changes
  var stream = db.watch(watchQuery);
  attendeesSubscription = stream.listen((data) {
    callback(data
        .map((json) => AttendeeRow.mapAttendeeWithAddons(json)) //AttendeeRow(Map<String, dynamic>.from(json)))
        .toList());
  });
}

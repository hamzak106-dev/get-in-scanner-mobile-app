// Automatic FlutterFlow imports
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
// Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions

// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '../actions/init_power_sync.dart';

import 'dart:async';

Future<List<EventsRow>> getEventsOfUser() async {
  if (getAccessPermissionAllow(FFAppState().user.permissions,
      AccessPermission.lookup, FFAppState().user.profile)) {
    var pinId = FFAppState().user.pinId;
    PinRow? pin;
    if (pinId > 0) {
      try {
        var pinData = await db.get('SELECT * FROM pin WHERE uid = $pinId');
        pin = PinRow(pinData);
      } catch (e) {
        print('getEventsOfUser: could not load pin uid=$pinId: $e');
        pin = null;
      }
    }

    var hasAllEvent = false;
    if (pin != null) {
      hasAllEvent = getAccessPermissionAllow(
          pin.permissions, AccessPermission.allEvents, FFAppState().user.profile);
    }

    if (pin != null && pin.type == 'ON_SITE_PIN' && !hasAllEvent) {
      List<dynamic> eventIds = [];
      try {
        eventIds = (await db.getAll(
                'SELECT DISTINCT event_id FROM attendee WHERE event_id IN(${pin.eventIds}) OR ticket_id IN(${pin.ticketIds})'))
            .map((json) => json.values[json.keys.indexOf('event_id')])
            .toList();
      } catch (e) {
        print('getEventsOfUser: db.getAll failed: $e');
        eventIds = [];
      }

      if (eventIds.isEmpty) return [];

      var allEvents = <EventsRow>[];
      try {
        allEvents = (await db.getAll(
                "SELECT * FROM events WHERE creator_user = ${FFAppState().user.userId} AND event_id IN (${eventIds.join(', ')}) ORDER BY start_date ASC"))
            .map((json) => EventsRow(Map<String, dynamic>.from(json)))
            .toList();
      } catch (e) {
        print('getEventsOfUser: failed to load events: $e');
        return [];
      }

      return allEvents;
    } else {
      try {
        var allEvents = (await db.getAll(
                "SELECT * FROM events WHERE creator_user = ${FFAppState().user.userId} ORDER BY start_date ASC"))
            .map((json) => EventsRow(Map<String, dynamic>.from(json)))
            .toList();
        return allEvents;
      } catch (e) {
        print('getEventsOfUser: failed to load events: $e');
        return [];
      }
    }
  } else {
    return [];
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!

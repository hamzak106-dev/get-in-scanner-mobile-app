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

import 'index.dart';

Future<void> watchAuthorisedEvents(Future Function(List<EventsRow>? results) callback) async {
  // Add your function code here!

  var pinId = FFAppState().user.pinId;
  PinRow? pin;

  // Safely attempt to load the pin row. db.get can throw if no row is found,
  // which previously caused a "Bad state: No element" when the result was empty.
  if (pinId > 0) {
    try {
      var pinData = await db.get('SELECT * FROM pin WHERE uid = $pinId');
      pin = PinRow(pinData);
    } catch (e) {
      print('watchAuthorisedEvents: could not load pin for uid=$pinId: $e');
      pin = null;
    }
  }

  // If pin is null, treat as no special permissions.
  var hasAllEvent = false;
  if (pin != null) {
    hasAllEvent = getAccessPermissionAllow(pin.permissions, AccessPermission.allEvents, FFAppState().user.profile);
  }

  String watchQuery = '';
  if (hasAllEvent || (pin?.type == 'SYSTEM')) {
    watchQuery = 'SELECT * FROM events WHERE creator_user = ${FFAppState().user.userId} ORDER BY start_date ASC';
  } else if (pin != null) {
    // If we have a pin and it's not SYSTEM, compute eventIds from attendee membership

    // Parse pin.eventIds and pin.ticketIds safely into numeric lists
    List<int> pinEventIds = [];
    List<int> pinTicketIds = [];
    if (pin.eventIds != null && pin.eventIds!.isNotEmpty && pin.eventIds != 'null') {
      try {
        pinEventIds = pin.eventIds!.split(',').map((s) => int.parse(s.trim())).toList();
      } catch (e) {
        print('watchAuthorisedEvents: failed to parse pin.eventIds="${pin.eventIds}": $e');
        pinEventIds = [];
      }
    }
    if (pin.ticketIds != null && pin.ticketIds!.isNotEmpty && pin.ticketIds != 'null') {
      try {
        pinTicketIds = pin.ticketIds!.split(',').map((s) => int.parse(s.trim())).toList();
      } catch (e) {
        print('watchAuthorisedEvents: failed to parse pin.ticketIds="${pin.ticketIds}": $e');
        pinTicketIds = [];
      }
    }

    // Build a safe WHERE clause for attendee membership
    String membershipWhere = '';
    if (pinEventIds.isNotEmpty) {
      membershipWhere = 'event_id IN(${pinEventIds.join(',')})';
    }
    if (pinTicketIds.isNotEmpty) {
      if (membershipWhere.isNotEmpty) membershipWhere += ' OR ';
      membershipWhere += 'ticket_id IN(${pinTicketIds.join(',')})';
    }

    List<dynamic> eventIds = [];
    if (membershipWhere.isNotEmpty) {
      try {
        var rows = await db.getAll('SELECT DISTINCT event_id FROM attendee WHERE $membershipWhere');
        eventIds = rows.map((json) => json.values[json.keys.indexOf('event_id')]).toList();
      } catch (e) {
        print('watchAuthorisedEvents: db.getAll failed for membershipWhere="$membershipWhere": $e');
        eventIds = [];
      }
    }

    if (eventIds.isNotEmpty) {
      watchQuery =
          'SELECT * FROM events WHERE creator_user = ${FFAppState().user.userId} AND event_id IN (${eventIds.join(', ')}) ORDER BY start_date ASC';
    } else {
      // No accessible events for this pin
      watchQuery = '';
    }
  } else {
    // No pin and no full access: nothing to watch
    watchQuery = '';
  }

  if (watchQuery.isNotEmpty) {
    var stream = db.watch(watchQuery);
    eventsSubscription = stream.listen((data) {
      callback(data.map((json) => EventsRow(Map<String, dynamic>.from(json))).toList());
    });
  } else {
    callback([]);
  }
}

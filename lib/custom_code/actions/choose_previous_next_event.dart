// Automatic FlutterFlow imports
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
// Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions

// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '../actions/init_power_sync.dart';

Future<List<EventsRow>> choosePreviousNextEvent(bool isNext, bool isUpcoming) async {
  // Add your function code here!

  var pinId = FFAppState().user.pinId;
  PinRow? pin;
  if (pinId > 0) {
    try {
      var pinData = await db.get('SELECT * FROM pin WHERE uid = $pinId');
      pin = PinRow(pinData);
    } catch (e) {
      print('choosePreviousNextEvent: could not load pin uid=$pinId: $e');
      pin = null;
    }
  }

  List<EventsRow> allEvents = [];
  var hasAllEvent = false;
  if (pin != null) {
    hasAllEvent = getAccessPermissionAllow(pin.permissions, AccessPermission.allEvents, FFAppState().user.profile);
  }

  String getEventQuery = '';
  if (hasAllEvent || pin?.type == 'SYSTEM') {
    getEventQuery = 'SELECT * FROM events WHERE creator_user = ${FFAppState().user.userId} ORDER BY start_date ASC';
  } else if (pin != null) {
    List<dynamic> eventIds = [];
    try {
      eventIds = (await db.getAll(
              'SELECT DISTINCT event_id FROM attendee WHERE event_id IN(${pin.eventIds}) OR ticket_id IN(${pin.ticketIds})'))
          .map((json) => json.values[json.keys.indexOf('event_id')])
          .toList();
    } catch (e) {
      print('choosePreviousNextEvent: db.getAll failed: $e');
      eventIds = [];
    }

    if (eventIds.isNotEmpty) {
      getEventQuery =
          'SELECT * FROM events WHERE creator_user = ${FFAppState().user.userId} AND event_id IN (${eventIds.join(', ')}) ORDER BY start_date ASC';
    } else {
      getEventQuery = '';
    }
  }

  if (getEventQuery.isNotEmpty) {
    try {
      var events = await db.getAll(getEventQuery);
      allEvents = events.map((json) => EventsRow(Map<String, dynamic>.from(json))).toList();
    } catch (e) {
      print('choosePreviousNextEvent: failed to load events: $e');
      allEvents = [];
    }
  }

  allEvents = allEvents
      .where((e) => isUpcoming
          ? (e.endDate.secondsSinceEpoch >= getCurrentTimestamp.secondsSinceEpoch)
          : (e.endDate.secondsSinceEpoch < getCurrentTimestamp.secondsSinceEpoch))
      .toList();

  var selectedEvents = parseEventRow(FFAppState().selectedEvent);
  if (selectedEvents.isEmpty) {
    throw Exception('Selected event not available');
  }
  var selectedEvent = selectedEvents.first;
  var indexOf = allEvents.indexWhere((e) => e.uid == selectedEvent.uid);

  if (indexOf == -1) {
    throw Exception("Selected event not found in allEvents");
  }

  if (isNext) {
    return indexOf == allEvents.length - 1 ? [selectedEvent] : [allEvents[indexOf + 1]];
  } else {
    return indexOf == 0 ? [selectedEvent] : [allEvents[indexOf - 1]];
  }
}

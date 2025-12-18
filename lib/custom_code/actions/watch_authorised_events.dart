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
  var pinData = await db.get('SELECT * FROM pin WHERE uid = $pinId');
  PinRow pin = PinRow(pinData);
  var hasAllEvent = getAccessPermissionAllow(pin.permissions, AccessPermission.allEvents, FFAppState().user.profile);
  String watchQuery;
  if (hasAllEvent || pin.type == 'SYSTEM') {
    watchQuery = 'SELECT * FROM events WHERE creator_user = ${FFAppState().user.userId} ORDER BY start_date ASC';
  } else {
    var eventIds = (await db.getAll(
            'SELECT DISTINCT event_id FROM attendee WHERE event_id IN(${pin.eventIds}) OR ticket_id IN(${pin.ticketIds})'))
        .map((json) => json.values[json.keys.indexOf('event_id')])
        .toList();
    watchQuery =
        'SELECT * FROM events WHERE creator_user = ${FFAppState().user.userId} AND event_id IN (${eventIds.join(', ')}) ORDER BY start_date ASC';
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

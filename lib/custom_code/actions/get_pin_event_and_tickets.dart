// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'init_power_sync.dart';

Future<PinEventStruct> getPinEventAndTickets(EventsRow event) async {
  // Add your function code here!

  var tickets = (await db.getAll(
          "SELECT distinct ticket_id, ticket_name FROM attendee WHERE event_id = ${event.eventId}"))
      .map((json) => PinTicketStruct.fromMap(Map<String, dynamic>.from(json)))
      .toList();

  return PinEventStruct(
      creatorUser: event.creatorUser,
      eventId: event.eventId,
      uid: event.uid,
      title: event.title,
      tickets: tickets);
}

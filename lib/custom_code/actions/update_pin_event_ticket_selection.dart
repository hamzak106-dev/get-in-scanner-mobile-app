// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
// Imports custom functions
import 'package:flutter/material.dart';

import 'init_power_sync.dart';

// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!


Future<List<PinEventStruct>> updatePinEventTicketSelection(
  String? eventIds,
  String? ticketIds,
) async {
  // Add your function code here!

  List<int> eventIDs = [];
  List<int> ticketIDs = [];

  List<EventsRow> events = (await db.getAll(
          "SELECT * FROM events WHERE creator_user = ${FFAppState().user.userId} ORDER BY start_date ASC"))
      .map((json) => EventsRow(Map<String, dynamic>.from(json)))
      .toList();

  try {
    eventIDs = eventIds?.split(",").map((e) => int.parse(e)).toList() ?? [];
  } catch (e) {
    debugPrint(e.toString());
  }
  try {
    ticketIDs = ticketIds?.split(",").map((e) => int.parse(e)).toList() ?? [];
  } catch (e) {
    debugPrint(e.toString());
  }

  if (eventIDs.isNotEmpty || ticketIDs.isNotEmpty) {
    List<PinEventStruct> pinEvents = [];
    for (var event in events) {
      PinEventStruct pinEvent = await getPinEventAndTickets(event);
      // Check if the event ID is in the eventIds list
      if (eventIDs.contains(pinEvent.eventId)) {
        pinEvent.isSelected = true;
        pinEvent.tickets.every((e) => e.isSelected = true);
        pinEvents.add(pinEvent);
      } else {
        List<PinTicketStruct> pinTickets = [];
        int selectedTicketCount = 0;
        for (var ticket in pinEvent.tickets) {
          if (ticketIDs.contains(ticket.ticketId)) {
            ticket.isSelected = true;
            selectedTicketCount++;
          }
          pinTickets.add(ticket);
        }
        if (selectedTicketCount > 0) {
          pinEvent.tickets = pinTickets;
          pinEvents.add(pinEvent);
        }
      }
    }
    return pinEvents;
  }
  return [];
}

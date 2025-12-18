// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';

// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

/// Set your action name, define your arguments and return parameter, and then
/// add the boilerplate code using the green button on the right!
Future<String> getPinEventIds(int pinId) async {
  debugPrint("📦 Fetching Pin data for pinId: $pinId");
  final pinRow = (await PinTable().queryRows(
    queryFn: (q) => q.eqOrNull('uid', pinId),
  ))
      .first;

  debugPrint("📌 Pin fetched: Type = ${pinRow.type}, EventIds = ${pinRow.eventIds}, TicketIds = ${pinRow.ticketIds}");

  if (pinRow.type == PinType.ON_SITE_PIN.name &&
      getAccessPermissionAllow(pinRow.permissions, AccessPermission.allEvents, Profile.scanner)) {
    var events = await EventsTable().queryRows(
      queryFn: (q) => q
          .eqOrNull(
            'creator_user',
              pinRow.userId,
          )
          .neqOrNull('priority', 4),
    );
    final ids = events.map((e) => e.eventId).toList();
    debugPrint("✅ Found All Event Permission IDs: $ids");
    return jsonEncode(ids);
  }
  // Check direct eventIds
  if (pinRow.eventIds != null && pinRow.eventIds!.isNotEmpty && pinRow.eventIds != "null") {
    final ids = pinRow.eventIds!.split(",").map((e) => int.parse(e)).toList();
    debugPrint("✅ Found direct event IDs: $ids");
    return jsonEncode(ids);
  }

  // Check ticketIds and get eventIds from Attendees
  if (pinRow.ticketIds != null && pinRow.ticketIds!.isNotEmpty && pinRow.ticketIds != "null") {
    final ticketIds = pinRow.ticketIds!.split(",").map((e) => int.parse(e)).toList();
    debugPrint("🎟️ Found ticket IDs: $ticketIds");

    final attendees = await AttendeeTable().queryRows(
      queryFn: (q) => q.inFilter('ticket_id', ticketIds),
    );
    final eventIds = attendees.map((e) => e.eventId).toSet().toList();
    debugPrint("📋 Event IDs extracted from attendees: $eventIds");

    return jsonEncode(eventIds);
  }

  debugPrint("⚠️ No valid event or ticket IDs found. Returning empty.");
  return "";
}

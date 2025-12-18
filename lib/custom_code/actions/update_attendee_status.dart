// Automatic FlutterFlow imports
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import 'index.dart'; // Imports other custom actions
// Imports custom functions
import 'package:flutter/material.dart';

// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '../actions/init_power_sync.dart';

Future updateAttendeeStatus(
  AttendeeRow? attendee,
  int logId,
  ScanResult status,
  String? scanAt,
) async {
  try {
    var result = await db.execute(
        "UPDATE attendee SET status = '${status.name}' WHERE uid = '${attendee?.uid.toString()}'");

    debugPrint("============= Updated Attendee Status result ============");
    debugPrint(attendee?.uid.toString());
    debugPrint("===============================");

    broadcastMessage(
        attendee!.ticketHash, logId, attendee.eventId, status.index, scanAt);
  } catch (e) {
    debugPrint("============= Update Attendee Status ERROR ============");
    debugPrint(e.toString());
    debugPrint("===============================");
  }
}

// Automatic FlutterFlow imports
import 'package:g_e_t_i_n_scanner/backend/supabase/database/database.dart';

import '/backend/schema/enums/enums.dart';

// Imports other custom actions
// Imports custom functions
import 'package:flutter/material.dart';

// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Imports other custom actions

import '../actions/init_power_sync.dart';
import 'update_attendee_status.dart';

Future addCheckInLog(ScanResult status, int id, AttendeeRow? attendee, int? deviceId, int? eventId,
    int? userId, String? scanAt, String? scanResult) async {
  try {
    // Define the query to insert a row into the checkInLogs table
    const query =
        'INSERT INTO check_in_logs (id, attendee_id, event_id, user_id, device_id, status, scan_at, scan_result) VALUES (?, ?, ?, ?, ?, ?, ?, ?)';

    await db.execute(query, [
      id.toString(),
      attendee?.uid.toString(),
      eventId,
      userId,
      deviceId,
      status.name,
      scanAt,
      scanResult
    ]);

    if (status == ScanResult.CHECK_IN || status == ScanResult.CHECK_OUT) {
      await updateAttendeeStatus(
        attendee,
        id,
        status,
        scanAt,
      );
    }
  } catch (e) {
    debugPrint("\n\n============= Add Check In Logs ERROR ============");
    debugPrint(e.toString());
    debugPrint("==================================================\n\n");
  }
  // Insert data into the 'checkInLogs' table
}

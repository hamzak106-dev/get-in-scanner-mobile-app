// Automatic FlutterFlow imports
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
// Imports custom functions
import 'package:flutter/material.dart';

// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Imports other custom actions

import '../actions/init_power_sync.dart';



Future updateTicketOnLocalNetwork(
  String barcodeHash,
  int deviceId,
  int logId,
  String scanAt,
  int eventId,
  ScanResult scanStatus,
) async {
  // Add your function code here!
  debugPrint('UpdateTicketOnLocalNetwork Called');

  final ticket = await findAttendee(barcodeHash, [eventId]);

  if (ticket != null && ticket.status != scanStatus.name) {
    try {
      await db.execute(
          "UPDATE attendee SET status = '${scanStatus.name}' WHERE uid = '${ticket.uid.toString()}'");
    } catch (e) {
      debugPrint("============= Update Attendee Status ERROR ============");
      debugPrint(e.toString());
      debugPrint("===============================");
    }

    debugPrint('\nTickets Update : ${ticket.uid}');

    try {
      const query =
          'INSERT INTO check_in_logs (id, attendee_id, event_id, user_id, device_id, status, scan_at, scan_result) VALUES (?, ?, ?, ?, ?, ?, ?, ?)';

      await db.execute(query, [
        logId.toString(),
        ticket.uid.toString(),
        ticket.eventId,
        FFAppState().user.userId,
        deviceId,
        scanStatus.name,
        scanAt,
        barcodeHash
      ]);
    } catch (e) {
      debugPrint("============= Add Check In Logs ERROR ============");
      debugPrint(e.toString());
      debugPrint("===============================");
    }
  }
}

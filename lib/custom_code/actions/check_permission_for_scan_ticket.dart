// Automatic FlutterFlow imports
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
// Imports other custom actions
// Imports custom functions
import 'package:flutter/material.dart';
import '/custom_code/actions/index.dart' as actions;

// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Imports other custom actions

import '../actions/init_power_sync.dart';

Future<ScanResult> checkPermissionForScanTicket(
  String? barcodeHash,
  List<int> eventIdList,
) async {
  try {
    // Early validation
    if (barcodeHash == null || eventIdList.isEmpty) {
      return ScanResult.NOT_FOUND;
    }

    bool isAdmin = FFAppState().user.profile == Profile.admin ||
        FFAppState().user.profile == Profile.producer;

    // If admin, return valid
    if (isAdmin) return ScanResult.VALID;

    if (FFAppState().user.profile == Profile.manager &&
        FFAppState().selectedProducer.firstName.isNotEmpty)
      return ScanResult.VALID;

    var pinId = FFAppState().user.pinId;
    PinRow? pinRow;
    if (pinId > 0) {
      try {
        var pinData = await db.get('SELECT * FROM pin WHERE uid = $pinId');
        pinRow = PinRow(pinData);
      } catch (e) {
        print('checkPermissionForScanTicket: could not load pin uid=$pinId: $e');
        pinRow = null;
      }

      // Check system access or all events permission
      if (pinRow != null && (pinRow.type == 'SYSTEM' ||
          await actions.isPermissionSelected(
              pinRow.permissions, AccessPermission.allEvents))) {
        return ScanResult.VALID;
      }
    }

    try {
      var rowData = await db.get(
          "SELECT event_id, ticket_id FROM attendee WHERE ticket_hash = '$barcodeHash' AND event_id IN (${eventIdList.join(', ')})");
      var attendee = AttendeeRow(Map<String, dynamic>.from(rowData));

      List<int> events = [];
      if (pinRow != null && pinRow.eventIds != null &&
          pinRow.eventIds!.isNotEmpty && pinRow.eventIds != "null") {
        try {
          events = pinRow.eventIds
                  ?.split(",")
                  .toList()
                  .map((e) => int.parse(e))
                  .toList() ??
              [];
        } catch (e) {
          print('checkPermissionForScanTicket: failed to parse pinRow.eventIds: $e');
          events = [];
        }
      }
      List<int> tickets = [];
      if (pinRow != null && pinRow.ticketIds != null &&
          pinRow.ticketIds!.isNotEmpty && pinRow.ticketIds != "null") {
        try {
          tickets = pinRow.ticketIds
                  ?.split(",")
                  .toList()
                  .map((e) => int.parse(e))
                  .toList() ??
              [];
        } catch (e) {
          print('checkPermissionForScanTicket: failed to parse pinRow.ticketIds: $e');
          tickets = [];
        }
      }
      if (events.contains(attendee.eventId) ||
          tickets.contains(attendee.ticketId)) {
        return ScanResult.VALID;
      }
    } catch (e) {
      debugPrint(e.toString());
      return ScanResult.NOT_FOUND;
    }
    return ScanResult.NOT_ALLOW;
  } catch (e) {
    debugPrint("ERROR ERROR ====>> ${e.toString()}");
    return ScanResult.NOT_FOUND;
  }
}

// Automatic FlutterFlow imports
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
// Imports other custom actions
// Imports custom functions
import '/custom_code/actions/index.dart' as actions;

// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '../actions/init_power_sync.dart';

Future watchAuthorisedCheckInLogs(
  Future Function(List<CheckInLogsRow>? result) callback,
  List<int> eventIds,
) async {
  if (eventIds.isEmpty) return;

  // Full access conditions
  bool hasFullAccess = FFAppState().user.profile == Profile.admin ||
      FFAppState().user.profile == Profile.producer ||
      FFAppState().user.profile == Profile.manager;

  String watchQuery = '';

  if (hasFullAccess) {
    // Full access query
    watchQuery = "SELECT * FROM check_in_logs WHERE event_id IN (${eventIds.join(', ')}) ORDER BY scan_at DESC";
  } else {
    // Restricted access: Only allow logs for permitted events

    var pinId = FFAppState().user.pinId;
    PinRow? pin;
    if (pinId > 0) {
      try {
        var pinData = await db.get('SELECT * FROM pin WHERE uid = $pinId');
        pin = PinRow(pinData);
      } catch (e) {
        print('watchAuthorisedCheckInLogs: could not load pin uid=$pinId: $e');
        pin = null;
      }
    }

    if (pin != null && (pin.type == 'SYSTEM' || await actions.isPermissionSelected(pin.permissions, AccessPermission.allEvents))) {
      watchQuery = "SELECT * FROM check_in_logs WHERE event_id IN (${eventIds.join(', ')}) ORDER BY scan_at DESC";
    } else if (pin != null) {
      String? allowEvents;
      if (pin.eventIds != null && pin.eventIds!.isNotEmpty && pin.eventIds != "null") {
        try {
          allowEvents = pin.eventIds?.split(",").map((s) => int.parse(s.trim())).where(eventIds.contains).join(",");
        } catch (e) {
          print('watchAuthorisedCheckInLogs: failed to parse pin.eventIds="${pin.eventIds}": $e');
          allowEvents = null;
        }
      }

      if (allowEvents?.isNotEmpty ?? false) {
        watchQuery = "SELECT * FROM check_in_logs WHERE event_id IN ($allowEvents) ORDER BY scan_at DESC";
      } else if (pin.ticketIds != null && pin.ticketIds!.isNotEmpty && pin.ticketIds != 'null') {
        // Filter by allowed attendee IDs derived from ticketIds
        String allowAttendeeIds = "";
        try {
          var attendeeIdResult = await db.getAll(
              'SELECT DISTINCT uid FROM attendee WHERE event_id IN(${eventIds.join(",")}) AND ticket_id IN(${pin.ticketIds})');
          allowAttendeeIds = attendeeIdResult.map((json) => json['uid'].toString()).join(",");
        } catch (e) {
          print('watchAuthorisedCheckInLogs: db.getAll failed when building attendee ids: $e');
          allowAttendeeIds = '';
        }

        if (allowAttendeeIds.isNotEmpty) {
          watchQuery = "SELECT * FROM check_in_logs WHERE attendee_id IN ($allowAttendeeIds) ORDER BY scan_at DESC";
        } else {
          watchQuery = '';
        }
      } else {
        watchQuery = '';
      }
    } else {
      watchQuery = '';
    }
  }

  if (watchQuery.isEmpty) {
    callback([]);
    return;
  }

  // Start watching database changes
  var stream = db.watch(watchQuery);
  await actions.cancelSubscription(checkInLogsSubscription);
  checkInLogsSubscription = stream.listen((data) {
    callback(data.map((json) => CheckInLogsRow(Map<String, dynamic>.from(json))).toList());
  });
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!

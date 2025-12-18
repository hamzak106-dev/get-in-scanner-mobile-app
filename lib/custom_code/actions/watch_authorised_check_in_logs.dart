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

  String watchQuery;

  if (hasFullAccess) {
    // Full access query
    watchQuery = "SELECT * FROM check_in_logs WHERE event_id IN (${eventIds.join(', ')}) ORDER BY scan_at DESC";
  } else {
    // Restricted access: Only allow logs for permitted events

    var pinId = FFAppState().user.pinId;
    var pinData = await db.get('SELECT * FROM pin WHERE uid = $pinId');
    PinRow pin = PinRow(pinData);

    if (pin.type == 'SYSTEM' || await actions.isPermissionSelected(pin.permissions, AccessPermission.allEvents)) {
      watchQuery = "SELECT * FROM check_in_logs WHERE event_id IN (${eventIds.join(', ')}) ORDER BY scan_at DESC";
    } else {
      String? allowEvents;
      if (pin.eventIds != null && pin.eventIds!.isNotEmpty && pin.eventIds != "null") {
        allowEvents = pin.eventIds?.split(",").map(int.parse).where(eventIds.contains).join(",");
      }

      if (allowEvents?.isNotEmpty ?? false) {
        watchQuery = "SELECT * FROM check_in_logs WHERE event_id IN ($allowEvents) ORDER BY scan_at DESC";
      } else {
        // Filter by allowed ticket IDs
        String allowAttendeeIds = "";
        var attendeeIdResult = await db.getAll(
            'SELECT DISTINCT uid FROM attendee WHERE event_id IN(${eventIds.join(",")}) AND ticket_id IN(${pin.ticketIds})');
        allowAttendeeIds = attendeeIdResult.map((json) => json['uid'].toString()).join(",");

        watchQuery = "SELECT * FROM check_in_logs WHERE attendee_id IN ($allowAttendeeIds) ORDER BY scan_at DESC";
      }
    }
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

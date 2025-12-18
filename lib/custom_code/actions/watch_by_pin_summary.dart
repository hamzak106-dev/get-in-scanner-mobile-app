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

import '../actions/init_power_sync.dart';

Future watchByPinSummary(
  Future Function(List<SummaryStruct>? pinSummary) callback,
  List<int> eventIds,
  int userId,
) async {
  // Add your function code here!
  if (eventIds.isEmpty) return;

  // String watchQuery = "SELECT "
  //     "p.pin AS value, "
  //     "p.name AS name, "
  //     "COUNT(cl.uid) AS total_logs, "
  //     "SUM(CASE WHEN cl.status = 'CHECK_IN' THEN 1 ELSE 0 END) AS total_checkins, "
  //     "SUM(CASE WHEN cl.status = 'CHECK_OUT' THEN 1 ELSE 0 END) AS total_checkouts, "
  //     "COUNT(DISTINCT cl.attendee_id) AS total_attendees "
  //     "FROM pin p "
  //     "JOIN device d ON d.pin_id = p.uid "
  //     "JOIN check_in_logs cl ON cl.device_id = d.uid "
  //     "WHERE cl.event_id IN (${eventIds.join(',')}) "
  //     "GROUP BY p.pin, p.name "
  //     "ORDER BY p.pin";

  // WITH latest_logs AS (
  //   SELECT cl.*
  //   FROM check_in_logs cl
  //   INNER JOIN (
  //     SELECT attendee_id, MAX(scan_at) AS max_scan_at
  //     FROM check_in_logs
  //     WHERE event_id IN (${eventIds.join(',')})
  //     GROUP BY attendee_id
  //   ) latest ON cl.attendee_id = latest.attendee_id AND cl.scan_at = latest.max_scan_at
  //   WHERE cl.event_id IN (${eventIds.join(',')})
  // )

  String watchQuery = """
    WITH latest_logs AS (
  -- pick the single most‐recent log per attendee for the given events
  SELECT cl.*
  FROM check_in_logs cl
  INNER JOIN (
    SELECT attendee_id, MAX(scan_at) AS max_scan_at
    FROM check_in_logs
    WHERE status = 'CHECK_IN'
      AND event_id IN (${eventIds.join(',')})
    GROUP BY attendee_id
  ) grp 
    ON cl.attendee_id = grp.attendee_id
   AND cl.scan_at     = grp.max_scan_at
  WHERE cl.event_id IN (${eventIds.join(',')})
)
SELECT
  p.pin                          AS value,
  p.name                         AS name,
  COUNT(ll.uid)                  AS total_logs,
  SUM(CASE WHEN ll.status = 'CHECK_IN'  THEN 1 ELSE 0 END) AS total_checkins,
  SUM(CASE WHEN ll.status = 'CHECK_OUT' THEN 1 ELSE 0 END) AS total_checkouts,
  COUNT(DISTINCT ll.attendee_id) AS total_attendees
FROM latest_logs ll
JOIN device d ON ll.device_id = d.uid
JOIN pin    p ON d.pin_id     = p.uid
GROUP BY p.pin, p.name
ORDER BY total_checkins DESC, total_attendees DESC
    """;

  print(watchQuery);

  // Start watching database changes
  var stream = db.watch(watchQuery);

  byPinSubscription = stream.listen((data) {
    callback(data.map((json) => SummaryStruct.fromMap(Map<String, dynamic>.from(json))).toList());
  });
}

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

Future watchByDeviceSummary(
  Future Function(List<SummaryStruct>? devicesSummary) callback,
  List<int> eventIds,
) async {
  // Add your function code here!
  if (eventIds.isEmpty) return;

  String watchQuery = """
          WITH latest_checkins AS (
            SELECT cl1.*
            FROM check_in_logs cl1
            INNER JOIN (
              SELECT attendee_id, MAX(scan_at) AS max_scan_at
              FROM check_in_logs
              WHERE status = 'CHECK_IN'
                AND event_id IN (${eventIds.join(',')})
              GROUP BY attendee_id
            ) cl2 ON cl1.attendee_id = cl2.attendee_id AND cl1.scan_at = cl2.max_scan_at
            WHERE cl1.event_id IN (${eventIds.join(',')})
          )
          SELECT 
            d.uid AS value,
            d.name AS name,
            COUNT(DISTINCT lc.attendee_id) AS total_attendees,
            SUM(CASE WHEN lc.status = 'CHECK_IN' THEN 1 ELSE 0 END) AS total_checkins,
            SUM(CASE WHEN lc.status IN ('CHECK_IN','CHECK_OUT') THEN 0 ELSE 1 END) AS total_absent,
            COUNT(lc.uid) AS total_logs
          FROM device d
          INNER JOIN latest_checkins lc ON d.uid = lc.device_id
          GROUP BY d.uid, d.name
          ORDER BY total_checkins DESC, total_attendees DESC;
          """;

  print(watchQuery);

  // Start watching database changes
  var stream = db.watch(watchQuery);

  byDeviceSubscription = stream.listen((data) {
    callback(data.map((json) => SummaryStruct.fromMap(Map<String, dynamic>.from(json))).toList());
  });
}


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

Future watchByTicketSummary(
  Future Function(List<SummaryStruct>? ticketsSummary) callback,
  List<int> eventIds,
) async {
  // Add your function code here!
  if (eventIds.isEmpty) return;

  // String watchQuery = "SELECT "
  //     "a.ticket_id AS value, "
  //     "a.ticket_name AS name, "
  //     "COUNT(DISTINCT a.uid) AS total_attendees, "
  //     "SUM(CASE WHEN cl.status = 'CHECK_IN' THEN 1 ELSE 0 END) AS total_checkins, "
  //     "SUM(CASE WHEN cl.status IN ('CHECK_IN','CHECK_OUT') THEN 0 ELSE 1 END) AS total_absent, "
  //     "COUNT(cl.uid) AS total_logs "
  //     "FROM attendee a "
  //     // "LEFT JOIN check_in_logs cl ON a.uid = cl.attendee_id "
  //     "LEFT JOIN LATERAL ( "
  //     "SELECT * FROM check_in_logs cl2 "
  //     "WHERE cl2.attendee_id = a.uid AND cl2.status = 'CHECK_IN' "
  //     "LIMIT 1 "
  //     ") cl ON true "
  //     "WHERE a.event_id IN (${eventIds.join(',')}) AND a.ticket_status = 2 "
  //     "GROUP BY a.ticket_id, a.ticket_name "
  //     "ORDER BY total_checkins DESC, total_attendees DESC";

  String watchQuery = """
          WITH latest_checkins AS (
            SELECT cl1.*
            FROM check_in_logs cl1
            INNER JOIN (
              SELECT attendee_id, MAX(scan_at) AS max_scan_at
              FROM check_in_logs
              WHERE status = 'CHECK_IN'
              GROUP BY attendee_id
            ) cl2 ON cl1.attendee_id = cl2.attendee_id AND cl1.scan_at = cl2.max_scan_at
          )
          SELECT 
            a.ticket_id AS value,
            a.ticket_name AS name,
            COUNT(DISTINCT a.uid) AS total_attendees,
            SUM(CASE WHEN lc.status = 'CHECK_IN' THEN 1 ELSE 0 END) AS total_checkins,
            SUM(CASE WHEN lc.status IN ('CHECK_IN','CHECK_OUT') THEN 0 ELSE 1 END) AS total_absent,
            COUNT(lc.uid) AS total_logs
          FROM attendee a
          LEFT JOIN latest_checkins lc ON a.uid = lc.attendee_id
          WHERE a.event_id IN (${eventIds.join(',')}) AND a.ticket_status = 2
          GROUP BY a.ticket_id, a.ticket_name
          ORDER BY total_checkins DESC, total_attendees DESC;
          """;

  print(watchQuery);

  // Start watching database changes
  var stream = db.watch(watchQuery);



  byTicketSubscription = stream.listen((data) {
    callback(data.map((json) => SummaryStruct.fromMap(Map<String, dynamic>.from(json))).toList());
  });
}

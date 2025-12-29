// Automatic FlutterFlow imports
// Imports other custom actions
// Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '../actions/init_power_sync.dart';

Future<List<Map<String, dynamic>>> getDeviceTickets(
  int deviceId,
  List<int> eventIds,
) async {
  // Add your function code here!
  if (eventIds.isEmpty) return [];

  try {
    final eventIdsString = eventIds.join(',');

    final query = """
SELECT 
  a.ticket_id,
  a.ticket_name,
  COUNT(DISTINCT a.uid) AS scan_count,
  cl.event_id
FROM attendee a
INNER JOIN check_in_logs cl ON cl.attendee_id = a.uid
WHERE a.ticket_status = 2
  AND cl.device_id = $deviceId
  AND cl.event_id IN ($eventIdsString)
GROUP BY a.ticket_id, a.ticket_name, cl.event_id
ORDER BY cl.event_id, a.ticket_name ASC;

""";

//     final query = """
// WITH device_tickets AS (
//   SELECT DISTINCT
//     a.ticket_id,
//     a.ticket_name
//   FROM check_in_logs cl
//   INNER JOIN attendee a ON cl.attendee_id = a.uid
//   WHERE cl.device_id = $deviceId
//     AND cl.event_id IN ($eventIdsString)
//     AND a.ticket_status = 2
// )
// SELECT
//   dt.ticket_id,
//   dt.ticket_name,
//   COUNT(DISTINCT cl2.device_id) AS device_count
// FROM device_tickets dt
// INNER JOIN attendee a2 ON a2.ticket_id = dt.ticket_id
// INNER JOIN check_in_logs cl2 ON cl2.attendee_id = a2.uid
//   AND cl2.event_id IN ($eventIdsString)
// WHERE a2.ticket_status = 2
// GROUP BY dt.ticket_id, dt.ticket_name
// ORDER BY dt.ticket_name ASC
// """;



    final results = await db.getAll(query);
    return results;
  } catch (e) {
    debugPrint('Error fetching device tickets: $e');
    return [];
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!


import 'dart:developer';

import 'package:g_e_t_i_n_scanner/backend/supabase/database/database.dart';
import 'package:g_e_t_i_n_scanner/custom_code/actions/init_power_sync.dart';

Future<EventsRow?> getEventByEventId(int eventId) async {
  final eventData =
      await db.get("SELECT * FROM events WHERE event_id = $eventId LIMIT 1");
  log("Event Data: $eventData");
  final event = EventsRow(Map<String, dynamic>.from(eventData));
  return event;
}

import 'dart:developer';

import 'package:g_e_t_i_n_scanner/app_state.dart';
import 'package:g_e_t_i_n_scanner/custom_code/actions/init_power_sync.dart';

Future<int?> getPosEventId() async {
  try{

  final query = """
    SELECT event_id
    FROM events
    WHERE creator_user = ${FFAppState().user.userId}
    AND date(end_date) >= date('now') AND is_available_pos = 1 LIMIT 1;
  """;

  final result = await db.get(query);
  log("POS Event ID Result: ${result['event_id']}");
  if (result.isNotEmpty) {
    return result['event_id'] as int;
  }
  return null;
  } catch(e){
    log("Error fetching POS Event ID: ${e.toString()}");
    return null;
  }
}

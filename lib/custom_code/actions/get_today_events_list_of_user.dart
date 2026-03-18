// Automatic FlutterFlow imports
import 'package:g_e_t_i_n_scanner/app_state.dart';
import 'package:g_e_t_i_n_scanner/custom_code/actions/init_power_sync.dart';
import 'package:g_e_t_i_n_scanner/flutter_flow/firebase_remote_config_util.dart';

import '/backend/supabase/supabase.dart';

// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<List<EventsRow>?> getTodayEventsListOfUser() async {
  final isPOSAvailable = getRemoteConfigBool('is_available_pos');
//   SELECT *
// FROM events
// WHERE creator_user = ${FFAppState().user.userId}
//   AND date('now') BETWEEN date(start_date) AND date(end_date);
  final query = """
SELECT *
FROM events
WHERE
date(end_date) >= date('now') ${isPOSAvailable == true ? 'AND is_available_pos = 1' : ''};
  """;
// WHERE creator_user = ${FFAppState().user.userId} AND
  return db.getAll(query).then((data) {
    return data
        .map((json) => EventsRow(Map<String, dynamic>.from(json)))
        .toList();
  }).catchError((error) {
    print('Error fetching today\'s events: $error');
    return <EventsRow>[];
  });
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!

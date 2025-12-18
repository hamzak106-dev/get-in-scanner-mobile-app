// Automatic FlutterFlow imports
import 'package:flutter/material.dart';

import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
// Imports other custom actions
// Imports custom functions

// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '../actions/init_power_sync.dart';

import 'dart:async';

import 'index.dart';

Future<void> watchEventsLists(Future Function(List<EventsRow>? result) callback) async {
  if (FFAppState().user.profile == Profile.admin) {
    var stream =
        db.watch('SELECT * FROM events WHERE start_date >= CAST(CURRENT_TIMESTAMP AS DATE) ORDER BY start_date ASC');
    eventsSubscription = stream.listen((data) {
      callback(data.map((json) => EventsRow(Map<String, dynamic>.from(json))).toList());
    });
  } else {
    var stream = db.watch('''SELECT * FROM events 
             WHERE creator_user = ${FFAppState().user.userId} 
             OR ${FFAppState().user.userId} IN 
             (SELECT value FROM json_each(manager_ids)) 
             AND start_date >= CAST(CURRENT_TIMESTAMP AS DATE) 
             ORDER BY start_date ASC''');
    eventsSubscription = stream.listen((data) {
      callback(data.map((json) => EventsRow(Map<String, dynamic>.from(json))).toList());
    }, onError: (value, value1) {
      debugPrint("Error watching events: $value");
      debugPrint("Error watching events: $value1");
    });
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!

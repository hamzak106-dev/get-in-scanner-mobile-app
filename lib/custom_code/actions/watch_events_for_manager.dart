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

import 'package:powersync/powersync.dart' as powersync;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:async';

Future<void> watchEventsForManager(int producerId, Future Function(List<EventsRow>? result) callback) async {


  String watchQuery = "";
  if (FFAppState().user.userId == producerId) {
    watchQuery = '''SELECT * FROM events 
             WHERE creator_user = $producerId
             AND start_date >= CAST(CURRENT_TIMESTAMP AS DATE) 
             ORDER BY start_date ASC''';
  } else {
    watchQuery = '''SELECT * FROM events 
             WHERE creator_user = $producerId
             AND ${FFAppState().user.userId} IN 
             (SELECT value FROM json_each(manager_ids)) 
             AND start_date >= CAST(CURRENT_TIMESTAMP AS DATE) 
             ORDER BY start_date ASC''';
  }
  var stream = db.watch(watchQuery);
  eventsSubscription = stream.listen((data) {
    callback(data.map((json) => EventsRow(Map<String, dynamic>.from(json))).toList());
  }, onError: (value, value1) {
    debugPrint("Error watching manager events: $value");
    debugPrint("Error watching manager events: $value1");
  });
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!

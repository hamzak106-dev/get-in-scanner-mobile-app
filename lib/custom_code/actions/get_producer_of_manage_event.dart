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
import 'dart:async';

Future<List<CreatorsRow>> getProducerOfManageEvent() async {
  // Add your function code here!
  var allProducers = (await db.getAll(
          "SELECT c.* FROM creators c WHERE c.user_id IN (SELECT e.creator_user FROM events e WHERE ${FFAppState().user.userId} IN (SELECT value FROM json_each(e.manager_ids))) ${FFAppState().user.isProducer == 1 ? "OR c.user_id = ${FFAppState().user.userId}" : ""}"))
      .map((json) => CreatorsRow(Map<String, dynamic>.from(json)))
      .toList();
  return allProducers;
}

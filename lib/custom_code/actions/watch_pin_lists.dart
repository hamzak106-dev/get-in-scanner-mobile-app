// Automatic FlutterFlow imports
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '../actions/init_power_sync.dart';

import 'dart:async';

import 'index.dart';

Future<void> watchPinLists(Future Function(List<PinRow>? result) callback) async {
  var stream = db.watch('SELECT * FROM pin WHERE user_id = ${FFAppState().user.userId};');
  await cancelSubscription(listsSubscription);
  listsSubscription = stream.listen((data) {
    callback(data.map((json) => PinRow(Map<String, dynamic>.from(json))).toList());
  });
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!

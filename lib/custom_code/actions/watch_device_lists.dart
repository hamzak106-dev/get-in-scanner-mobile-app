// Automatic FlutterFlow imports
import '/backend/supabase/supabase.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '../actions/init_power_sync.dart';

import 'dart:async';

import 'index.dart';

Future watchDeviceLists(
  Future Function(List<DeviceRow>? result) callback,
  List<int> pinList,
) async {
  var stream = db.watch("SELECT * FROM device WHERE pin_id IN (${pinList.join(', ')})");

  deviceSubscription = stream.listen((data) {
    callback(data.map((json) => DeviceRow(Map<String, dynamic>.from(json))).toList());
  });
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!

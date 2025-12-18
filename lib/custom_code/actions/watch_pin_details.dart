// Automatic FlutterFlow imports
import '/backend/supabase/supabase.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '../actions/init_power_sync.dart';

import 'dart:async';

import 'index.dart';

Future<void> watchPinDetails(
  Future Function(PinRow? result) callback,
  int pinId,
) async {
  var stream = db.watch('SELECT * FROM pin WHERE uid = $pinId;');

  pinSubscription = stream.listen((data) {
    callback(data.map((json) => PinRow(Map<String, dynamic>.from(json))).toList().firstOrNull);
  });
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!

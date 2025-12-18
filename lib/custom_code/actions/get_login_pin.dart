// Automatic FlutterFlow imports
import '/backend/supabase/supabase.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '../actions/init_power_sync.dart';

import 'dart:async';

Future<PinRow?> getLoginPin(String accessCode) async {
  try {
    var rowData = await db
        .get("SELECT * FROM pin WHERE access_code = '${accessCode.trim()}'");

    return PinRow(Map<String, dynamic>.from(rowData));
  } catch (e) {
    return null;
  }
}

// Automatic FlutterFlow imports
import '/backend/supabase/supabase.dart';
// Imports other custom actions
// Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<bool> isAdminDevice(int deviceUid) async {
  // Add your function code here!
  final supabase = SupaFlow.client;
  try {
    var response =
        supabase.from('device').select('isAdmin').eq('uid', deviceUid).single();
    var isAdmin = await response.then((value) {
      return value.values.first;
    });
    return isAdmin;
  } catch (e) {
    debugPrint('An error occurred: $e');
    return false;
  }
}

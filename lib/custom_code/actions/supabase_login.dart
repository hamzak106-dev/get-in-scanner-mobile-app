import '../../config/flavor_helper.dart';
import '/backend/supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';

Future<void> supabaseLogin() async {
  // Ensure Supabase is initialized. Accessing Supabase.instance.client will throw
  // an assertion if the SDK hasn't been initialized yet, so catch and initialize.
  try {
    // Try a cheap access to ensure instance is available.
    // This will throw an AssertionError if not initialized.
    final _ = Supabase.instance;
  } catch (e) {
    debugPrint('Supabase not initialized, initializing now: $e');
    await SupaFlow.initialize();
  }

  try {
    final client = Supabase.instance.client;
    if (client.auth.currentUser == null) {
      var email = FlavorHelper.appFlavor.sbEmail;
      debugPrint("\n\nAuth Email \n$email");
      var sbPwd = FlavorHelper.appFlavor.sbPassword;
      debugPrint("\n\nAuth PWD \n$sbPwd");
      var authResponse = await client.auth.signInWithPassword(
        email: email,
        password: sbPwd,
      );
      debugPrint("\n\nAuth Response \n${authResponse.user}");
      debugPrint("\n\nAuth Response \n${authResponse.session?.accessToken}");
    } else {
      debugPrint("\n\nAuth Already \n${client.auth.currentUser}");
    }
  } catch (err, st) {
    debugPrint('Error during supabaseLogin: $err');
    debugPrint(st.toString());
    rethrow;
  }
}

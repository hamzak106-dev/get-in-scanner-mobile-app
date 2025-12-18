// Automatic FlutterFlow imports
import '../../config/flavor_helper.dart';
import '/backend/supabase/supabase.dart';
// Imports other custom actions
// Imports custom functions
import 'package:flutter/material.dart';

// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!


Future supabaseLogin() async {
  if (Supabase.instance.client.auth.currentUser == null) {
    var email = FlavorHelper.appFlavor.sbEmail;
    debugPrint("\n\nAuth Email \n$email");
    var sbPwd = FlavorHelper.appFlavor.sbPassword;
    debugPrint("\n\nAuth PWD \n$sbPwd");
    var authResponse = await Supabase.instance.client.auth.signInWithPassword(
      email: email,
      password: sbPwd,
    );
    debugPrint("\n\nAuth Response \n${authResponse.user}");
    debugPrint("\n\nAuth Response \n${authResponse.session?.accessToken}");
  }else{
    debugPrint("\n\nAuth Already \n${Supabase.instance.client.auth.currentUser}");
  }
}

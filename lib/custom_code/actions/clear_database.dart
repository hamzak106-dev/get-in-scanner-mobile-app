// Automatic FlutterFlow imports
import 'dart:io';

import 'package:flutter/cupertino.dart';

import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
// Imports other custom actions
// Imports custom functions

// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '../actions/init_power_sync.dart';

Future<void> clearDatabase() async {
  FFAppState().user = LoggedInModelStruct();
  FFAppState().hasFirstSync = false;
  FFAppState().uuid = '';
  FFAppState().selectedEvent = [];
  FFAppState().selectedProducer = UserModelStruct();

  try {
    await Supabase.instance.client.auth.signOut();
  } catch (e) {
    debugPrint('Error signing out: $e');
  }

  // Do not dispose the Supabase client or instance here.
  // Aggressive disposal can prevent re-initialization and lead to assertion errors.

  var path = await getDatabasePath();
  if (path != null && path.isNotEmpty) {
    // Use File(path) to delete local DB file synchronously.
    final file = File(path);
    if (file.existsSync()) {
      try {
        file.deleteSync(recursive: true);
      } catch (e) {
        debugPrint('Error deleting database file: $e');
      }
    }
  }

  try {
    await db.disconnectAndClear(clearLocal: true);
  } catch (e) {
    debugPrint('Error disconnecting and clearing PowerSync: $e');
  }

  FFAppState().update(() {});
  
  // Re-run initPowerSync to ensure the sync stream is ready for the next user.
  // Note: Supabase is already initialized at the app start, no need to re-initialize SupaFlow.
  await initPowerSync();
}

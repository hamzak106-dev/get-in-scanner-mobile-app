// Automatic FlutterFlow imports
import 'dart:io';

import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
// Imports other custom actions
// Imports custom functions

// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '../actions/init_power_sync.dart';

Future clearDatabase() async {
  FFAppState().user = LoggedInModelStruct();
  FFAppState().hasFirstSync = false;
  FFAppState().uuid = '';
  FFAppState().selectedEvent = [];
  FFAppState().selectedProducer = UserModelStruct();
  await Supabase.instance.client.auth.signOut();
  Supabase.instance.client.auth.dispose();
  await Supabase.instance.client.dispose();
  await Supabase.instance.dispose();
  var path = await getDatabasePath();
  if(path.isNotEmpty) {
    File.fromUri(Uri(path: path)).deleteSync(recursive: true);
  }
  await db.disconnectAndClear(clearLocal: true);
  await db.disconnect();
  await db.close();

  FFAppState().update(() {});
  await SupaFlow.initialize();
  await initPowerSync();
}

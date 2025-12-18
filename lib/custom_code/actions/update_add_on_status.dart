// Automatic FlutterFlow imports
import 'package:g_e_t_i_n_scanner/backend/supabase/database/database.dart';

import '/backend/schema/enums/enums.dart';

// Imports other custom actions
// Imports custom functions
import 'package:flutter/material.dart';

// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Imports other custom actions

import '../actions/init_power_sync.dart';
import 'update_attendee_status.dart';

Future updateAddonStatus(int attendeeAddOnId, int status) async {
  try {
    const query = '''
      UPDATE attendee_add_ons
      SET status = ?
      WHERE id = ?
    ''';

    await db.execute(query, [status, attendeeAddOnId]);
  } catch (e) {
    debugPrint("\n\n============= Add Check In Logs ERROR ============");
    debugPrint(e.toString());
    debugPrint("==================================================\n\n");
  }
}


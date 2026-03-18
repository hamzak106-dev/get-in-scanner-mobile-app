// Automatic FlutterFlow imports
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter/material.dart';
import 'package:powersync/powersync.dart';

import '../actions/init_power_sync.dart';

// lib/custom_code/actions/sync_with_powersync.dart
Future syncWithPowersync() async {
  try {
    // Wait for sync but with a timeout (e.g., 10 seconds)
    await Future.wait([
      db.waitForFirstSync(priority: StreamPriority(0)),
      db.waitForFirstSync(priority: StreamPriority(1)),
      //  db.waitForFirstSync(priority: StreamPriority(2)),
    ]);
  } catch (e) {
    debugPrint("Power sync wait timed out or failed: $e");
    // We continue anyway so the user isn't stuck
  }
}
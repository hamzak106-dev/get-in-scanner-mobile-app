// Automatic FlutterFlow imports
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter/material.dart';
import 'package:powersync/powersync.dart';

import '../actions/init_power_sync.dart';

Future syncWithPowersync() async {
  // Add your function code here!
  try {
    await db.waitForFirstSync(priority: BucketPriority(0));
    await db.waitForFirstSync(priority: BucketPriority(1));
  } catch (e) {
    debugPrint("Power sync failed: $e");
  }
}

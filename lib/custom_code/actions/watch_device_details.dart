// Automatic FlutterFlow imports
import 'package:powersync/powersync.dart';

import '../../app_state.dart';
import '/backend/supabase/supabase.dart';

// Imports other custom actions
// Imports custom functions

// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '../actions/init_power_sync.dart';

import 'dart:async';

import 'index.dart';

Future<void> watchDeviceDetails(
  Future Function(List<DeviceRow>? result) callback,
  int deviceID,
) async {
  // Safely check whether the stream priority status has a lastSyncedAt without
  // invoking statusForPriority directly inside the condition (this can trigger
  // an assertion if internal invariant is violated).
  bool priorityHasSynced = false;
  try {
    final priorityStatus = db.currentStatus.statusForPriority(StreamPriority(0));
    priorityHasSynced = priorityStatus.lastSyncedAt != null;
  } catch (e) {
    // If we hit an assertion or any other error, log and treat as not synced.
    print('watchDeviceDetails: unable to read priority status safely: $e');
    priorityHasSynced = false;
  }

  if (db.currentStatus.lastSyncedAt != null && deviceID > 0 && priorityHasSynced) {
    try {
      await Future.delayed(const Duration(seconds: 15));

      // String watchDeviceDetailsQuery = 'SELECT * FROM device WHERE uid = $deviceID';
      // print(watchDeviceDetailsQuery);
      // var stream = db.watch(watchDeviceDetailsQuery);
      // await cancelSubscription(deviceDetailSubscription);
      // deviceDetailSubscription = stream.listen((data) {
      //   print("Device Data Count =====>>> ${data.length}");
      //   if (data.isNotEmpty) {
      //     callback(data.map((json) => DeviceRow(Map<String, dynamic>.from(json))).toList());
      //   } else {
      //     callback([]);
      //   }
      // });

      deviceDetailSubscription = Supabase.instance.client
          .from('device')
          .stream(primaryKey: ['uid'])
          .eq('uid', deviceID)
          .listen((List<Map<String, dynamic>> data) {
            print("\n\n\n\nDevice Data Count =====>>> ${data.length}\n\n\n\n");
            if (data.isNotEmpty) {
              callback(data.map((json) => DeviceRow(Map<String, dynamic>.from(json))).toList());
            } else {
              callback([]);
            }
          });
    } catch (e) {
      print("Watch Device Details Error: $e");
    }
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!

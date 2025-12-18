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
  if (db.currentStatus.lastSyncedAt != null &&
      deviceID > 0 &&
      db.currentStatus.statusForPriority(BucketPriority(0)).lastSyncedAt != null) {
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

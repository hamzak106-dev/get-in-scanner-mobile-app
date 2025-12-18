// Automatic FlutterFlow imports

import '/flutter_flow/flutter_flow_util.dart';
// Imports other custom actions
// Imports custom functions
import 'package:flutter/material.dart';

// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:async';

import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../actions/init_power_sync.dart';
import 'start_multicast.dart';

StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

Future listenForInternetAccess() async {
  // // Add your function code here!
  // InternetConnection().onStatusChange.listen((InternetStatus status) {
  //   switch (status) {
  //     case InternetStatus.connected:
  //       // The internet is now connected
  //       debugPrint("\n\nInternetStatus.connected");
  //       if (FFAppState().user.userId != 0) {
  //         if (!FFAppState().isOnline) {
  //           if (!db.connected) {
  //             SupabaseConnector currentConnector = SupabaseConnector(db);
  //             db.connect(connector: currentConnector);
  //             debugPrint('Synced with PowerSync');
  //           }
  //         }
  //       }
  //       FFAppState().isOnline = true;
  //       break;
  //     case InternetStatus.disconnected:
  //       // The internet is now disconnected
  //       debugPrint("\n\nInternetStatus.disconnected");
  //       FFAppState().isOnline = false;
  //       // SyncManager().syncData();
  //       break;
  //   }
  // });

  final connectivity = Connectivity();

  // Listen to connectivity changes
  _connectivitySubscription = connectivity.onConnectivityChanged.listen(
    (List<ConnectivityResult> result) async {
      debugPrint('\n\nConnectivity changed: $result');
      if (result.contains(ConnectivityResult.mobile) ||
          result.contains(ConnectivityResult.wifi)) {
        // Mobile network available.
        if (await InternetConnection().hasInternetAccess) {
          if (FFAppState().user.userId != 0) {
            if (!FFAppState().isOnline) {
              if (!db.connected) {
                SupabaseConnector currentConnector = SupabaseConnector(db);
                db.connect(connector: currentConnector);
                debugPrint('Synced with PowerSync');
              }
            }
          }
          FFAppState().isOnline = true;
        }
        debugPrint('\n\isOnline ${FFAppState().isOnline}...');
        if (result.contains(ConnectivityResult.wifi)) {
          debugPrint('\n\nNetwork available. Reinitializing multicast...');
          await startMulticast(); // Reinitialize the multicast
        }
      } else {
        FFAppState().isOnline = false;
        debugPrint('No network available. Closing socket...');
        await closeSocket(); // Close the socket when there's no network
      }
    },
  );
}

void stopConnectivityListener() {
  _connectivitySubscription?.cancel();
  _connectivitySubscription = null;
}

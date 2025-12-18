// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_util.dart';
// Imports other custom actions
// Imports custom functions
import 'package:flutter/material.dart';

// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Imports other custom actions

import '/custom_code/actions/start_multicast.dart'; // Imports other custom actions

import 'dart:convert';
import 'dart:io';

Future broadcastMessage(
    String? barcodeHash, int logId, int eventId, int scanStatus, String? scanAt) async {
  try {
    // Create broadcast json data
    Map<String, dynamic> jsonData = {
      'hash': barcodeHash,
      'device_id': FFAppState().user.deviceId,
      'scan_at': scanAt,
      'log_id': logId,
      'event_id': eventId,
      'scan_status': scanStatus
    };
    String jsonString = json.encode(jsonData);
    sendMessageOnSocket(jsonString);
  } catch (e) {
    debugPrint('Error sending message: $e');
    rethrow;
  }
}

void sendMessageOnSocket(String jsonString) {
  final sent = socket!.send(
    utf8.encode(jsonString),
    InternetAddress(FFAppState().multicastAddress),
    FFAppState().multicastPort,
  );

  if (sent > 0) {
    debugPrint('Sent message successfully: $jsonString');
  } else {
    debugPrint('Failed to send message (0 bytes sent)');
  }
}

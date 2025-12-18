// lib/custom_code/actions/start_multicast.dart

import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:flutter/material.dart';

import '../../app_state.dart';
import '../../backend/schema/enums/enums.dart';
import 'update_ticket_on_local_network.dart';

// Global variables
RawDatagramSocket? socket;
const platform = MethodChannel('xyz.getin.scanner/channel');
String? _localIP;
dynamic lastReadData;

Future startMulticast() async {
  try {
    // Ensure any existing socket is closed before initializing
    await closeSocket();

    // Initialize socket for both Android and iOS
    socket ??= await _initializeSocket(
      FFAppState().multicastAddress,
      FFAppState().multicastPort,
    );

    // Set up message listener
    socket?.listen((RawSocketEvent event) {
      if (event == RawSocketEvent.read) {
        _handleIncomingMessage();
      }
    });

    debugPrint(
        'Multicast initialized on ${FFAppState().multicastAddress}:${FFAppState().multicastPort}');
  } catch (e) {
    debugPrint('Error starting multicast: $e');
    rethrow;
  }
}

Future<void> closeSocket() async {
  if (socket != null) {
    debugPrint('Closing existing socket...');
    socket?.close();
    socket = null;
  }
}

Future<RawDatagramSocket> _initializeSocket(
    String multicastAddress, int port) async {
  // Get local IP
  final info = NetworkInfo();
  _localIP = await info.getWifiIP();

  // Create and bind socket
  final socket = await RawDatagramSocket.bind(
    InternetAddress.anyIPv4,
    port,
    reuseAddress: true,
    reusePort: false,
    ttl: 5,
  );

  // Get network interfaces
  final interfaces = await NetworkInterface.list();

  // Find the active WiFi interface
  var wifiInterface = interfaces.firstWhere(
    (interface) => interface.name.startsWith(Platform.isIOS ? 'en' : 'wlan'),
    orElse: () =>
        interfaces.first, // Fallback to first interface if specific not found
  );

  // Join multicast group
  socket.joinMulticast(InternetAddress(multicastAddress), wifiInterface);

  // Configure socket
  socket.broadcastEnabled = true;
  socket.writeEventsEnabled = true;
  socket.writeEventsEnabled = true;
  socket.multicastHops = 10;

  return socket;
}

void _handleIncomingMessage() {
  try {
    Datagram? datagram = socket?.receive();
    if (datagram != null) {
      String jsonString = utf8.decode(datagram.data);
      Map<String, dynamic> jsonData = json.decode(jsonString);
      debugPrint('Received message: $jsonData');

      if (jsonData['device_id'] != FFAppState().user.deviceId &&
          lastReadData != jsonData) {
        lastReadData = jsonData;
        updateTicketOnLocalNetwork(
          jsonData['hash'],
          jsonData['device_id'],
          jsonData['log_id'],
          jsonData['scan_at'],
          jsonData['event_id'],
          ScanResult.values[jsonData['scan_status']],
        );
        debugPrint('Received Check-in');
      }
    }
  } catch (e) {
    debugPrint('Error handling incoming message: $e');
  }
}

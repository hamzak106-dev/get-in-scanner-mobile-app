// // lib/custom_code/network/multicast_service.dart
//
// import 'dart:io';
// import 'dart:convert';
// import 'package:flutter/services.dart';
// import 'package:flutter/material.dart';
// import 'package:network_info_plus/network_info_plus.dart';
//
// class MulticastService {
//   static final MulticastService _instance = MulticastService._internal();
//   factory MulticastService() => _instance;
//
//   MulticastService._internal();
//
//   RawDatagramSocket? _socket;
//   static const platform = MethodChannel('com.getin.scanner/channel');
//   bool _isInitialized = false;
//   String? _localIP;
//
//   // Event callback
//   Function(Map<String, dynamic>)? onMessageReceived;
//
//   Future<void> initialize({
//     required String multicastAddress,
//     required int multicastPort,
//     required Function(Map<String, dynamic>) onMessage,
//   }) async {
//     if (_isInitialized) return;
//
//     onMessageReceived = onMessage;
//
//     try {
//       if (Platform.isIOS) {
//         await _initializeIOS(multicastAddress, multicastPort);
//       } else {
//         await _initializeAndroid(multicastAddress, multicastPort);
//       }
//
//       _isInitialized = true;
//       debugPrint('Multicast initialized on $multicastAddress:$multicastPort');
//     } catch (e) {
//       debugPrint('Error initializing multicast: $e');
//       rethrow;
//     }
//   }
//
//   Future<void> _initializeIOS(String multicastAddress, int multicastPort) async {
//     try {
//       _socket ??= await _createSocket(multicastAddress, multicastPort);
//
//       // Configure iOS specific options
//       _socket!.setRawOption(
//         RawSocketOption.fromInt(
//           RawSocketOption.levelIPv4,
//           33, // IP_MULTICAST_TTL
//           255,
//         ),
//       );
//
//       _setupMessageListener();
//     } catch (e) {
//       debugPrint('iOS initialization error: $e');
//       rethrow;
//     }
//   }
//
//   Future<void> _initializeAndroid(String multicastAddress, int multicastPort) async {
//     try {
//       // Get local IP
//       final info = NetworkInfo();
//       _localIP = await info.getWifiIP();
//
//       _socket = await _createSocket(multicastAddress, multicastPort);
//       _setupMessageListener();
//     } catch (e) {
//       debugPrint('Android initialization error: $e');
//       rethrow;
//     }
//   }
//
//   Future<RawDatagramSocket> _createSocket(String multicastAddress, int port) async {
//     final socket = await RawDatagramSocket.bind(
//       InternetAddress.anyIPv4,
//       port,
//       reuseAddress: true,
//       reusePort: true,
//       ttl: 5,
//     );
//
//     // Configure socket
//     socket.joinMulticast(InternetAddress(multicastAddress));
//     socket.multicastLoopback = true;
//     socket.broadcastEnabled = true;
//     socket.readEventsEnabled = true;
//     socket.writeEventsEnabled = true;
//     socket.multicastHops = 10;
//
//     return socket;
//   }
//
//   void _setupMessageListener() {
//     _socket?.listen((RawSocketEvent event) {
//       if (event == RawSocketEvent.read) {
//         _handleIncomingMessage();
//       }
//     });
//   }
//
//   void _handleIncomingMessage() {
//     try {
//       Datagram? datagram = _socket?.receive();
//       if (datagram != null) {
//         String jsonString = utf8.decode(datagram.data);
//         Map<String, dynamic> jsonData = json.decode(jsonString);
//         debugPrint('Received message: $jsonData');
//
//         // Notify listeners
//         onMessageReceived?.call(jsonData);
//       }
//     } catch (e) {
//       debugPrint('Error handling message: $e');
//     }
//   }
//
//   Future<void> broadcastMessage({
//     required String multicastAddress,
//     required int multicastPort,
//     required String barcodeHash,
//     required String deviceId,
//   }) async {
//     if (!_isInitialized || _socket == null) {
//       debugPrint('Socket not initialized');
//       return;
//     }
//
//     try {
//       Map<String, dynamic> jsonData = {
//         'hash': barcodeHash,
//         'device_id': deviceId,
//         'scan_at': DateTime.now().toIso8601String(),
//       };
//
//       String jsonString = json.encode(jsonData);
//       _socket!.broadcastEnabled = true;
//       _socket!.writeEventsEnabled = true;
//
//       debugPrint('Broadcasting message: $jsonString');
//
//       _socket!.send(
//         utf8.encode(jsonString),
//         InternetAddress(multicastAddress),
//         multicastPort,
//       );
//
//       debugPrint('Broadcast sent successfully');
//     } catch (e) {
//       debugPrint('Error broadcasting message: $e');
//       rethrow;
//     }
//   }
//
//   void cleanup() {
//     _socket?.close();
//     _socket = null;
//     _isInitialized = false;
//     onMessageReceived = null;
//   }
//
//   bool get isInitialized => _isInitialized;
// }
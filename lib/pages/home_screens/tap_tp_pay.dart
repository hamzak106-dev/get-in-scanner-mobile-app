import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:g_e_t_i_n_scanner/backend/api_requests/api_calls.dart'
    show GetInScannerAPIsGroup, ApiCallResponse;
import 'package:g_e_t_i_n_scanner/backend/schema/structs/tap_to_pay_resp_struct.dart';
import 'package:mek_stripe_terminal/mek_stripe_terminal.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../config/flavor_helper.dart';

class TapToPay extends StatefulWidget {
  const TapToPay({super.key});

  @override
  State<TapToPay> createState() => _TapToPayState();
}

class _TapToPayState extends State<TapToPay> {
  late final Terminal _terminal;
  StreamSubscription<List<Reader>>? _discoverReadersSub;
  StreamSubscription<ConnectionStatus>? _connectionStatusSub;
  StreamSubscription<PaymentStatus>? _paymentStatusSub;

  List<Reader> _discoveredReaders = [];
  Reader? _connectedReader;
  PaymentIntent? _paymentIntent;
  Location? _selectedLocation;

  @override
  void initState() {
    super.initState();
    // _initTerminal();
  }

  Future<String?> _makePaymentIntent() async {
    try {
      ApiCallResponse resp =
          await GetInScannerAPIsGroup.createStripeTapToPayPaymentCall.call(
        amount: '1000',
        eventId: '8445',
        apiBaseURL: FlavorHelper.appFlavor.getInAppBaseUrl,
      );
      if (resp.succeeded == false) {
        _showSnackBar("Error creating PaymentIntent");
        return null;
      }
      tapToPayResponse = TapToPayResponseStruct.fromMap(resp.jsonBody);

      /// TODO: Provide your backend endpoint that creates ephemeral keys
      return tapToPayResponse!.data.terminal.connections.secret;
    } catch (e) {
      _showSnackBar("Error: $e");
      return null;
    }
  }

  TapToPayResponseStruct? tapToPayResponse;

  Future<void> _initTerminal() async {
    final permissions = [
      Permission.locationWhenInUse,
      Permission.bluetooth,
      if (Platform.isAndroid) ...[
        Permission.bluetoothScan,
        Permission.bluetoothConnect,
      ],
    ];
    await permissions.request();
    String? fetchToken = await _makePaymentIntent();
    if (fetchToken != null && !Terminal.isInitialized) {
      await Terminal.initTerminal(
        shouldPrintLogs: true,
        fetchToken: () async => fetchToken,
      );
    }

    _terminal = Terminal.instance;

    _connectionStatusSub =
        _terminal.onConnectionStatusChange.listen((status) async {
      debugPrint("Connection status: $status");
      if (status == ConnectionStatus.connected) {
        _collectPaymentMethod();
        _showSnackBar("Reader connected ✅");
      }
    });

    _paymentStatusSub = _terminal.onPaymentStatusChange.listen((status) {
      debugPrint("Payment status: $status");
    });
  }

  Future<void> _fetchLocations() async {
    final locations = await _terminal.listLocations();
    if (locations.isEmpty) {
      _showSnackBar('Create a location on Stripe Dashboard first.');
      return;
    }
    _selectedLocation = locations.first;
    debugPrint("Using location: ${_selectedLocation!.id}");
  }

  void _startDiscovery() async {
    await _initTerminal();
    await _fetchLocations();
    if (_selectedLocation == null) return;

    _discoverReadersSub?.cancel();
    _discoverReadersSub = _terminal
        .discoverReaders(
      TapToPayDiscoveryConfiguration(isSimulated: kDebugMode),
    )
        .listen((readers) async {
      debugPrint("Discovered readers: ${readers.length}");
      setState(() => _discoveredReaders = readers);

      if (_connectedReader == null && readers.isNotEmpty) {
        for (var reader in readers) {
          debugPrint("Reader: ${reader.toString()}");
        }
        _connectedReader = readers.firstWhere(
            (r) => r.location?.id == _selectedLocation!.id,
            orElse: () => readers.first);
        await _terminal.connectReader(
          _connectedReader!,
          configuration: TapToPayConnectionConfiguration(
              locationId: _selectedLocation!.id!,
              autoReconnectOnUnexpectedDisconnect: true,
              readerDelegate: null),
        );
        setState(() {});
      }
    });
  }

  Future<void> _collectPaymentMethod() async {
    try {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (_) => MyCustomPaymentScreen()),
      // );
      PaymentIntent paymentIntent = await _terminal
          .retrievePaymentIntent(tapToPayResponse!.data.tapToPay.clientSecret);
      final piWithPM = await _terminal.collectPaymentMethod(paymentIntent);
      final confirmed = await _terminal.confirmPaymentIntent(piWithPM);
      Navigator.pop(context);
      setState(() => _paymentIntent = confirmed);
      _showSnackBar("Payment successful ✅");
    } on TerminalException catch (e) {
      _showSnackBar("Error: ${e.code}");
    }
  }

  void _showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  void dispose() {
    _discoverReadersSub?.cancel();
    _connectionStatusSub?.cancel();
    _paymentStatusSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tap to Pay")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _startDiscovery,
              child: const Text("Tap to pay"),
            ),
            if (_paymentIntent != null)
              Text("Intent status: ${_paymentIntent!.status.name}"),
            if (_connectedReader != null)
              Text("Connected to: ${_connectedReader!.toString()}"),
          ],
        ),
      ),
    );
  }
}
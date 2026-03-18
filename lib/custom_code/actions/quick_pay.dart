import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:g_e_t_i_n_scanner/app_state.dart';
import 'package:g_e_t_i_n_scanner/backend/api_requests/api_calls.dart';
import 'package:g_e_t_i_n_scanner/backend/schema/structs/tap_to_pay_resp_struct.dart';
import 'package:g_e_t_i_n_scanner/backend/schema/structs/terminal_onboarding_link_struct.dart';
import 'package:g_e_t_i_n_scanner/flutter_flow/flutter_flow_util.dart';
import 'package:mek_stripe_terminal/mek_stripe_terminal.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../config/flavor_helper.dart';
import 'get_app_version_name.dart';

class QuickPay {
  QuickPay._();

  static final QuickPay _instance = QuickPay._();

  factory QuickPay() => _instance;
  bool supported = false;

  TerminalStruct? terminalStruct;
  Reader? _connectedReader;
  TapToPayResponseStruct? tapToPayResponse;

  StreamSubscription<List<Reader>>? _discoverySub;
  StreamSubscription<ConnectionStatus>? _connectionSub;
  StreamSubscription<PaymentStatus>? _paymentSub;

  VoidCallback? onSuccess;
  void Function(String? message)? onError;
  void Function(String status)? onStatus;
  void Function()? onCancel;

  Future<void> start({
    required String amount,
    required String eventId,
    VoidCallback? onSuccess,
    void Function(String? message)? onError,
    void Function(String status)? onStatus,
    void Function()? onCancel,
  }) async {
    this.onSuccess = onSuccess;
    this.onError = onError;
    this.onStatus = onStatus;
    this.onCancel = onCancel;

    try {
      if (_connectedReader == null) {
        await _discoverAndConnect();

      } else {
      if (!supported) {
        onError?.call(
            "Tap to Pay ${Platform.isIOS ? "on iPhone" : ""} is not supported on this device.");
        return;
      }
      if (terminalStruct?.location == null) {
        onError?.call(
            "Tap to Pay ${Platform.isIOS ? "on iPhone" : ""} is not available for this event!");
        return;
      }
      _connectedReader = await Terminal.instance.getConnectedReader();

      if (_connectedReader == null) {
        onError?.call(
            "No reader connected. Please ensure the reader is connected and try again.");
        return;
      }
      onStatus?.call(
          "Already connected to reader: ${_connectedReader?.serialNumber}");
      await _collectPayment(amount, eventId);
      }
    } catch (e) {
      onError?.call("Payment initialization failed: ${e.toString()}");
    }
  }

  Future<void> initTerminal(
    int eventId, {
    VoidCallback? onInitialized,
    void Function(String? message)? onError,
    void Function(String status)? onStatus,
  }) async {
    // Request required permissions
    if(isAndroid){
      final permissions = [
        Permission.location,
        // Permission.bluetooth,
       Permission.bluetoothScan,
       Permission.bluetoothConnect,
      ];
      await permissions.request();
    }

    // Initialize terminal if not yet done
    if (!Terminal.isInitialized) {
      try {
        await Terminal.initTerminal(
          shouldPrintLogs: kDebugMode,
          fetchToken: () => fetchToken(eventId),
        );
      } catch (e) {
        onError?.call(
            "Failed to initialize Tap to Pay ${Platform.isIOS ? "on iPhone" : ''}: $e");
        return;
      }
    }

    // Check Tap to Pay support
    supported = await Terminal.instance.supportsReadersOfType(
      deviceType: DeviceType.tapToPay,
      discoveryConfiguration:
          TapToPayDiscoveryConfiguration(isSimulated: !FlavorHelper.prodFlavor),
    );
    print("Tap to Pay support: $supported");
    if (!supported) {
      onError?.call(
          "Tap to Pay ${Platform.isIOS ? "on iPhone" : ''} is not supported on this device.");
      return;
    }

    bool alreadyInitialized = false;
    void callOnInitialized() {
      if (!alreadyInitialized) {
        alreadyInitialized = true;
        onInitialized?.call();
      }
    }

    _connectedReader = await Terminal.instance.getConnectedReader();

    if (_connectedReader != null) {
       callOnInitialized();
    } else {
      await _discoverAndConnect();
    }

    // Setup listeners once
    _connectionSub?.cancel();
    _paymentSub?.cancel();

    _connectionSub =
        Terminal.instance.onConnectionStatusChange.listen((status) {
      if (status == ConnectionStatus.connected) {
        callOnInitialized();
      }
      onStatus?.call("Reader connection: $status");
    });

    _paymentSub = Terminal.instance.onPaymentStatusChange.listen((status) {
      onStatus?.call("Payment status: $status");
    });
  }

  Future<void> _discoverAndConnect() async {
    _discoverySub?.cancel();
    onStatus?.call("Discovering readers...");

    _discoverySub = Terminal.instance
        .discoverReaders(
            TapToPayDiscoveryConfiguration(isSimulated: FlavorHelper.devFlavor))
        .listen((readers) async {
      if (readers.isEmpty) return;
      _connectedReader ??= readers.first;

      try {
        await Terminal.instance.connectReader(
          _connectedReader!,
          configuration: TapToPayConnectionConfiguration(
            locationId: terminalStruct!.location,
            autoReconnectOnUnexpectedDisconnect: true,
            readerDelegate: null,
          ),
        );
        onStatus
            ?.call("Connected to reader: ${_connectedReader!.serialNumber}");
      } on TerminalException catch (e) {
        if (e.code != TerminalExceptionCode.canceled) {
          onError?.call("Failed to connect to reader: ${e.code}");
        }
      } finally {
        await _discoverySub?.cancel();
      }
    });
  }

  Future<void> _collectPayment(String amount, String eventId) async {
    final totalStopwatch = Stopwatch()..start();
    final stepStopwatch = Stopwatch();

    void logStep(String stepName) {
      stepStopwatch.stop();
      print('[$stepName] took ${stepStopwatch.elapsedMilliseconds}ms');
      stepStopwatch.reset();
    }

    try {
      // Step 1: Create Payment Intent
      stepStopwatch.start();
      final clientSecret = await _createPaymentIntent(amount, eventId);
      logStep('Create Payment Intent');

      if (clientSecret == null) throw Exception("No client secret found");

      // Step 2: Retrieve Payment Intent
      stepStopwatch.start();
      final retrievedIntent =
      await Terminal.instance.retrievePaymentIntent(clientSecret);
      logStep('Retrieve Payment Intent');

      // Step 3: Collect Payment Method
      stepStopwatch.start();
      final intentWithPM =
      await Terminal.instance.collectPaymentMethod(retrievedIntent);
      logStep('Collect Payment Method');

      // Step 4: Confirm Payment Intent
      stepStopwatch.start();
      final confirmedIntent =
      await Terminal.instance.confirmPaymentIntent(intentWithPM);
      logStep('Confirm Payment Intent');

      totalStopwatch.stop();
      print('✓ TOTAL TIME: ${totalStopwatch.elapsedMilliseconds}ms (${(totalStopwatch.elapsedMilliseconds / 1000).toStringAsFixed(2)}s)');

      onSuccess?.call();
      onStatus?.call("Payment successful: ${confirmedIntent.id}");
    } on TerminalException catch (e) {
      totalStopwatch.stop();
      print('✗ Failed after ${totalStopwatch.elapsedMilliseconds}ms');

      if (e.code == TerminalExceptionCode.canceled) {
        onCancel?.call();
      } else {
        onError?.call("Payment failed: ${e}");
      }
    }
  }

  Future<String?> _createPaymentIntent(String amount, String eventId) async {
    final version = await getAppVersionName();
    try {
      final resp = await GetInScannerAPIsGroup.createEventQuickPayCall.call(
        amount: amount,
        eventId: eventId,
        apiBaseURL: FlavorHelper.appFlavor.getInAppBaseUrl,
        scannerApiKey: FlavorHelper.appFlavor.scannerApiKey,
        appVersion: version,
        deviceId: FFAppState().uuid,
        deviceName: FFAppState().deviceName,
        platform: Platform.isAndroid ? "Android" : "iOS",
      );
      if (!resp.succeeded) return null;

      tapToPayResponse = TapToPayResponseStruct.maybeFromMap(resp.jsonBody);
      return tapToPayResponse?.data.tapToPay.clientSecret;
    } catch (e) {
      onError?.call("Error creating payment intent: $e");
      return null;
    }
  }

  Future<String> fetchToken(int eventId) async {
    final resp = await GetInScannerAPIsGroup.getQuickPayTerminalTokenCall.call(
      apiBaseURL: FlavorHelper.appFlavor.getInAppBaseUrl,
      scannerApiKey: FlavorHelper.appFlavor.scannerApiKey,
      eventId: eventId.toString(),
    );

    if (!resp.succeeded) throw Exception("Failed to fetch terminal token");

    terminalStruct =
        TerminalStruct.maybeFromMap(resp.jsonBody?['data']?['terminal']);
    if (terminalStruct == null) {
      throw Exception("Invalid terminal data");
    }

    return terminalStruct!.connections.secret;
  }

  Future<TerminalOnboardingLinkStruct?> getOnboardingLink(String ScannerName) async {
    final resp = await GetInScannerAPIsGroup.terminalOnboardingCall.call(
      apiBaseURL: FlavorHelper.appFlavor.getInAppBaseUrl,
      scannerApiKey: FlavorHelper.appFlavor.scannerApiKey,
      ScannerName: ScannerName,
    );

    if (!resp.succeeded) {
      throw Exception("Failed to fetch onboarding link");
    }

    TerminalOnboardingLinkStructResp? linkStructResp = TerminalOnboardingLinkStructResp.maybeFromMap(
        resp.jsonBody);
    if (linkStructResp == null || linkStructResp.data == null) {
      return null;
    }

    return linkStructResp.data;
  }

  Future<void> dispose() async {
    await _discoverySub?.cancel();
    await _connectionSub?.cancel();
    await _paymentSub?.cancel();
  }
}
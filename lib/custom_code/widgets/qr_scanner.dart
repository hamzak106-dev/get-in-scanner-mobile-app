// Automatic FlutterFlow imports
// Imports other custom widgets
// Imports custom actions
// Imports custom functions
import 'dart:developer';

import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:mobile_scanner/mobile_scanner.dart';

MobileScannerController? mobileScannerController;

class QrScanner extends StatefulWidget {
  const QrScanner({
    super.key,
    this.width,
    this.height,
    required this.onScan,
  });

  final double? width;
  final double? height;
  final Future Function(String value) onScan;

  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  @override
  void initState() {
    mobileScannerController = MobileScannerController();
    super.initState();
  }

  @override
  void dispose() {
    mobileScannerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MobileScanner(
      controller: mobileScannerController,
      errorBuilder: (context, MobileScannerException error) {
        return Center(
          child: Text(
            error.errorCode.message ?? 'Unknown error',
            style: const TextStyle(color: Colors.white),
          ),
        );
      },

      onDetect: (barcodes) async {
        mobileScannerController?.stop();
        await widget.onScan
            .call(barcodes.barcodes.firstOrNull?.displayValue ?? "");
      },
    );
  }
}

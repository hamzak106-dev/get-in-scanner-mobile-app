// Automatic FlutterFlow imports
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '../widgets/qr_scanner.dart';

Future enableLight() async {
  mobileScannerController?.toggleTorch();
}

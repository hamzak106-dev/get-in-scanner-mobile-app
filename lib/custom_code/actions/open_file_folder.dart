// Automatic FlutterFlow imports
// Imports other custom actions
// Imports custom functions

// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:open_file/open_file.dart';

Future openFileFolder(String? filePath) async {
  // Add your function code here!
  await OpenFile.open(filePath, type: 'text/csv');
}

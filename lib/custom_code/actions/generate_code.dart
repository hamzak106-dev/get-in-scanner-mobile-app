// Automatic FlutterFlow imports
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:math';

Future<String?> generateCode() async {
  // Add your function code here!

  int i = 0;
  String numbers = "123456789";
  String result = "";
  while (i < 4) {
    int randomInt = Random.secure().nextInt(numbers.length);
    result += numbers[randomInt];
    i++;
  }
  return result;
}

// Automatic FlutterFlow imports
import '/backend/schema/enums/enums.dart';
// Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<int> updatePermissionBitMask(
  int currentBitmask,
  AccessPermission permission,
  bool isSelected,
) async {
  // Add your function code here
  if (isSelected) {
    // Add the option to the bitmask
    return currentBitmask | getPermissionBitmask(permission);
  } else {
    // Remove the option from the bitmask
    return currentBitmask & ~getPermissionBitmask(permission);
  }
}

// extension AccessPermissionExtension on AccessPermission {
//   int get bitmaskValue {
//     switch (this) {
//       case AccessPermission.lookup:
//         return 1 << 0; // Bit position 0
//       case AccessPermission.canViewList:
//         return 1 << 1; // Bit position 1
//       case AccessPermission.requireEvent:
//         return 1 << 2; // Bit position 2
//       case AccessPermission.manualEntry:
//         return 1 << 3; // Bit position 3
//       case AccessPermission.searchAttendee:
//         return 1 << 4; // Bit position 4
//       case AccessPermission.scan:
//         return 1 << 5; // Bit position 5
//       case AccessPermission.stats:
//         return 1 << 6; // Bit position 6
//       case AccessPermission.settings:
//         return 1 << 7; // Bit position 7
//     }
//   }
// }

// Automatic FlutterFlow imports
import '/backend/schema/enums/enums.dart';
// Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!


Future<bool> isPermissionSelected(
  int currentBitmask,
  AccessPermission permission,
) async {
  // Add your function code here!
  return (currentBitmask & (getPermissionBitmask(permission))) != 0;
}

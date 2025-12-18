// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<dynamic> getSelectedPinEventTicket(List<PinEventStruct> events) async {
  // Add your function code here!

  // Result containers
  List<int> selectedEventIds = [];
  List<int> selectedTicketIds = [];

  // Iterate through each event
  for (var event in events) {
    if (event.isSelected) {
      // Add event ID to selectedEventIds if the event is selected
      selectedEventIds.add(event.eventId);
    } else {
      // Get tickets from the event
      // Filter tickets with isSelected == true and collect their IDs
      selectedTicketIds.addAll(
        event.tickets
            .where((ticket) => ticket.isSelected)
            .map((ticket) => ticket.ticketId),
      );
    }
  }

  // Return results
  return {
    'selectedEventIds':
        selectedEventIds.isNotEmpty ? selectedEventIds.join(",") : "",
    'selectedTicketIds':
        selectedTicketIds.isNotEmpty ? selectedTicketIds.join(",") : "",
  };
}

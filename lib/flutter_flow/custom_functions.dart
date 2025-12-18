import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:intl/intl.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';

bool emailValidation(String? email) {
  final emailRegEx = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  return email != null ? emailRegEx.hasMatch(email) : false;
}

int getPermissionWithoutAllEvent() {
  const int lookupTab = 1 << 0; // 1
  const int canViewList = 1 << 1; // 2
  const int requireEvent = 1 << 2; // 4
  const int manualEntry = 1 << 3; // 8
  const int searchAttendee = 1 << 4; // 16
  const int scanTab = 1 << 5; // 32
  const int statsTab = 1 << 6; // 64
  const int settingsTab = 1 << 7; // 128

  // All permissions (except requireEvent)
  int allPermissions = lookupTab | canViewList | manualEntry | searchAttendee | scanTab | statsTab | settingsTab;

  return allPermissions; // Total = 251
}

bool checkJson(dynamic jsonData) {
  try {
    return (jsonData as Map).isNotEmpty;
  } catch (e) {
    print("==================");
    print(e);
    print("==================");
    return false;
  }
}

List<EventsRow> parseEventRow(List<dynamic> data) {
  return data.map((e) => EventsRow(Map.from(e))).toList();
}

List<CreatorsRow> filterUserList(
  List<CreatorsRow> userList,
  String? searchText,
) {
  if (searchText != null && searchText.isNotEmpty) {
    return userList.where((element) => (element.name ?? "").toLowerCase().contains(searchText.toLowerCase())).toList();
  } else {
    return userList;
  }
}

List<EventsRow> filterEventList(
  List<EventsRow> eventList,
  String? searchText,
) {
  if (searchText != null && searchText.isNotEmpty) {
    return eventList.where((element) => element.title.toLowerCase().contains(searchText.toLowerCase())).toList();
  } else {
    return eventList;
  }
}

List<dynamic> parseRowToJson(
  List<EventsRow>? listData,
  EventsRow? data,
) {
  if (data != null) {
    return [data.data];
  } else {
    return listData!.map((e) => e.data).toList();
  }
}

List<AttendeeRow> filterAttendeeList(
  List<AttendeeRow> attendeeList,
  String? searchText,
) {
  if (searchText != null && searchText.isNotEmpty) {
    return attendeeList
        .where((element) =>
            (element.name?.toLowerCase() ?? "").contains(searchText.toLowerCase()) ||
            (element.phone?.toLowerCase() ?? "").contains(searchText.toLowerCase()) ||
            (element.email?.toLowerCase() ?? "").contains(searchText.toLowerCase()) ||
            (element.transactionNumber.toString() ?? "").contains(searchText.toLowerCase()) ||
            (element.purchaseId.toString()).contains(searchText.toLowerCase()))
        .toList();
  } else {
    return attendeeList;
  }
}

int findTicketScanCount(
  List<int> attendeesIndex,
  List<int> logsIndex,
) {
  int count = 0;
  try {
    for (var ele in logsIndex) {
      if (attendeesIndex.contains(ele)) count++;
    }
  } catch (e) {
    print("===== ERROR =====");
    print(e);
    print("=================");
  }

  return count;
}

List<CheckInLogsRow> filterCheckInList(
  List<CheckInLogsRow> logsList,
  String? searchText,
  List<AttendeeRow> attendeeList,
) {
  if (searchText != null && searchText.isNotEmpty) {
    return logsList.where((element) {
      AttendeeRow? tempRow = attendeeList.where((ele) => ele.uid == element.attendeeId).firstOrNull;

      if (tempRow != null) {
        return (tempRow.name?.toLowerCase() ?? "").contains(searchText.toLowerCase());
      } else {
        return (element.scanResult.toString().toLowerCase().contains(searchText.toLowerCase()));
      }
    }).toList();
  } else {
    return logsList;
  }
}

String fetchTicketType(int type) {
  try {
    return TicketType.values[type - 1].name;
  } catch (_) {
    return "";
  }
}

bool getAccessPermissionAllow(
  int currentBitmask,
  AccessPermission permission,
  Profile? profileType,
) {
  if (profileType == Profile.admin || profileType == Profile.producer) {
    return true;
  } else {
    return currentBitmask == 0 || ((currentBitmask & (getPermissionBitmask(permission))) != 0);
  }
}

int getPermissionBitmask(AccessPermission permission) {
  switch (permission) {
    case AccessPermission.lookup:
      return 1 << 0; // Bit position 0
    case AccessPermission.canViewList:
      return 1 << 1; // Bit position 1
    case AccessPermission.allEvents:
      return 1 << 2; // Bit position 2
    case AccessPermission.manualEntry:
      return 1 << 3; // Bit position 3
    case AccessPermission.searchAttendee:
      return 1 << 4; // Bit position 4
    case AccessPermission.scan:
      return 1 << 5; // Bit position 5
    case AccessPermission.stats:
      return 1 << 6; // Bit position 6
    case AccessPermission.settings:
      return 1 << 7; // Default to no permission
  }
}

String dateTimeFormatter(String dateTime) {
//2025-01-21 07:21:27.072016
  debugPrint("\nServer DateTime : $dateTime");

  var date = DateFormat("yyyy-MM-dd HH:mm:ss").parse(dateTime, true);
  var dateLocal = date.toLocal();
  return DateFormat('yyyy/MM/dd hh:mm a').format(dateLocal).toString();
}

List<PinTicketStruct>? checkAllTickets(List<PinTicketStruct>? tickets) {
  return tickets?.map((e) {
    e.isSelected = true;
    return e;
  }).toList();
}

bool isAllCheckTickets(List<PinTicketStruct> tickets) {
  bool allChecked = tickets.every((item) => item.isSelected);
  return allChecked;
}

List<CheckInLogsRow> checkInLogsOfPin(
  PinRow pin,
  List<DeviceRow> devices,
  List<CheckInLogsRow> logs,
) {
// Step 1: Find devices associated with the given pinId
  List<int> deviceIds = devices.where((device) => device.pinId == pin.uid).map((device) => device.uid).toList();

  if (deviceIds.isEmpty) {
    return []; // No devices found for this pin
  }

  // Step 2: Filter logs based on the device IDs and sort by scan_at DESC
  return logs.where((log) => deviceIds.contains(log.deviceId)).toList();
}

UserModelStruct convertCreatorToUserModel(CreatorsRow data) {
  var user = UserModelStruct.fromMap(Map.from(data.data));
  user.firstName = data.name;
  return user;
}

List<EventsRow> convertObjectList(EventsRow event) {
  return [event];
}

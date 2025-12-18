import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/components/count_details_card/count_details_card_widget.dart';
import '/components/summary_card/summary_card_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'scanner_summary_widget.dart' show ScannerSummaryWidget;
import 'package:flutter/material.dart';

class ScannerSummaryModel extends FlutterFlowModel<ScannerSummaryWidget> {
  ///  Local state fields for this component.

  bool byTicket = true;

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  List<AttendeeRow> attendees = [];
  void addToAttendees(AttendeeRow item) => attendees.add(item);
  void removeFromAttendees(AttendeeRow item) => attendees.remove(item);
  void removeAtIndexFromAttendees(int index) => attendees.removeAt(index);
  void insertAtIndexInAttendees(int index, AttendeeRow item) =>
      attendees.insert(index, item);
  void updateAttendeesAtIndex(int index, Function(AttendeeRow) updateFn) =>
      attendees[index] = updateFn(attendees[index]);

  List<CheckInLogsRow> logs = [];
  void addToLogs(CheckInLogsRow item) => logs.add(item);
  void removeFromLogs(CheckInLogsRow item) => logs.remove(item);
  void removeAtIndexFromLogs(int index) => logs.removeAt(index);
  void insertAtIndexInLogs(int index, CheckInLogsRow item) =>
      logs.insert(index, item);
  void updateLogsAtIndex(int index, Function(CheckInLogsRow) updateFn) =>
      logs[index] = updateFn(logs[index]);

  List<DeviceRow> devices = [];
  void addToDevices(DeviceRow item) => devices.add(item);
  void removeFromDevices(DeviceRow item) => devices.remove(item);
  void removeAtIndexFromDevices(int index) => devices.removeAt(index);
  void insertAtIndexInDevices(int index, DeviceRow item) =>
      devices.insert(index, item);
  void updateDevicesAtIndex(int index, Function(DeviceRow) updateFn) =>
      devices[index] = updateFn(devices[index]);

  /// pins
  List<PinRow> pins = [];
  void addToPins(PinRow item) => pins.add(item);
  void removeFromPins(PinRow item) => pins.remove(item);
  void removeAtIndexFromPins(int index) => pins.removeAt(index);
  void insertAtIndexInPins(int index, PinRow item) => pins.insert(index, item);
  void updatePinsAtIndex(int index, Function(PinRow) updateFn) =>
      pins[index] = updateFn(pins[index]);

  List<SummaryStruct> pinSummary = [];
  void addToPinSummary(SummaryStruct item) => pinSummary.add(item);
  void removeFromPinSummary(SummaryStruct item) => pinSummary.remove(item);
  void removeAtIndexFromPinSummary(int index) => pinSummary.removeAt(index);
  void insertAtIndexInPinSummary(int index, SummaryStruct item) =>
      pinSummary.insert(index, item);
  void updatePinSummaryAtIndex(int index, Function(SummaryStruct) updateFn) =>
      pinSummary[index] = updateFn(pinSummary[index]);

  List<SummaryStruct> ticketSummary = [];
  void addToTicketSummary(SummaryStruct item) => ticketSummary.add(item);
  void removeFromTicketSummary(SummaryStruct item) =>
      ticketSummary.remove(item);
  void removeAtIndexFromTicketSummary(int index) =>
      ticketSummary.removeAt(index);
  void insertAtIndexInTicketSummary(int index, SummaryStruct item) =>
      ticketSummary.insert(index, item);
  void updateTicketSummaryAtIndex(
          int index, Function(SummaryStruct) updateFn) =>
      ticketSummary[index] = updateFn(ticketSummary[index]);

  List<SummaryStruct> deviceSummary = [];
  void addToDeviceSummary(SummaryStruct item) => deviceSummary.add(item);
  void removeFromDeviceSummary(SummaryStruct item) =>
      deviceSummary.remove(item);
  void removeAtIndexFromDeviceSummary(int index) =>
      deviceSummary.removeAt(index);
  void insertAtIndexInDeviceSummary(int index, SummaryStruct item) =>
      deviceSummary.insert(index, item);
  void updateDeviceSummaryAtIndex(
          int index, Function(SummaryStruct) updateFn) =>
      deviceSummary[index] = updateFn(deviceSummary[index]);

  int noOfCheckins = 0;

  int noOfAbsent = 0;

  int totalAttendee = 0;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Custom Action - getAttendeeList] action in ScannerSummary widget.
  List<AttendeeRow>? attendeesResponse;
  // Model for CountDetailsCard component.
  late CountDetailsCardModel countDetailsCardModel1;
  // Model for CountDetailsCard component.
  late CountDetailsCardModel countDetailsCardModel2;
  // Model for CountDetailsCard component.
  late CountDetailsCardModel countDetailsCardModel3;
  // Models for SummaryCard dynamic component.
  late FlutterFlowDynamicModels<SummaryCardModel> summaryCardModels1;
  // Models for SummaryCard dynamic component.
  late FlutterFlowDynamicModels<SummaryCardModel> summaryCardModels2;

  @override
  void initState(BuildContext context) {
    countDetailsCardModel1 =
        createModel(context, () => CountDetailsCardModel());
    countDetailsCardModel2 =
        createModel(context, () => CountDetailsCardModel());
    countDetailsCardModel3 =
        createModel(context, () => CountDetailsCardModel());
    summaryCardModels1 = FlutterFlowDynamicModels(() => SummaryCardModel());
    summaryCardModels2 = FlutterFlowDynamicModels(() => SummaryCardModel());
  }

  @override
  void dispose() {
    countDetailsCardModel1.dispose();
    countDetailsCardModel2.dispose();
    countDetailsCardModel3.dispose();
    summaryCardModels1.dispose();
    summaryCardModels2.dispose();
  }
}

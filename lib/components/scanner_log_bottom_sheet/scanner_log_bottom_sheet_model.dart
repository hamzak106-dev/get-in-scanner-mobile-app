import '/backend/supabase/supabase.dart';
import '/components/search_text_field/search_text_field_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'scanner_log_bottom_sheet_widget.dart' show ScannerLogBottomSheetWidget;
import 'package:flutter/material.dart';

class ScannerLogBottomSheetModel
    extends FlutterFlowModel<ScannerLogBottomSheetWidget> {
  ///  Local state fields for this component.

  List<CheckInLogsRow> logs = [];
  void addToLogs(CheckInLogsRow item) => logs.add(item);
  void removeFromLogs(CheckInLogsRow item) => logs.remove(item);
  void removeAtIndexFromLogs(int index) => logs.removeAt(index);
  void insertAtIndexInLogs(int index, CheckInLogsRow item) =>
      logs.insert(index, item);
  void updateLogsAtIndex(int index, Function(CheckInLogsRow) updateFn) =>
      logs[index] = updateFn(logs[index]);

  List<AttendeeRow> attendee = [];
  void addToAttendee(AttendeeRow item) => attendee.add(item);
  void removeFromAttendee(AttendeeRow item) => attendee.remove(item);
  void removeAtIndexFromAttendee(int index) => attendee.removeAt(index);
  void insertAtIndexInAttendee(int index, AttendeeRow item) =>
      attendee.insert(index, item);
  void updateAttendeeAtIndex(int index, Function(AttendeeRow) updateFn) =>
      attendee[index] = updateFn(attendee[index]);

  ///  State fields for stateful widgets in this component.

  // Model for SearchTextField component.
  late SearchTextFieldModel searchTextFieldModel;

  @override
  void initState(BuildContext context) {
    searchTextFieldModel = createModel(context, () => SearchTextFieldModel());
  }

  @override
  void dispose() {
    searchTextFieldModel.dispose();
  }
}

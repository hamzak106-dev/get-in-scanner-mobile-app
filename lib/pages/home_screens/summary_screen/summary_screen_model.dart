import '/backend/supabase/supabase.dart';
import '/components/screen_component/admin_summary/admin_summary_widget.dart';
import '/components/screen_component/manager_summary/manager_summary_widget.dart';
import '/components/screen_component/scanner_summary/scanner_summary_widget.dart';
import '/components/sync/sync_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'summary_screen_widget.dart' show SummaryScreenWidget;
import 'package:flutter/material.dart';

class SummaryScreenModel extends FlutterFlowModel<SummaryScreenWidget> {
  ///  Local state fields for this page.

  bool byTicket = true;

  List<CheckInLogsRow> logs = [];
  void addToLogs(CheckInLogsRow item) => logs.add(item);
  void removeFromLogs(CheckInLogsRow item) => logs.remove(item);
  void removeAtIndexFromLogs(int index) => logs.removeAt(index);
  void insertAtIndexInLogs(int index, CheckInLogsRow item) =>
      logs.insert(index, item);
  void updateLogsAtIndex(int index, Function(CheckInLogsRow) updateFn) =>
      logs[index] = updateFn(logs[index]);

  List<AttendeeRow> allAttendee = [];
  void addToAllAttendee(AttendeeRow item) => allAttendee.add(item);
  void removeFromAllAttendee(AttendeeRow item) => allAttendee.remove(item);
  void removeAtIndexFromAllAttendee(int index) => allAttendee.removeAt(index);
  void insertAtIndexInAllAttendee(int index, AttendeeRow item) =>
      allAttendee.insert(index, item);
  void updateAllAttendeeAtIndex(int index, Function(AttendeeRow) updateFn) =>
      allAttendee[index] = updateFn(allAttendee[index]);

  ///  State fields for stateful widgets in this page.

  // Model for Sync component.
  late SyncModel syncModel;
  // Model for AdminSummary component.
  late AdminSummaryModel adminSummaryModel;
  // Model for ManagerSummary component.
  late ManagerSummaryModel managerSummaryModel;
  // Model for ScannerSummary component.
  late ScannerSummaryModel scannerSummaryModel;

  @override
  void initState(BuildContext context) {
    syncModel = createModel(context, () => SyncModel());
    adminSummaryModel = createModel(context, () => AdminSummaryModel());
    managerSummaryModel = createModel(context, () => ManagerSummaryModel());
    scannerSummaryModel = createModel(context, () => ScannerSummaryModel());
  }

  @override
  void dispose() {
    syncModel.dispose();
    adminSummaryModel.dispose();
    managerSummaryModel.dispose();
    scannerSummaryModel.dispose();
  }
}

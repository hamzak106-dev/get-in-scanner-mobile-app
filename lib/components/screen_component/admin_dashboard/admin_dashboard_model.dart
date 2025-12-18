import '/backend/supabase/supabase.dart';
import '/components/sync/sync_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'admin_dashboard_widget.dart' show AdminDashboardWidget;
import 'package:flutter/material.dart';

class AdminDashboardModel extends FlutterFlowModel<AdminDashboardWidget> {
  ///  Local state fields for this component.

  List<EventsRow> events = [];
  void addToEvents(EventsRow item) => events.add(item);
  void removeFromEvents(EventsRow item) => events.remove(item);
  void removeAtIndexFromEvents(int index) => events.removeAt(index);
  void insertAtIndexInEvents(int index, EventsRow item) =>
      events.insert(index, item);
  void updateEventsAtIndex(int index, Function(EventsRow) updateFn) =>
      events[index] = updateFn(events[index]);

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

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Custom Action - getEventsList] action in AdminDashboard widget.
  List<EventsRow>? eventListResponse;
  // Model for Sync component.
  late SyncModel syncModel;

  @override
  void initState(BuildContext context) {
    syncModel = createModel(context, () => SyncModel());
  }

  @override
  void dispose() {
    syncModel.dispose();
  }
}

import '/backend/supabase/supabase.dart';
import '/components/count_details_card/count_details_card_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'admin_summary_widget.dart' show AdminSummaryWidget;
import 'package:flutter/material.dart';

class AdminSummaryModel extends FlutterFlowModel<AdminSummaryWidget> {
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

  // Stores action output result for [Custom Action - getEventsList] action in AdminSummary widget.
  List<EventsRow>? eventListResponse;
  // Stores action output result for [Custom Action - getAttendeeList] action in AdminSummary widget.
  List<AttendeeRow>? attendeeResponse;
  // Stores action output result for [Custom Action - getCheckInLogsList] action in AdminSummary widget.
  List<CheckInLogsRow>? logsResponse;
  // Model for CountDetailsCard component.
  late CountDetailsCardModel countDetailsCardModel1;
  // Model for CountDetailsCard component.
  late CountDetailsCardModel countDetailsCardModel2;
  // Model for CountDetailsCard component.
  late CountDetailsCardModel countDetailsCardModel3;
  // Model for CountDetailsCard component.
  late CountDetailsCardModel countDetailsCardModel4;

  @override
  void initState(BuildContext context) {
    countDetailsCardModel1 =
        createModel(context, () => CountDetailsCardModel());
    countDetailsCardModel2 =
        createModel(context, () => CountDetailsCardModel());
    countDetailsCardModel3 =
        createModel(context, () => CountDetailsCardModel());
    countDetailsCardModel4 =
        createModel(context, () => CountDetailsCardModel());
  }

  @override
  void dispose() {
    countDetailsCardModel1.dispose();
    countDetailsCardModel2.dispose();
    countDetailsCardModel3.dispose();
    countDetailsCardModel4.dispose();
  }
}

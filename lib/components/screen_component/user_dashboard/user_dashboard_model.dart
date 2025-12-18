import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/components/choose_event_or_producer/choose_event_or_producer_widget.dart';
import '/components/dialogs/choose_event_dialog/choose_event_dialog_widget.dart';
import '/components/event_selection_bottom_sheet/event_selection_bottom_sheet_widget.dart';
import '/components/rive_animation_view/rive_animation_view_widget.dart';
import '/components/search_text_field/search_text_field_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'user_dashboard_widget.dart' show UserDashboardWidget;
import 'package:flutter/material.dart';

class UserDashboardModel extends FlutterFlowModel<UserDashboardWidget> {
  ///  Local state fields for this component.

  List<AttendeeRow> attedees = [];
  void addToAttedees(AttendeeRow item) => attedees.add(item);
  void removeFromAttedees(AttendeeRow item) => attedees.remove(item);
  void removeAtIndexFromAttedees(int index) => attedees.removeAt(index);
  void insertAtIndexInAttedees(int index, AttendeeRow item) =>
      attedees.insert(index, item);
  void updateAttedeesAtIndex(int index, Function(AttendeeRow) updateFn) =>
      attedees[index] = updateFn(attedees[index]);

  List<EventsRow> events = [];
  void addToEvents(EventsRow item) => events.add(item);
  void removeFromEvents(EventsRow item) => events.remove(item);
  void removeAtIndexFromEvents(int index) => events.removeAt(index);
  void insertAtIndexInEvents(int index, EventsRow item) =>
      events.insert(index, item);
  void updateEventsAtIndex(int index, Function(EventsRow) updateFn) =>
      events[index] = updateFn(events[index]);

  bool ascending = true;

  EventsRow? currentEvent;

  bool isLoading = true;

  AttendeeFilterBy? status = AttendeeFilterBy.ALL;

  bool hasLookUp = true;

  bool isFirstEvent = true;

  bool isLastEvent = false;

  bool isUpcoming = false;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Custom Action - getAttendeeList] action in UserDashboard widget.
  List<AttendeeRow>? allowAttendees;
  // Stores action output result for [Custom Action - isPermissionSelected] action in UserDashboard widget.
  bool? lookUpAvailable;
  // Stores action output result for [Custom Action - getEventsOfUser] action in UserDashboard widget.
  List<EventsRow>? allEventsFromStart;
  // Stores action output result for [Custom Action - choosePreviousNextEvent] action in IconButton widget.
  List<EventsRow>? previousEvents;
  // Stores action output result for [Custom Action - getEventsOfUser] action in IconButton widget.
  List<EventsRow>? allEventsFromPrevious;
  // Stores action output result for [Custom Action - getAttendeeList] action in IconButton widget.
  List<AttendeeRow>? getAttendeeListResponseLeft;
  // Stores action output result for [Backend Call - Query Rows] action in Text widget.
  List<EventsRow>? textClickAllEvents;
  // Stores action output result for [Custom Action - getAttendeeList] action in Text widget.
  List<AttendeeRow>? getAttendeeListResponseCenter;
  // Stores action output result for [Custom Action - choosePreviousNextEvent] action in IconButton widget.
  List<EventsRow>? nextEvents;
  // Stores action output result for [Custom Action - getEventsOfUser] action in IconButton widget.
  List<EventsRow>? allEventsFromNext;
  // Stores action output result for [Custom Action - getAttendeeList] action in IconButton widget.
  List<AttendeeRow>? getAttendeeListResponseRight;
  // Stores action output result for [Bottom Sheet - LookupScannerBottomSheet] action in IconButton widget.
  String? scannedValue;
  // Stores action output result for [Custom Action - checkPermissionForScanTicket] action in IconButton widget.
  ScanResult? permissionResult;
  // Stores action output result for [Custom Action - findAttendee] action in IconButton widget.
  AttendeeRow? redirectAttendeeResponse;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // Model for SearchTextField component.
  late SearchTextFieldModel searchTextFieldModel;
  // Model for RiveAnimationView component.
  late RiveAnimationViewModel riveAnimationViewModel;
  // Model for ChooseEventOrProducer component.
  late ChooseEventOrProducerModel chooseEventOrProducerModel;

  @override
  void initState(BuildContext context) {
    searchTextFieldModel = createModel(context, () => SearchTextFieldModel());
    riveAnimationViewModel =
        createModel(context, () => RiveAnimationViewModel());
    chooseEventOrProducerModel =
        createModel(context, () => ChooseEventOrProducerModel());
  }

  @override
  void dispose() {
    searchTextFieldModel.dispose();
    riveAnimationViewModel.dispose();
    chooseEventOrProducerModel.dispose();
  }
  Future openEventsBottomSheetActionBlock(BuildContext context) async {
    EventsRow? selectEventBSResult;

    await showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      useSafeArea: true,
      enableDrag: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: MediaQuery.viewInsetsOf(context),
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.75,
            child: const EventSelectionBottomSheetWidget(),
          ),
        );
      },
    ).then((value) => selectEventBSResult = value);
  }
}

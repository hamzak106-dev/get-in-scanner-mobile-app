import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/components/label_check/label_check_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'pin_events_screen_widget.dart' show PinEventsScreenWidget;
import 'package:flutter/material.dart';

class PinEventsScreenModel extends FlutterFlowModel<PinEventsScreenWidget> {
  ///  Local state fields for this page.

  bool isAdminDevice = true;

  List<PinEventStruct> pinEvents = [];
  void addToPinEvents(PinEventStruct item) => pinEvents.add(item);
  void removeFromPinEvents(PinEventStruct item) => pinEvents.remove(item);
  void removeAtIndexFromPinEvents(int index) => pinEvents.removeAt(index);
  void insertAtIndexInPinEvents(int index, PinEventStruct item) =>
      pinEvents.insert(index, item);
  void updatePinEventsAtIndex(int index, Function(PinEventStruct) updateFn) =>
      pinEvents[index] = updateFn(pinEvents[index]);

  String? selectedEventIds;

  String? selectedTicketIds;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - updatePinEventTicketSelection] action in PinEventsScreen widget.
  List<PinEventStruct>? userPinEvents;
  // State field(s) for Switch widget.
  bool? switchValue;
  // Stores action output result for [Bottom Sheet - PinEventSelectionBottomSheet] action in Icon widget.
  EventsRow? chooseEvent;
  // Stores action output result for [Custom Action - getPinEventAndTickets] action in Icon widget.
  PinEventStruct? choosePinEvent;
  // Models for LabelCheck dynamic component.
  late FlutterFlowDynamicModels<LabelCheckModel> labelCheckModels1;
  // Stores action output result for [Custom Action - updatePermissionBitMask] action in Button widget.
  int? permissionNumber;
  // Stores action output result for [Custom Action - getSelectedPinEventTicket] action in Button widget.
  dynamic selectedIds;
  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<PinRow>? updatedPinResponseWithIds;

  @override
  void initState(BuildContext context) {
    labelCheckModels1 = FlutterFlowDynamicModels(() => LabelCheckModel());
  }

  @override
  void dispose() {
    labelCheckModels1.dispose();
  }
}

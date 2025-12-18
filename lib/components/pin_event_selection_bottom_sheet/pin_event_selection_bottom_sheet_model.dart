import '/backend/supabase/supabase.dart';
import '/components/event_card_for_pin/event_card_for_pin_widget.dart';
import '/components/rive_animation_view/rive_animation_view_widget.dart';
import '/components/search_text_field/search_text_field_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'pin_event_selection_bottom_sheet_widget.dart'
    show PinEventSelectionBottomSheetWidget;
import 'package:flutter/material.dart';

class PinEventSelectionBottomSheetModel
    extends FlutterFlowModel<PinEventSelectionBottomSheetWidget> {
  ///  Local state fields for this component.

  List<EventsRow> events = [];
  void addToEvents(EventsRow item) => events.add(item);
  void removeFromEvents(EventsRow item) => events.remove(item);
  void removeAtIndexFromEvents(int index) => events.removeAt(index);
  void insertAtIndexInEvents(int index, EventsRow item) =>
      events.insert(index, item);
  void updateEventsAtIndex(int index, Function(EventsRow) updateFn) =>
      events[index] = updateFn(events[index]);

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Query Rows] action in PinEventSelectionBottomSheet widget.
  List<EventsRow>? userEvents;
  // Model for SearchTextField component.
  late SearchTextFieldModel searchTextFieldModel;
  // Models for EventCardForPin dynamic component.
  late FlutterFlowDynamicModels<EventCardForPinModel> eventCardForPinModels;
  // Model for RiveAnimationView component.
  late RiveAnimationViewModel riveAnimationViewModel;

  @override
  void initState(BuildContext context) {
    searchTextFieldModel = createModel(context, () => SearchTextFieldModel());
    eventCardForPinModels =
        FlutterFlowDynamicModels(() => EventCardForPinModel());
    riveAnimationViewModel =
        createModel(context, () => RiveAnimationViewModel());
  }

  @override
  void dispose() {
    searchTextFieldModel.dispose();
    eventCardForPinModels.dispose();
    riveAnimationViewModel.dispose();
  }
}

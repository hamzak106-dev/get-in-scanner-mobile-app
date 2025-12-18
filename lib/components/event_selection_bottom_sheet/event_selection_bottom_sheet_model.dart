import '/backend/supabase/supabase.dart';
import '/components/rive_animation_view/rive_animation_view_widget.dart';
import '/components/search_text_field/search_text_field_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'event_selection_bottom_sheet_widget.dart'
    show EventSelectionBottomSheetWidget;
import 'package:flutter/material.dart';

class EventSelectionBottomSheetModel
    extends FlutterFlowModel<EventSelectionBottomSheetWidget> {
  ///  Local state fields for this component.

  bool upcoming = true;

  List<EventsRow> events = [];
  void addToEvents(EventsRow item) => events.add(item);
  void removeFromEvents(EventsRow item) => events.remove(item);
  void removeAtIndexFromEvents(int index) => events.removeAt(index);
  void insertAtIndexInEvents(int index, EventsRow item) =>
      events.insert(index, item);
  void updateEventsAtIndex(int index, Function(EventsRow) updateFn) =>
      events[index] = updateFn(events[index]);

  List<EventsRow> emptyList = [];
  void addToEmptyList(EventsRow item) => emptyList.add(item);
  void removeFromEmptyList(EventsRow item) => emptyList.remove(item);
  void removeAtIndexFromEmptyList(int index) => emptyList.removeAt(index);
  void insertAtIndexInEmptyList(int index, EventsRow item) =>
      emptyList.insert(index, item);
  void updateEmptyListAtIndex(int index, Function(EventsRow) updateFn) =>
      emptyList[index] = updateFn(emptyList[index]);

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Custom Action - getEventsList] action in EventSelectionBottomSheet widget.
  List<EventsRow>? eventResponse;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // Model for SearchTextField component.
  late SearchTextFieldModel searchTextFieldModel;
  // Model for RiveAnimationView component.
  late RiveAnimationViewModel riveAnimationViewModel1;
  // Model for RiveAnimationView component.
  late RiveAnimationViewModel riveAnimationViewModel2;

  @override
  void initState(BuildContext context) {
    searchTextFieldModel = createModel(context, () => SearchTextFieldModel());
    riveAnimationViewModel1 =
        createModel(context, () => RiveAnimationViewModel());
    riveAnimationViewModel2 =
        createModel(context, () => RiveAnimationViewModel());
  }

  @override
  void dispose() {
    searchTextFieldModel.dispose();
    riveAnimationViewModel1.dispose();
    riveAnimationViewModel2.dispose();
  }
}

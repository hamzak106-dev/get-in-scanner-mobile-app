import '/backend/supabase/supabase.dart';
import '/components/choose_event_or_producer/choose_event_or_producer_widget.dart';
import '/components/rive_animation_view/rive_animation_view_widget.dart';
import '/components/screen_component/scanner_summary/scanner_summary_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'manager_summary_widget.dart' show ManagerSummaryWidget;
import 'package:flutter/material.dart';

class ManagerSummaryModel extends FlutterFlowModel<ManagerSummaryWidget> {
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

  // Model for ScannerSummary component.
  late ScannerSummaryModel scannerSummaryModel;
  // Model for RiveAnimationView component.
  late RiveAnimationViewModel riveAnimationViewModel;
  // Model for ChooseEventOrProducer component.
  late ChooseEventOrProducerModel chooseEventOrProducerModel;

  @override
  void initState(BuildContext context) {
    scannerSummaryModel = createModel(context, () => ScannerSummaryModel());
    riveAnimationViewModel =
        createModel(context, () => RiveAnimationViewModel());
    chooseEventOrProducerModel =
        createModel(context, () => ChooseEventOrProducerModel());
  }

  @override
  void dispose() {
    scannerSummaryModel.dispose();
    riveAnimationViewModel.dispose();
    chooseEventOrProducerModel.dispose();
  }
}

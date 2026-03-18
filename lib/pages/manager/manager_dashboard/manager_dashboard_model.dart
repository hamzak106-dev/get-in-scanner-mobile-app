import '../../../components/sync/sync_model.dart';
import '/backend/supabase/supabase.dart';
import '/components/choose_event_or_producer/choose_event_or_producer_widget.dart';
import '/components/event_card_for_scanner/event_card_for_scanner_widget.dart';
import '/components/search_text_field/search_text_field_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'manager_dashboard_widget.dart' show ManagerDashboardWidget;
import 'package:flutter/material.dart';

class ManagerDashboardModel extends FlutterFlowModel<ManagerDashboardWidget> {
  ///  Local state fields for this component.

  bool isLoading = true;
  List<EventsRow> events = [];
  void addToEvents(EventsRow item) => events.add(item);
  void removeFromEvents(EventsRow item) => events.remove(item);
  void removeAtIndexFromEvents(int index) => events.removeAt(index);
  void insertAtIndexInEvents(int index, EventsRow item) =>
      events.insert(index, item);
  void updateEventsAtIndex(int index, Function(EventsRow) updateFn) =>
      events[index] = updateFn(events[index]);

  bool? ascending;

  ///  State fields for stateful widgets in this component.

  // Model for SearchTextField component.
  late SearchTextFieldModel searchTextFieldModel;
  // Models for EventCardForScanner dynamic component.
  late FlutterFlowDynamicModels<EventCardForScannerModel>
      eventCardForScannerModels;
  // Model for ChooseEventOrProducer component.
  late ChooseEventOrProducerModel chooseEventOrProducerModel;

  // Model for Sync component.
  late SyncModel syncModel;

  @override
  void initState(BuildContext context) {
    searchTextFieldModel = createModel(context, () => SearchTextFieldModel());
    eventCardForScannerModels =
        FlutterFlowDynamicModels(() => EventCardForScannerModel());
    chooseEventOrProducerModel =
        createModel(context, () => ChooseEventOrProducerModel());
    syncModel = createModel(context, () => SyncModel());
  }

  @override
  void dispose() {
    searchTextFieldModel.dispose();
    eventCardForScannerModels.dispose();
    chooseEventOrProducerModel.dispose();
    syncModel.dispose();
  }
}

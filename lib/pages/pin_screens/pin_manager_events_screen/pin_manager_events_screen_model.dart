import '/backend/supabase/supabase.dart';
import '/components/choose_event_or_producer/choose_event_or_producer_widget.dart';
import '/components/event_card_for_scanner/event_card_for_scanner_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'pin_manager_events_screen_widget.dart'
    show PinManagerEventsScreenWidget;
import 'package:flutter/material.dart';

class PinManagerEventsScreenModel
    extends FlutterFlowModel<PinManagerEventsScreenWidget> {
  ///  Local state fields for this page.

  List<EventsRow> events = [];
  void addToEvents(EventsRow item) => events.add(item);
  void removeFromEvents(EventsRow item) => events.remove(item);
  void removeAtIndexFromEvents(int index) => events.removeAt(index);
  void insertAtIndexInEvents(int index, EventsRow item) =>
      events.insert(index, item);
  void updateEventsAtIndex(int index, Function(EventsRow) updateFn) =>
      events[index] = updateFn(events[index]);

  ///  State fields for stateful widgets in this page.

  // Models for EventCardForScanner dynamic component.
  late FlutterFlowDynamicModels<EventCardForScannerModel>
      eventCardForScannerModels;
  // Model for ChooseEventOrProducer component.
  late ChooseEventOrProducerModel chooseEventOrProducerModel;

  @override
  void initState(BuildContext context) {
    eventCardForScannerModels =
        FlutterFlowDynamicModels(() => EventCardForScannerModel());
    chooseEventOrProducerModel =
        createModel(context, () => ChooseEventOrProducerModel());
  }

  @override
  void dispose() {
    eventCardForScannerModels.dispose();
    chooseEventOrProducerModel.dispose();
  }
}

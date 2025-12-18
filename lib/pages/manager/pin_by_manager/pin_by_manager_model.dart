import '/backend/supabase/supabase.dart';
import '/components/event_card_for_scanner/event_card_for_scanner_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'pin_by_manager_widget.dart' show PinByManagerWidget;
import 'package:flutter/material.dart';

class PinByManagerModel extends FlutterFlowModel<PinByManagerWidget> {
  ///  Local state fields for this page.

  EventsRow? event;

  CreatorsRow? eventCreator;

  bool isLoading = true;

  PinRow? producerPin;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in PinByManager widget.
  List<CreatorsRow>? producer;
  // Stores action output result for [Backend Call - Query Rows] action in PinByManager widget.
  List<EventsRow>? dbEvent;
  // Stores action output result for [Backend Call - Query Rows] action in PinByManager widget.
  List<PinRow>? pins;
  // Model for EventCardForScanner component.
  late EventCardForScannerModel eventCardForScannerModel;
  // State field(s) for CodeInfoTextField widget.
  FocusNode? codeInfoTextFieldFocusNode;
  TextEditingController? codeInfoTextFieldTextController;
  String? Function(BuildContext, String?)?
      codeInfoTextFieldTextControllerValidator;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<PinRow>? existingPins;
  // Stores action output result for [Backend Call - Insert Row] action in Button widget.
  PinRow? addPinResponse;

  @override
  void initState(BuildContext context) {
    eventCardForScannerModel =
        createModel(context, () => EventCardForScannerModel());
  }

  @override
  void dispose() {
    eventCardForScannerModel.dispose();
    codeInfoTextFieldFocusNode?.dispose();
    codeInfoTextFieldTextController?.dispose();
  }
}

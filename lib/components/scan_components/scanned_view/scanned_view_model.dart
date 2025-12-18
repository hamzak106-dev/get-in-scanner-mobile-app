import '/components/combine_text_view/combine_text_view_widget.dart';
import '/components/scanner_event_selection/scanner_event_selection_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'scanned_view_widget.dart' show ScannedViewWidget;
import 'package:flutter/material.dart';

class ScannedViewModel extends FlutterFlowModel<ScannedViewWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Custom Action - getCheckInBy] action in ScannedView widget.
  String? scanByText;
  // Model for ScannerEventSelection component.
  late ScannerEventSelectionModel scannerEventSelectionModel;
  // Model for CombineTextView component.
  late CombineTextViewModel combineTextViewModel1;
  // Model for CombineTextView component.
  late CombineTextViewModel combineTextViewModel2;
  // Model for CombineTextView component.
  late CombineTextViewModel combineTextViewModel3;
  // Model for CombineTextView component.
  late CombineTextViewModel combineTextViewModel4;
  // Model for CombineTextView component.
  late CombineTextViewModel combineTextViewModel5;
  // Model for CombineTextView component.
  late CombineTextViewModel combineTextViewModel6;

  @override
  void initState(BuildContext context) {
    scannerEventSelectionModel =
        createModel(context, () => ScannerEventSelectionModel());
    combineTextViewModel1 = createModel(context, () => CombineTextViewModel());
    combineTextViewModel2 = createModel(context, () => CombineTextViewModel());
    combineTextViewModel3 = createModel(context, () => CombineTextViewModel());
    combineTextViewModel4 = createModel(context, () => CombineTextViewModel());
    combineTextViewModel5 = createModel(context, () => CombineTextViewModel());
    combineTextViewModel6 = createModel(context, () => CombineTextViewModel());
  }

  @override
  void dispose() {
    scannerEventSelectionModel.dispose();
    combineTextViewModel1.dispose();
    combineTextViewModel2.dispose();
    combineTextViewModel3.dispose();
    combineTextViewModel4.dispose();
    combineTextViewModel5.dispose();
    combineTextViewModel6.dispose();
  }
}

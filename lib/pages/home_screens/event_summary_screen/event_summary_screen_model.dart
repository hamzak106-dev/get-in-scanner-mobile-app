import '/components/screen_component/scanner_summary/scanner_summary_widget.dart';
import '/components/sync/sync_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'event_summary_screen_widget.dart' show EventSummaryScreenWidget;
import 'package:flutter/material.dart';

class EventSummaryScreenModel
    extends FlutterFlowModel<EventSummaryScreenWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for Sync component.
  late SyncModel syncModel;
  // Model for ScannerSummary component.
  late ScannerSummaryModel scannerSummaryModel;

  @override
  void initState(BuildContext context) {
    syncModel = createModel(context, () => SyncModel());
    scannerSummaryModel = createModel(context, () => ScannerSummaryModel());
  }

  @override
  void dispose() {
    syncModel.dispose();
    scannerSummaryModel.dispose();
  }
}

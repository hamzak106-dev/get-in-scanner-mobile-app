import '/backend/schema/enums/enums.dart';
import '/components/screen_component/scan_component/scan_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'scan_screen_widget.dart' show ScanScreenWidget;
import 'package:flutter/material.dart';

class ScanScreenModel extends FlutterFlowModel<ScanScreenWidget> {
  ///  Local state fields for this page.

  int selectedIndex = 0;

  ScanResult? scanResult;

  ///  State fields for stateful widgets in this page.

  // Model for ScanComponent component.
  late ScanComponentModel scanComponentModel;

  @override
  void initState(BuildContext context) {
    scanComponentModel = createModel(context, () => ScanComponentModel());
  }

  @override
  void dispose() {
    scanComponentModel.dispose();
  }
}

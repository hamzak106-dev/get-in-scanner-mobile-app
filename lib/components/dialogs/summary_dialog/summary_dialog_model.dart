import '/components/dialog_button/dialog_button_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'summary_dialog_widget.dart' show SummaryDialogWidget;
import 'package:flutter/material.dart';

class SummaryDialogModel extends FlutterFlowModel<SummaryDialogWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for DialogButton component.
  late DialogButtonModel dialogButtonModel;

  @override
  void initState(BuildContext context) {
    dialogButtonModel = createModel(context, () => DialogButtonModel());
  }

  @override
  void dispose() {
    dialogButtonModel.dispose();
  }
}

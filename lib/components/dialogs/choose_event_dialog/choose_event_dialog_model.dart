import '/components/dialog_button/dialog_button_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'choose_event_dialog_widget.dart' show ChooseEventDialogWidget;
import 'package:flutter/material.dart';

class ChooseEventDialogModel extends FlutterFlowModel<ChooseEventDialogWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for DialogButton component.
  late DialogButtonModel dialogButtonModel1;
  // Model for DialogButton component.
  late DialogButtonModel dialogButtonModel2;

  @override
  void initState(BuildContext context) {
    dialogButtonModel1 = createModel(context, () => DialogButtonModel());
    dialogButtonModel2 = createModel(context, () => DialogButtonModel());
  }

  @override
  void dispose() {
    dialogButtonModel1.dispose();
    dialogButtonModel2.dispose();
  }
}

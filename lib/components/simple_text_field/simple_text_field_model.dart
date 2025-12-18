import '/flutter_flow/flutter_flow_util.dart';
import 'simple_text_field_widget.dart' show SimpleTextFieldWidget;
import 'package:flutter/material.dart';

class SimpleTextFieldModel extends FlutterFlowModel<SimpleTextFieldWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}

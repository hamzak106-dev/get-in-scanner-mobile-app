import '/flutter_flow/flutter_flow_util.dart';
import 'info_text_field_widget.dart' show InfoTextFieldWidget;
import 'package:flutter/material.dart';

class InfoTextFieldModel extends FlutterFlowModel<InfoTextFieldWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Custom Action - generateCode] action in Button widget.
  String? code;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}

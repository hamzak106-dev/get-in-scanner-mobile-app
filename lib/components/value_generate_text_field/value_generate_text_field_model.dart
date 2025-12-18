import '/flutter_flow/flutter_flow_util.dart';
import 'value_generate_text_field_widget.dart'
    show ValueGenerateTextFieldWidget;
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ValueGenerateTextFieldModel
    extends FlutterFlowModel<ValueGenerateTextFieldWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  final textFieldMask = MaskTextInputFormatter(mask: '####');
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

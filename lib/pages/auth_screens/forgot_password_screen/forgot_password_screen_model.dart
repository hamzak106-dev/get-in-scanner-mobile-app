import '/components/custom_button/custom_button_widget.dart';
import '/components/simple_text_field/simple_text_field_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'forgot_password_screen_widget.dart' show ForgotPasswordScreenWidget;
import 'package:flutter/material.dart';

class ForgotPasswordScreenModel
    extends FlutterFlowModel<ForgotPasswordScreenWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for SimpleTextField component.
  late SimpleTextFieldModel simpleTextFieldModel;
  // Model for CustomButton component.
  late CustomButtonModel customButtonModel;

  @override
  void initState(BuildContext context) {
    simpleTextFieldModel = createModel(context, () => SimpleTextFieldModel());
    customButtonModel = createModel(context, () => CustomButtonModel());
  }

  @override
  void dispose() {
    simpleTextFieldModel.dispose();
    customButtonModel.dispose();
  }
}

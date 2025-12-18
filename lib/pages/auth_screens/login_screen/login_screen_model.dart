import '/backend/api_requests/api_calls.dart';
import '/backend/schema/enums/enums.dart';
import '/components/custom_button/custom_button_widget.dart';
import '/components/simple_text_field/simple_text_field_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'login_screen_widget.dart' show LoginScreenWidget;
import 'package:flutter/material.dart';

class LoginScreenModel extends FlutterFlowModel<LoginScreenWidget> {
  ///  Local state fields for this page.

  LoginWith? loginWith = LoginWith.email;

  String? phoneNumber;

  String? countryCode = 'UA';

  String? dialCode = '+380';

  String? errorText;

  ///  State fields for stateful widgets in this page.

  // Model for SimpleTextField component.
  late SimpleTextFieldModel simpleTextFieldModel;
  // Model for CustomButton component.
  late CustomButtonModel customButtonModel;
  // Stores action output result for [Custom Action - getFBAppCheckToken] action in CustomButton widget.
  String? checkToken;
  // Stores action output result for [Backend Call - API (CheckVFive)] action in CustomButton widget.
  ApiCallResponse? checkResponse;

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

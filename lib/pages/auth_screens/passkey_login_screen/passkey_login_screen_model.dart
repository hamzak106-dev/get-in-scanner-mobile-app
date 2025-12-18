import '/backend/supabase/supabase.dart';
import '/components/custom_button/custom_button_widget.dart';
import '/components/simple_text_field/simple_text_field_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'passkey_login_screen_widget.dart' show PasskeyLoginScreenWidget;
import 'package:flutter/material.dart';

class PasskeyLoginScreenModel
    extends FlutterFlowModel<PasskeyLoginScreenWidget> {
  ///  Local state fields for this page.

  String? password;

  String? accessCodeError;

  String? passwordError;

  int? deviceId;

  ///  State fields for stateful widgets in this page.

  // Model for SimpleTextField component.
  late SimpleTextFieldModel simpleTextFieldModel;
  // Model for CustomButton component.
  late CustomButtonModel customButtonModel;
  // Stores action output result for [Backend Call - Query Rows] action in CustomButton widget.
  List<PinRow>? pinResponse;
  // Stores action output result for [Custom Action - getAppVersionName] action in CustomButton widget.
  String? version;
  // Stores action output result for [Backend Call - Query Rows] action in CustomButton widget.
  List<DeviceRow>? checkDeviceResponse;
  // Stores action output result for [Backend Call - Update Row(s)] action in CustomButton widget.
  List<DeviceRow>? updatedData;
  // Stores action output result for [Backend Call - Insert Row] action in CustomButton widget.
  DeviceRow? newDeviceData;
  // Stores action output result for [Custom Action - getPinEventIds] action in CustomButton widget.
  String? pinAssignedEventIds;

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

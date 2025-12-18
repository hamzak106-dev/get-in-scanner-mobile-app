import '/backend/supabase/supabase.dart';
import '/components/info_text_field/info_text_field_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'pin_info_screen_widget.dart' show PinInfoScreenWidget;
import 'package:flutter/material.dart';

class PinInfoScreenModel extends FlutterFlowModel<PinInfoScreenWidget> {
  ///  Local state fields for this page.

  bool isAdminDevice = true;

  ///  State fields for stateful widgets in this page.

  // Model for NameInfoTextField.
  late InfoTextFieldModel nameInfoTextFieldModel;
  // Model for ScannerNameInfoTextField.
  late InfoTextFieldModel scannerNameInfoTextFieldModel;
  // Model for AccessCodeInfoTextField.
  late InfoTextFieldModel accessCodeInfoTextFieldModel;
  // State field(s) for CodeInfoTextField widget.
  FocusNode? codeInfoTextFieldFocusNode;
  TextEditingController? codeInfoTextFieldTextController;
  String? Function(BuildContext, String?)?
      codeInfoTextFieldTextControllerValidator;
  // Stores action output result for [Custom Action - generateCode] action in Button widget.
  String? code;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<PinRow>? existingPins;
  // Stores action output result for [Backend Call - Insert Row] action in Button widget.
  PinRow? addPinResponse;
  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<PinRow>? updatedRow;

  @override
  void initState(BuildContext context) {
    nameInfoTextFieldModel = createModel(context, () => InfoTextFieldModel());
    scannerNameInfoTextFieldModel =
        createModel(context, () => InfoTextFieldModel());
    accessCodeInfoTextFieldModel =
        createModel(context, () => InfoTextFieldModel());
  }

  @override
  void dispose() {
    nameInfoTextFieldModel.dispose();
    scannerNameInfoTextFieldModel.dispose();
    accessCodeInfoTextFieldModel.dispose();
    codeInfoTextFieldFocusNode?.dispose();
    codeInfoTextFieldTextController?.dispose();
  }
}

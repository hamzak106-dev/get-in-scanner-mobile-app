import '/backend/supabase/supabase.dart';
import '/components/label_text_field/label_text_field_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'edit_attendee_screen_widget.dart' show EditAttendeeScreenWidget;
import 'package:flutter/material.dart';

class EditAttendeeScreenModel
    extends FlutterFlowModel<EditAttendeeScreenWidget> {
  ///  Local state fields for this page.

  String? firstName;

  String? lastName;

  String? email;

  String? phoneNumber;

  String? countryCode;

  String? dialCode;

  ///  State fields for stateful widgets in this page.

  // Model for FNameLabelTextField.
  late LabelTextFieldModel fNameLabelTextFieldModel;
  // Model for LNameLabelTextField.
  late LabelTextFieldModel lNameLabelTextFieldModel;
  // Model for EmailLabelTextField.
  late LabelTextFieldModel emailLabelTextFieldModel;
  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<AttendeeRow>? updateDetailsResp;

  @override
  void initState(BuildContext context) {
    fNameLabelTextFieldModel =
        createModel(context, () => LabelTextFieldModel());
    lNameLabelTextFieldModel =
        createModel(context, () => LabelTextFieldModel());
    emailLabelTextFieldModel =
        createModel(context, () => LabelTextFieldModel());
  }

  @override
  void dispose() {
    fNameLabelTextFieldModel.dispose();
    lNameLabelTextFieldModel.dispose();
    emailLabelTextFieldModel.dispose();
  }
}

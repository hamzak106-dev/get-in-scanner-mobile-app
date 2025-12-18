import '/backend/supabase/supabase.dart';
import '/components/label_text_field/label_text_field_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'add_scanners_screen_widget.dart' show AddScannersScreenWidget;
import 'package:flutter/material.dart';

class AddScannersScreenModel extends FlutterFlowModel<AddScannersScreenWidget> {
  ///  Local state fields for this page.

  bool isAdminDevice = true;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - isAdminDevice] action in AddScannersScreen widget.
  bool? isAdmin;
  // Model for NameLabelTextField.
  late LabelTextFieldModel nameLabelTextFieldModel;
  // Model for ScannerLabelTextField.
  late LabelTextFieldModel scannerLabelTextFieldModel;
  // Model for LabelTextField component.
  late LabelTextFieldModel labelTextFieldModel1;
  // Model for LabelTextField component.
  late LabelTextFieldModel labelTextFieldModel2;
  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<DeviceRow>? updatedRow;
  // Stores action output result for [Alert Dialog - Custom Dialog] action in Button widget.
  bool? deleteDevice;
  // Stores action output result for [Backend Call - Delete Row(s)] action in Button widget.
  List<CheckInLogsRow>? deletedLogs;
  // Stores action output result for [Backend Call - Delete Row(s)] action in Button widget.
  List<DeviceRow>? deletedDevices;

  @override
  void initState(BuildContext context) {
    nameLabelTextFieldModel = createModel(context, () => LabelTextFieldModel());
    scannerLabelTextFieldModel =
        createModel(context, () => LabelTextFieldModel());
    labelTextFieldModel1 = createModel(context, () => LabelTextFieldModel());
    labelTextFieldModel2 = createModel(context, () => LabelTextFieldModel());
  }

  @override
  void dispose() {
    nameLabelTextFieldModel.dispose();
    scannerLabelTextFieldModel.dispose();
    labelTextFieldModel1.dispose();
    labelTextFieldModel2.dispose();
  }
}

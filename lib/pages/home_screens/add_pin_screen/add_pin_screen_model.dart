import '/backend/supabase/supabase.dart';
import '/components/check_tile/check_tile_widget.dart';
import '/components/label_text_field/label_text_field_widget.dart';
import '/components/value_generate_text_field/value_generate_text_field_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'add_pin_screen_widget.dart' show AddPinScreenWidget;
import 'package:flutter/material.dart';

class AddPinScreenModel extends FlutterFlowModel<AddPinScreenWidget> {
  ///  Local state fields for this page.

  bool isAdminDevice = true;

  int permissionsValue = 0;

  bool isLookUp = false;

  bool canViewLookUp = false;

  bool requireEventLookUp = false;

  bool manualEntry = false;

  bool scanSelected = false;

  bool settingSelected = false;

  bool statSelected = false;

  bool searchSelected = false;

  String? generatedPin;

  List<DeviceRow> devices = [];
  void addToDevices(DeviceRow item) => devices.add(item);
  void removeFromDevices(DeviceRow item) => devices.remove(item);
  void removeAtIndexFromDevices(int index) => devices.removeAt(index);
  void insertAtIndexInDevices(int index, DeviceRow item) =>
      devices.insert(index, item);
  void updateDevicesAtIndex(int index, Function(DeviceRow) updateFn) =>
      devices[index] = updateFn(devices[index]);

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Custom Action - isPermissionSelected] action in AddPinScreen widget.
  bool? pLookUp;
  // Stores action output result for [Custom Action - isPermissionSelected] action in AddPinScreen widget.
  bool? pCanView;
  // Stores action output result for [Custom Action - isPermissionSelected] action in AddPinScreen widget.
  bool? pRequireEvent;
  // Stores action output result for [Custom Action - isPermissionSelected] action in AddPinScreen widget.
  bool? pManualEntry;
  // Stores action output result for [Custom Action - isPermissionSelected] action in AddPinScreen widget.
  bool? pSearch;
  // Stores action output result for [Custom Action - isPermissionSelected] action in AddPinScreen widget.
  bool? pScan;
  // Stores action output result for [Custom Action - isPermissionSelected] action in AddPinScreen widget.
  bool? pStats;
  // Stores action output result for [Custom Action - isPermissionSelected] action in AddPinScreen widget.
  bool? pSettings;
  // Model for NameLabelTextField.
  late LabelTextFieldModel nameLabelTextFieldModel;
  // Model for ScannerLabelTextField.
  late LabelTextFieldModel scannerLabelTextFieldModel;
  // Model for LabelTextField component.
  late LabelTextFieldModel labelTextFieldModel;
  // Model for ValueGenerateTextField component.
  late ValueGenerateTextFieldModel valueGenerateTextFieldModel;
  // Model for CheckTile component.
  late CheckTileModel checkTileModel1;
  // Stores action output result for [Custom Action - updatePermissionBitMask] action in CheckTile widget.
  int? updateLookUpPermissionValue;
  // Model for CheckTile component.
  late CheckTileModel checkTileModel2;
  // Stores action output result for [Custom Action - updatePermissionBitMask] action in CheckTile widget.
  int? updateCanViewPermissionValue;
  // Model for CheckTile component.
  late CheckTileModel checkTileModel3;
  // Stores action output result for [Custom Action - updatePermissionBitMask] action in CheckTile widget.
  int? updateRequireEventPermissionValue;
  // Model for CheckTile component.
  late CheckTileModel checkTileModel4;
  // Stores action output result for [Custom Action - updatePermissionBitMask] action in CheckTile widget.
  int? updateManualEntryPermissionValue;
  // Model for CheckTile component.
  late CheckTileModel checkTileModel5;
  // Stores action output result for [Custom Action - updatePermissionBitMask] action in CheckTile widget.
  int? updateSearchPermissionValue;
  // Model for CheckTile component.
  late CheckTileModel checkTileModel6;
  // Stores action output result for [Custom Action - updatePermissionBitMask] action in CheckTile widget.
  int? updateScanPermissionValue;
  // Model for CheckTile component.
  late CheckTileModel checkTileModel7;
  // Stores action output result for [Custom Action - updatePermissionBitMask] action in CheckTile widget.
  int? updateStatsPermissionValue;
  // Model for CheckTile component.
  late CheckTileModel checkTileModel8;
  // Stores action output result for [Custom Action - updatePermissionBitMask] action in CheckTile widget.
  int? updateSettingPermissionValue;
  // Model for CheckTile component.
  late CheckTileModel checkTileModel9;
  // Stores action output result for [Validate Form] action in Button widget.
  bool? validInput;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<PinRow>? pinRows;
  // Stores action output result for [Backend Call - Insert Row] action in Button widget.
  PinRow? addPinResponse;
  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<PinRow>? updatePinResponse;
  // Stores action output result for [Alert Dialog - Custom Dialog] action in Button widget.
  bool? deletePin;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<DeviceRow>? availablePins;
  // Stores action output result for [Backend Call - Delete Row(s)] action in Button widget.
  List<CheckInLogsRow>? deletedLogs;
  // Stores action output result for [Backend Call - Delete Row(s)] action in Button widget.
  List<DeviceRow>? deletedDevices;
  // Stores action output result for [Backend Call - Delete Row(s)] action in Button widget.
  List<PinRow>? deletedPin;

  @override
  void initState(BuildContext context) {
    nameLabelTextFieldModel = createModel(context, () => LabelTextFieldModel());
    scannerLabelTextFieldModel =
        createModel(context, () => LabelTextFieldModel());
    labelTextFieldModel = createModel(context, () => LabelTextFieldModel());
    valueGenerateTextFieldModel =
        createModel(context, () => ValueGenerateTextFieldModel());
    checkTileModel1 = createModel(context, () => CheckTileModel());
    checkTileModel2 = createModel(context, () => CheckTileModel());
    checkTileModel3 = createModel(context, () => CheckTileModel());
    checkTileModel4 = createModel(context, () => CheckTileModel());
    checkTileModel5 = createModel(context, () => CheckTileModel());
    checkTileModel6 = createModel(context, () => CheckTileModel());
    checkTileModel7 = createModel(context, () => CheckTileModel());
    checkTileModel8 = createModel(context, () => CheckTileModel());
    checkTileModel9 = createModel(context, () => CheckTileModel());
    nameLabelTextFieldModel.textControllerValidator = _formTextFieldValidator1;
    valueGenerateTextFieldModel.textControllerValidator =
        _formTextFieldValidator2;
  }

  @override
  void dispose() {
    nameLabelTextFieldModel.dispose();
    scannerLabelTextFieldModel.dispose();
    labelTextFieldModel.dispose();
    valueGenerateTextFieldModel.dispose();
    checkTileModel1.dispose();
    checkTileModel2.dispose();
    checkTileModel3.dispose();
    checkTileModel4.dispose();
    checkTileModel5.dispose();
    checkTileModel6.dispose();
    checkTileModel7.dispose();
    checkTileModel8.dispose();
    checkTileModel9.dispose();
  }

  /// Additional helper methods.

  String? _formTextFieldValidator1(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Pin name is required';
    }

    return null;
  }

  String? _formTextFieldValidator2(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Code is required';
    }

    return null;
  }
}

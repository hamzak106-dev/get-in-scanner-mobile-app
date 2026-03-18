import '/backend/supabase/supabase.dart';
import '/components/setting_tile/setting_tile_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'setting_screen_widget.dart' show SettingScreenWidget;
import 'package:flutter/material.dart';

class SettingScreenModel extends FlutterFlowModel<SettingScreenWidget> {
  ///  Local state fields for this page.

  List<PinRow> pinData = [];
  void addToPinData(PinRow item) => pinData.add(item);
  void removeFromPinData(PinRow item) => pinData.remove(item);
  void removeAtIndexFromPinData(int index) => pinData.removeAt(index);
  void insertAtIndexInPinData(int index, PinRow item) =>
      pinData.insert(index, item);
  void updatePinDataAtIndex(int index, Function(PinRow) updateFn) =>
      pinData[index] = updateFn(pinData[index]);

  List<DeviceRow> devices = [];
  void addToDevices(DeviceRow item) => devices.add(item);
  void removeFromDevices(DeviceRow item) => devices.remove(item);
  void removeAtIndexFromDevices(int index) => devices.removeAt(index);
  void insertAtIndexInDevices(int index, DeviceRow item) =>
      devices.insert(index, item);
  void updateDevicesAtIndex(int index, Function(DeviceRow) updateFn) =>
      devices[index] = updateFn(devices[index]);

  String appVersionName = 'N/A';

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - fetchUser] action in SettingScreen widget.
  CreatorsRow? userResponse;
  // Stores action output result for [Custom Action - getPinList] action in SettingScreen widget.
  List<PinRow>? pinResponse;
  // Stores action output result for [Custom Action - getDeviceList] action in SettingScreen widget.
  List<DeviceRow>? deviceResponse;
  // Stores action output result for [Custom Action - getAppVersionName] action in SettingScreen widget.
  String? appVersionNameResult;
  // Model for SettingTile component.
  late SettingTileModel settingTileModel1;
  // Model for SettingTile component.
  late SettingTileModel settingTileModel2;
  // Model for SettingTile component.
  late SettingTileModel settingTileModel3;
  // Model for SettingTile component.
  late SettingTileModel settingTileModel4;
  // Model for SettingTile component.
  late SettingTileModel settingTileModel5;
  // Model for SettingTile component.
  late SettingTileModel settingTileModel6;
  // Model for SettingTile component.
  late SettingTileModel settingTileModel7;
  // Model for SettingTile component.
  late SettingTileModel settingTileModel8;
  // Model for SettingTile component.
  late SettingTileModel settingTileModel9;
  // Model for SettingTile component.
  late SettingTileModel settingTileModel10;
  // Model for SettingTile component.
  late SettingTileModel settingTileModel13;
  late SettingTileModel settingTileModel14;
  late SettingTileModel debugTokenModel;

  // Models for SettingTile dynamic component.
  late FlutterFlowDynamicModels<SettingTileModel> settingTileModels12;

  int? posEventId;

  @override
  void initState(BuildContext context) {
    settingTileModel1 = createModel(context, () => SettingTileModel());
    settingTileModel2 = createModel(context, () => SettingTileModel());
    settingTileModel3 = createModel(context, () => SettingTileModel());
    settingTileModel4 = createModel(context, () => SettingTileModel());
    settingTileModel5 = createModel(context, () => SettingTileModel());
    settingTileModel6 = createModel(context, () => SettingTileModel());
    settingTileModel7 = createModel(context, () => SettingTileModel());
    settingTileModel8 = createModel(context, () => SettingTileModel());
    settingTileModel9 = createModel(context, () => SettingTileModel());
    settingTileModel10 = createModel(context, () => SettingTileModel());
    settingTileModel13 = createModel(context, () => SettingTileModel());
    settingTileModel14 = createModel(context, () => SettingTileModel());
    debugTokenModel = createModel(context, () => SettingTileModel());
    settingTileModels12 = FlutterFlowDynamicModels(() => SettingTileModel());
  }

  @override
  void dispose() {
    settingTileModel1.dispose();
    settingTileModel2.dispose();
    settingTileModel3.dispose();
    settingTileModel4.dispose();
    settingTileModel5.dispose();
    settingTileModel6.dispose();
    settingTileModel7.dispose();
    settingTileModel8.dispose();
    settingTileModel9.dispose();
    settingTileModel10.dispose();
    settingTileModels12.dispose();
    settingTileModel13.dispose();
    settingTileModel14.dispose();
    debugTokenModel.dispose();
  }
}

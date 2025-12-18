import '/backend/supabase/supabase.dart';
import '/components/setting_tile/setting_tile_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'pin_details_screen_widget.dart' show PinDetailsScreenWidget;
import 'package:flutter/material.dart';

class PinDetailsScreenModel extends FlutterFlowModel<PinDetailsScreenWidget> {
  ///  Local state fields for this page.

  bool isAdminDevice = true;

  int permissionsValue = 0;

  List<DeviceRow> devices = [];
  void addToDevices(DeviceRow item) => devices.add(item);
  void removeFromDevices(DeviceRow item) => devices.remove(item);
  void removeAtIndexFromDevices(int index) => devices.removeAt(index);
  void insertAtIndexInDevices(int index, DeviceRow item) =>
      devices.insert(index, item);
  void updateDevicesAtIndex(int index, Function(DeviceRow) updateFn) =>
      devices[index] = updateFn(devices[index]);

  PinRow? watchPIn;

  ///  State fields for stateful widgets in this page.

  // Model for SettingTile component.
  late SettingTileModel settingTileModel1;
  // Model for SettingTile component.
  late SettingTileModel settingTileModel2;
  // Model for SettingTile component.
  late SettingTileModel settingTileModel3;
  // Model for SettingTile component.
  late SettingTileModel settingTileModel4;
  // Stores action output result for [Alert Dialog - Custom Dialog] action in Button widget.
  bool? isDeletePin;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<DeviceRow>? availablePins;
  // Stores action output result for [Backend Call - Delete Row(s)] action in Button widget.
  List<CheckInLogsRow>? deletedLogs;
  // Stores action output result for [Backend Call - Delete Row(s)] action in Button widget.
  List<DeviceRow>? deletedDevices;
  // Stores action output result for [Backend Call - Delete Row(s)] action in Button widget.
  List<PinRow>? deletedPin;
  // Stores action output result for [Alert Dialog - Custom Dialog] action in Button widget.
  bool? isDisablePin;
  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<PinRow>? disabledPins;
  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<PinRow>? enabledPins;

  @override
  void initState(BuildContext context) {
    settingTileModel1 = createModel(context, () => SettingTileModel());
    settingTileModel2 = createModel(context, () => SettingTileModel());
    settingTileModel3 = createModel(context, () => SettingTileModel());
    settingTileModel4 = createModel(context, () => SettingTileModel());
  }

  @override
  void dispose() {
    settingTileModel1.dispose();
    settingTileModel2.dispose();
    settingTileModel3.dispose();
    settingTileModel4.dispose();
  }
}

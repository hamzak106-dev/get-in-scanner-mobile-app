import '/backend/supabase/supabase.dart';
import '/components/device_tile/device_tile_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'pin_devices_screen_widget.dart' show PinDevicesScreenWidget;
import 'package:flutter/material.dart';

class PinDevicesScreenModel extends FlutterFlowModel<PinDevicesScreenWidget> {
  ///  Local state fields for this page.

  bool isAdminDevice = true;

  List<DeviceRow> devices = [];
  void addToDevices(DeviceRow item) => devices.add(item);
  void removeFromDevices(DeviceRow item) => devices.remove(item);
  void removeAtIndexFromDevices(int index) => devices.removeAt(index);
  void insertAtIndexInDevices(int index, DeviceRow item) =>
      devices.insert(index, item);
  void updateDevicesAtIndex(int index, Function(DeviceRow) updateFn) =>
      devices[index] = updateFn(devices[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - getDeviceList] action in PinDevicesScreen widget.
  List<DeviceRow>? deviceResponse;
  // Models for DeviceTile dynamic component.
  late FlutterFlowDynamicModels<DeviceTileModel> deviceTileModels;
  // Stores action output result for [Alert Dialog - Custom Dialog] action in DeviceTile widget.
  bool? isDeleteDevice;
  // Stores action output result for [Backend Call - Delete Row(s)] action in DeviceTile widget.
  List<CheckInLogsRow>? deletedLogs;
  // Stores action output result for [Backend Call - Delete Row(s)] action in DeviceTile widget.
  List<DeviceRow>? deletedDevices;

  @override
  void initState(BuildContext context) {
    deviceTileModels = FlutterFlowDynamicModels(() => DeviceTileModel());
  }

  @override
  void dispose() {
    deviceTileModels.dispose();
  }
}

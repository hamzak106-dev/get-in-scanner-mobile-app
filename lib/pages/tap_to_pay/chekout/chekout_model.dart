import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'chekout_widget.dart' show ChekoutWidget;
import 'package:flutter/material.dart';

class ChekoutModel extends FlutterFlowModel<ChekoutWidget> {
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

  // Stores action output result for [Custom Action - isPermissionSelected] action in chekout widget.
  bool? pLookUp;
  // Stores action output result for [Custom Action - isPermissionSelected] action in chekout widget.
  bool? pCanView;
  // Stores action output result for [Custom Action - isPermissionSelected] action in chekout widget.
  bool? pRequireEvent;
  // Stores action output result for [Custom Action - isPermissionSelected] action in chekout widget.
  bool? pManualEntry;
  // Stores action output result for [Custom Action - isPermissionSelected] action in chekout widget.
  bool? pSearch;
  // Stores action output result for [Custom Action - isPermissionSelected] action in chekout widget.
  bool? pScan;
  // Stores action output result for [Custom Action - isPermissionSelected] action in chekout widget.
  bool? pStats;
  // Stores action output result for [Custom Action - isPermissionSelected] action in chekout widget.
  bool? pSettings;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}

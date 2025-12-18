import '/backend/supabase/supabase.dart';
import '/components/sync_tile/sync_tile_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'sync_screen_widget.dart' show SyncScreenWidget;
import 'package:flutter/material.dart';

class SyncScreenModel extends FlutterFlowModel<SyncScreenWidget> {
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

  // Stores action output result for [Custom Action - powersyncLastSyncAt] action in Button widget.
  DateTime? lastSyncAt;
  // Model for SyncTile component.
  late SyncTileModel syncTileModel1;
  // Model for SyncTile component.
  late SyncTileModel syncTileModel2;
  // Model for SyncTile component.
  late SyncTileModel syncTileModel3;
  // Model for SyncTile component.
  late SyncTileModel syncTileModel4;

  @override
  void initState(BuildContext context) {
    syncTileModel1 = createModel(context, () => SyncTileModel());
    syncTileModel2 = createModel(context, () => SyncTileModel());
    syncTileModel3 = createModel(context, () => SyncTileModel());
    syncTileModel4 = createModel(context, () => SyncTileModel());
  }

  @override
  void dispose() {
    syncTileModel1.dispose();
    syncTileModel2.dispose();
    syncTileModel3.dispose();
    syncTileModel4.dispose();
  }
}

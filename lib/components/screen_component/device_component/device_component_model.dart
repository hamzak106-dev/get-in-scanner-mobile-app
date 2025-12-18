import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'device_component_widget.dart' show DeviceComponentWidget;
import 'package:flutter/material.dart';

class DeviceComponentModel extends FlutterFlowModel<DeviceComponentWidget> {
  ///  Local state fields for this component.

  List<PinRow> pins = [];
  void addToPins(PinRow item) => pins.add(item);
  void removeFromPins(PinRow item) => pins.remove(item);
  void removeAtIndexFromPins(int index) => pins.removeAt(index);
  void insertAtIndexInPins(int index, PinRow item) => pins.insert(index, item);
  void updatePinsAtIndex(int index, Function(PinRow) updateFn) =>
      pins[index] = updateFn(pins[index]);

  List<DeviceRow> devices = [];
  void addToDevices(DeviceRow item) => devices.add(item);
  void removeFromDevices(DeviceRow item) => devices.remove(item);
  void removeAtIndexFromDevices(int index) => devices.removeAt(index);
  void insertAtIndexInDevices(int index, DeviceRow item) =>
      devices.insert(index, item);
  void updateDevicesAtIndex(int index, Function(DeviceRow) updateFn) =>
      devices[index] = updateFn(devices[index]);

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Custom Action - getPinList] action in DeviceComponent widget.
  List<PinRow>? pinResponse;
  // Stores action output result for [Custom Action - getDeviceList] action in DeviceComponent widget.
  List<DeviceRow>? deviceResponse;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}

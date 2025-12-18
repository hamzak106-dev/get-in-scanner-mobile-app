import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/components/rive_animation_view/rive_animation_view_widget.dart';
import '/components/scan_components/scanned_view/scanned_view_widget.dart';
import '/components/scanner_event_selection/scanner_event_selection_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'scan_component_widget.dart' show ScanComponentWidget;
import 'package:flutter/material.dart';

class ScanComponentModel extends FlutterFlowModel<ScanComponentWidget> {
  ///  Local state fields for this component.

  int selectedIndex = 0;

  ScanResult? scanResult;

  String? scannedValue;

  AttendeeRow? attendee;

  EventsRow? event;

  int logId = 0;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Custom Action - checkPermissionForScanTicket] action in QrScanner widget.
  ScanResult? permissionResult;
  // Stores action output result for [Custom Action - findAttendee] action in QrScanner widget.
  AttendeeRow? attendeeResponse;
  // Model for ScannerEventSelection component.
  late ScannerEventSelectionModel scannerEventSelectionModel;
  // Model for RiveAnimationView component.
  late RiveAnimationViewModel riveAnimationViewModel;
  // Model for ScannedView component.
  late ScannedViewModel scannedViewModel;

  @override
  void initState(BuildContext context) {
    scannerEventSelectionModel =
        createModel(context, () => ScannerEventSelectionModel());
    riveAnimationViewModel =
        createModel(context, () => RiveAnimationViewModel());
    scannedViewModel = createModel(context, () => ScannedViewModel());
  }

  @override
  void dispose() {
    scannerEventSelectionModel.dispose();
    riveAnimationViewModel.dispose();
    scannedViewModel.dispose();
  }
}

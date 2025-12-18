import '/flutter_flow/flutter_flow_rive_controller.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'sync_widget.dart' show SyncWidget;
import 'package:flutter/material.dart';

class SyncModel extends FlutterFlowModel<SyncWidget> {
  ///  Local state fields for this component.

  bool isLoading = false;

  ///  State fields for stateful widgets in this component.

  // State field(s) for RiveAnimation widget.
  final riveAnimationAnimationsList = [
    'Inprogress',
  ];
  List<FlutterFlowRiveController> riveAnimationControllers = [];
  // Stores action output result for [Custom Action - powersyncLastSyncAt] action in IconButton widget.
  DateTime? lastSyncAt;

  @override
  void initState(BuildContext context) {
    riveAnimationAnimationsList.forEach((name) {
      riveAnimationControllers.add(FlutterFlowRiveController(
        name,
        shouldLoop: true,
      ));
    });
  }

  @override
  void dispose() {}
}

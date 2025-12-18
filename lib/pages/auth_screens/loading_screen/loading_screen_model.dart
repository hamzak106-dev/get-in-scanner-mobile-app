import '/flutter_flow/flutter_flow_rive_controller.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'loading_screen_widget.dart' show LoadingScreenWidget;
import 'package:flutter/material.dart';

class LoadingScreenModel extends FlutterFlowModel<LoadingScreenWidget> {
  ///  Local state fields for this page.

  bool showButtons = false;

  ///  State fields for stateful widgets in this page.

  // State field(s) for RiveAnimation widget.
  final riveAnimationAnimationsList = [
    'Timeline 1',
  ];
  List<FlutterFlowRiveController> riveAnimationControllers = [];

  @override
  void initState(BuildContext context) {
    riveAnimationAnimationsList.forEach((name) {
      riveAnimationControllers.add(FlutterFlowRiveController(
        name,
      ));
    });
  }

  @override
  void dispose() {}
}

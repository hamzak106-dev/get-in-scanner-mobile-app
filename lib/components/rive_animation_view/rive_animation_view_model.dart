import '/flutter_flow/flutter_flow_rive_controller.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'rive_animation_view_widget.dart' show RiveAnimationViewWidget;
import 'package:flutter/material.dart';

class RiveAnimationViewModel extends FlutterFlowModel<RiveAnimationViewWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for RiveAnimation widget.
  final riveAnimationAnimationsList1 = [
    'Timeline 1',
  ];
  List<FlutterFlowRiveController> riveAnimationControllers1 = [];
  // State field(s) for RiveAnimation widget.
  final riveAnimationAnimationsList2 = [
    'Timeline 1',
  ];
  List<FlutterFlowRiveController> riveAnimationControllers2 = [];
  // State field(s) for RiveAnimation widget.
  final riveAnimationAnimationsList3 = [
    'loading logo',
  ];
  List<FlutterFlowRiveController> riveAnimationControllers3 = [];
  // State field(s) for RiveAnimation widget.
  final riveAnimationAnimationsList4 = [
    'Timeline 1',
  ];
  List<FlutterFlowRiveController> riveAnimationControllers4 = [];
  // State field(s) for RiveAnimation widget.
  final riveAnimationAnimationsList5 = [
    'Inprogress',
  ];
  List<FlutterFlowRiveController> riveAnimationControllers5 = [];

  @override
  void initState(BuildContext context) {
    riveAnimationAnimationsList1.forEach((name) {
      riveAnimationControllers1.add(FlutterFlowRiveController(
        name,
        shouldLoop: true,
      ));
    });

    riveAnimationAnimationsList2.forEach((name) {
      riveAnimationControllers2.add(FlutterFlowRiveController(
        name,
        shouldLoop: true,
      ));
    });

    riveAnimationAnimationsList3.forEach((name) {
      riveAnimationControllers3.add(FlutterFlowRiveController(
        name,
        shouldLoop: true,
      ));
    });

    riveAnimationAnimationsList4.forEach((name) {
      riveAnimationControllers4.add(FlutterFlowRiveController(
        name,
        shouldLoop: true,
      ));
    });

    riveAnimationAnimationsList5.forEach((name) {
      riveAnimationControllers5.add(FlutterFlowRiveController(
        name,
        shouldLoop: true,
      ));
    });
  }

  @override
  void dispose() {}
}

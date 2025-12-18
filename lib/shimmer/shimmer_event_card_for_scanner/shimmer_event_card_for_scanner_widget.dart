import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'shimmer_event_card_for_scanner_model.dart';
export 'shimmer_event_card_for_scanner_model.dart';

class ShimmerEventCardForScannerWidget extends StatefulWidget {
  const ShimmerEventCardForScannerWidget({super.key});

  @override
  State<ShimmerEventCardForScannerWidget> createState() =>
      _ShimmerEventCardForScannerWidgetState();
}

class _ShimmerEventCardForScannerWidgetState
    extends State<ShimmerEventCardForScannerWidget>
    with TickerProviderStateMixin {
  late ShimmerEventCardForScannerModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ShimmerEventCardForScannerModel());

    animationsMap.addAll({
      'containerOnPageLoadAnimation': AnimationInfo(
        loop: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 1200.0.ms,
            color: Color(0x4C000000),
            angle: 0.524,
          ),
        ],
      ),
    });
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 112.0,
      decoration: BoxDecoration(
        color: Color(0xFFDADBDD),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: FlutterFlowTheme.of(context).tertiary,
        ),
      ),
    ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation']!);
  }
}

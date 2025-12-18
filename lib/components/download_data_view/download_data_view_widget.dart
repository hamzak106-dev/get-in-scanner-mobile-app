import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'download_data_view_model.dart';
export 'download_data_view_model.dart';

class DownloadDataViewWidget extends StatefulWidget {
  const DownloadDataViewWidget({super.key});

  @override
  State<DownloadDataViewWidget> createState() => _DownloadDataViewWidgetState();
}

class _DownloadDataViewWidgetState extends State<DownloadDataViewWidget>
    with TickerProviderStateMixin {
  late DownloadDataViewModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DownloadDataViewModel());

    animationsMap.addAll({
      'iconOnPageLoadAnimation': AnimationInfo(
        loop: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.linear,
            delay: 0.0.ms,
            duration: 600.0.ms,
            color: FlutterFlowTheme.of(context).primary,
            angle: 1.571,
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FaIcon(
          FontAwesomeIcons.download,
          color: FlutterFlowTheme.of(context).primaryText,
          size: 24.0,
        ).animateOnPageLoad(animationsMap['iconOnPageLoadAnimation']!),
        Text(
          'Downloading',
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: 'MonaSans',
                letterSpacing: 0.0,
              ),
        ),
      ].divide(SizedBox(height: 12.0)),
    );
  }
}

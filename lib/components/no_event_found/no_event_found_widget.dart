import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'no_event_found_model.dart';
export 'no_event_found_model.dart';

class NoEventFoundWidget extends StatefulWidget {
  const NoEventFoundWidget({super.key});

  @override
  State<NoEventFoundWidget> createState() => _NoEventFoundWidgetState();
}

class _NoEventFoundWidgetState extends State<NoEventFoundWidget> {
  late NoEventFoundModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NoEventFoundModel());
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
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
          child: Icon(
            FFIcons.kicPrivacy,
            color: FlutterFlowTheme.of(context).info,
            size: 70.0,
          ),
        ),
        Text(
          'No Events Available',
          textAlign: TextAlign.center,
          style: FlutterFlowTheme.of(context).titleSmall.override(
                fontFamily: 'MonaSans',
                letterSpacing: 0.0,
              ),
        ),
        Text(
          'You currently have no events at this time.',
          textAlign: TextAlign.center,
          style: FlutterFlowTheme.of(context).labelMedium.override(
                fontFamily: 'MonaSans',
                letterSpacing: 0.0,
              ),
        ),
      ].divide(SizedBox(height: 12.0)),
    );
  }
}

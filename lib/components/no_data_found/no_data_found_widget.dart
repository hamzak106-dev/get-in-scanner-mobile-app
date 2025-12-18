import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'no_data_found_model.dart';
export 'no_data_found_model.dart';

class NoDataFoundWidget extends StatefulWidget {
  const NoDataFoundWidget({super.key});

  @override
  State<NoDataFoundWidget> createState() => _NoDataFoundWidgetState();
}

class _NoDataFoundWidgetState extends State<NoDataFoundWidget> {
  late NoDataFoundModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NoDataFoundModel());
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
          'No Data Available',
          textAlign: TextAlign.center,
          style: FlutterFlowTheme.of(context).titleSmall.override(
                fontFamily: 'MonaSans',
                letterSpacing: 0.0,
              ),
        ),
        Text(
          'There is currently no data to display.',
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

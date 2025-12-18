import '/components/screen_component/scan_component/scan_component_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'scan_screen_model.dart';
export 'scan_screen_model.dart';

class ScanScreenWidget extends StatefulWidget {
  const ScanScreenWidget({super.key});

  static String routeName = 'ScanScreen';
  static String routePath = '/scanScreen';

  @override
  State<ScanScreenWidget> createState() => _ScanScreenWidgetState();
}

class _ScanScreenWidgetState extends State<ScanScreenWidget> {
  late ScanScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ScanScreenModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'ScanScreen'});
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: wrapWithModel(
        model: _model.scanComponentModel,
        updateCallback: () => safeSetState(() {}),
        child: ScanComponentWidget(),
      ),
    );
  }
}

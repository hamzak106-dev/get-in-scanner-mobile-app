import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'lookup_scanner_bottom_sheet_model.dart';
export 'lookup_scanner_bottom_sheet_model.dart';

class LookupScannerBottomSheetWidget extends StatefulWidget {
  const LookupScannerBottomSheetWidget({super.key});

  @override
  State<LookupScannerBottomSheetWidget> createState() =>
      _LookupScannerBottomSheetWidgetState();
}

class _LookupScannerBottomSheetWidgetState
    extends State<LookupScannerBottomSheetWidget> {
  late LookupScannerBottomSheetModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LookupScannerBottomSheetModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondary,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(0.0),
              bottomRight: Radius.circular(0.0),
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'To auto check-in tickets, close this and use the \'Scan\' on the bottom.',
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).bodySmall.override(
                        fontFamily: 'MonaSans',
                        color: FlutterFlowTheme.of(context).alternate,
                        letterSpacing: 0.0,
                      ),
                ),
                Text(
                  'Lookup Mode',
                  style: FlutterFlowTheme.of(context).labelLarge.override(
                        fontFamily: 'MonaSans',
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ].divide(SizedBox(height: 8.0)),
            ),
          ),
        ),
        Flexible(
          child: Stack(
            children: [
              custom_widgets.QrScanner(
                width: double.infinity,
                height: double.infinity,
                onScan: (value) async {
                  logFirebaseEvent('LOOKUP_SCANNER_BOTTOM_SHEET_Container_61');
                  Navigator.pop(context, value);
                },
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 0.0, 0.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    logFirebaseEvent(
                        'LOOKUP_SCANNER_BOTTOM_SHEET_Icon_f92lh2w');
                    await actions.enableLight();
                  },
                  child: Icon(
                    FFIcons.kicBulb,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 30.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

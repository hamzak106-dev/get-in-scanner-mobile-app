import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';

class DisableAlertWidget extends StatefulWidget {
  final VoidCallback onAction;

  const DisableAlertWidget({super.key, required this.onAction});

  @override
  State<DisableAlertWidget> createState() => _DisableAlertWidgetState();
}

class _DisableAlertWidgetState extends State<DisableAlertWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(20.0, 16.0, 20.0, 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 50.0,
              height: 5.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).accent1,
                borderRadius: BorderRadius.circular(100.0),
              ),
            ),
            SizedBox(height: 20.0),

            // Titlex
            Text(
              'Disable Tap to Pay on iPhone',
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Mona Sans',
                    color: FlutterFlowTheme.of(context).alternate,
                    fontSize: 16.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            SizedBox(height: 10.0),

            // Content
            Text(
              'Are you sure you want to disable Tap to Pay on iPhone?',
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Mona Sans',
                    color: FlutterFlowTheme.of(context).alternate,
                    fontSize: 14.0,
                    letterSpacing: 0.0,
                  ),
            ),
            SizedBox(height: 20.0),

            // Disable Button
            FFButtonWidget(
              onPressed: widget.onAction,
              text: 'DISABLE',
              options: FFButtonOptions(
                width: MediaQuery.sizeOf(context).width * 1.0,
                height: 48.0,
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: Color(0xFFFF281B), // Red color for destructive action
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                      fontFamily: 'Mona Sans',
                      color: Colors.white,
                      fontSize: 14.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                    ),
                elevation: 0.0,
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            SizedBox(height: 10.0),

            // Cancel Button
            FFButtonWidget(
              onPressed: () async {
                logFirebaseEvent('CANCEL_DISABLE_BTN_ON_TAP');
                Navigator.of(context).pop();
              },
              text: 'CANCEL',
              options: FFButtonOptions(
                width: MediaQuery.sizeOf(context).width * 1.0,
                height: 48.0,
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: FlutterFlowTheme.of(context).secondaryBackground,
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                      fontFamily: 'Mona Sans',
                      color: Colors.white,
                      fontSize: 14.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                    ),
                elevation: 0.0,
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

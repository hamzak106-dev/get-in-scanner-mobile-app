import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart' as loc;

import '../../custom_code/actions/requestion_location_permission.dart' as actions;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'location_permission_bottom_sheet_model.dart';

export 'location_permission_bottom_sheet_model.dart';

class LocationPermissionBottomSheetWidget extends StatefulWidget {
  final VoidCallback onContinue;

  const LocationPermissionBottomSheetWidget({super.key, required this.onContinue});

  @override
  State<LocationPermissionBottomSheetWidget> createState() =>
      _LocationPermissionBottomSheetWidgetState();
}

class _LocationPermissionBottomSheetWidgetState
    extends State<LocationPermissionBottomSheetWidget> {
  late LocationPermissionBottomSheetModel _model;
  bool showOpenSettings = false;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LocationPermissionBottomSheetModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.sizeOf(context).width * 1.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondary,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0.0),
            bottomRight: Radius.circular(0.0),
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20.0, 16.0, 20.0, 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 50.0,
                  height: 5.0,
                  constraints: BoxConstraints(
                    maxWidth: 100.0,
                  ),
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).accent1,
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width * 1.0,
                decoration: BoxDecoration(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'LOCATION REQUIRED',
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Mona Sans',
                            color: FlutterFlowTheme.of(context).alternate,
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Text(
                      'To activate Tap to Pay on iPhone, we need access to your location.',
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Mona Sans',
                            color: FlutterFlowTheme.of(context).alternate,
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                          ),
                    ),
                    if (!showOpenSettings)
                      FFButtonWidget(
                        onPressed: () async {
                          final loc.PermissionStatus status =
                              await actions.requestLocationPermissionStatus();
                          log('Location permission status: ${status.name}');
                          logFirebaseEvent('LOCATION_PERMISSION_CONTINUE_BTN');
                          if (status == loc.PermissionStatus.granted) {
                            widget.onContinue();
                            Navigator.pop(context);
                            return;
                          }
                          if (status == loc.PermissionStatus.denied || status == loc.PermissionStatus.deniedForever) {
                            setState(() => showOpenSettings = true);
                            return;

                          }
                        },
                        text: 'CONTINUE',
                        options: FFButtonOptions(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          height: 48.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                          textStyle: FlutterFlowTheme.of(context)
                              .titleSmall
                              .override(
                                fontFamily: 'Mona Sans',
                                color: Colors.white,
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                              ),
                          elevation: 0.0,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      )
                    else
                      Column(
                        children: [
                          Text(
                            'Location permission is required to use Tap to Pay. Please enable it in settings.',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Mona Sans',
                                  color: FlutterFlowTheme.of(context).alternate,
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                ),
                          ),
                          SizedBox(height: 10),
                          FFButtonWidget(
                            onPressed: () async {
                              await openAppSettings();
                            },
                            text: 'OPEN SETTINGS',
                            options: FFButtonOptions(
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              height: 48.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context).secondaryBackground,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
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
                  ].divide(SizedBox(height: 20.0)),
                ),
              ),
            ].divide(SizedBox(height: 20.0)),
          ),
        ),
      ),
    );
  }
}

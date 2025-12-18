import 'dart:developer';

import '/backend/schema/enums/enums.dart';
import '/components/rive_animation_view/rive_animation_view_widget.dart';
import '/components/scan_components/scanned_view/scanned_view_widget.dart';
import '/components/scanner_event_selection/scanner_event_selection_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'scan_component_model.dart';
export 'scan_component_model.dart';

class ScanComponentWidget extends StatefulWidget {
  const ScanComponentWidget({super.key});

  @override
  State<ScanComponentWidget> createState() => _ScanComponentWidgetState();
}

class _ScanComponentWidgetState extends State<ScanComponentWidget> {
  late ScanComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ScanComponentModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          child: custom_widgets.QrScanner(
            width: double.infinity,
            height: double.infinity,
            onScan: (value) async {
              logFirebaseEvent('SCAN_COMPONENT_Container_az5p2cin_CALLBA');
              _model.scannedValue = value;
              _model.logId = random_data.randomInteger(0, 99999999) + 99999999;
              _model.permissionResult = await actions.checkPermissionForScanTicket(
                value,
                functions
                    .parseEventRow(FFAppState().selectedEvent.toList())
                    .map((e) => e.eventId)
                    .toList(),
              );
              if (_model.permissionResult == ScanResult.VALID) {
                _model.attendeeResponse = await actions.findAttendee(
                  value,
                  functions
                      .parseEventRow(FFAppState().selectedEvent.toList())
                      .map((e) => e.eventId)
                      .toList(),
                );
                log(_model.attendeeResponse.toString());


                if (_model.attendeeResponse != null) {
                    if (_model.attendeeResponse?.ticketStatus != 2) {
                      _model.scanResult = ScanResult.INVALID;
                      _model.attendee = _model.attendeeResponse;
                      _model.event = functions
                          .parseEventRow(FFAppState().selectedEvent.toList())
                          .where((e) =>
                              e.eventId == _model.attendeeResponse?.eventId)
                          .toList()
                          .firstOrNull;
                    } else if ((_model
                                .scannerEventSelectionModel.selectedIndex ==
                            0) &&
                        (_model.attendeeResponse?.status !=
                            ScanResult.CHECK_IN.name)) {
                      _model.scanResult = ScanResult.CHECK_IN;
                      _model.attendee = _model.attendeeResponse;
                      _model.event = functions
                          .parseEventRow(FFAppState().selectedEvent.toList())
                          .where((e) =>
                              e.eventId == _model.attendeeResponse?.eventId)
                          .toList()
                          .firstOrNull;
                      // await actions.updateAttendeeStatus(
                      //   _model.attendeeResponse,
                      //   _model.logId,
                      //   _model.scanResult!,
                      // );
                    } else if (_model
                            .scannerEventSelectionModel.selectedIndex ==
                        1) {
                      _model.scanResult = ScanResult.REVALIDATE;
                      _model.attendee = _model.attendeeResponse;
                      _model.event = functions
                          .parseEventRow(FFAppState().selectedEvent.toList())
                          .where((e) =>
                              e.eventId == _model.attendeeResponse?.eventId)
                          .toList()
                          .firstOrNull;
                    } else if ((_model
                                .scannerEventSelectionModel.selectedIndex ==
                            2) &&
                        (_model.attendeeResponse?.status !=
                            ScanResult.CHECK_OUT.name)) {
                      _model.scanResult = ScanResult.CHECK_OUT;
                      _model.attendee = _model.attendeeResponse;
                      _model.event = functions
                          .parseEventRow(FFAppState().selectedEvent.toList())
                          .where((e) =>
                              e.eventId == _model.attendeeResponse?.eventId)
                          .toList()
                          .firstOrNull;
                      // await actions.updateAttendeeStatus(
                      //   _model.attendeeResponse,
                      //   _model.logId,
                      //   _model.scanResult!,
                      // );
                    } else {
                      _model.scanResult = ScanResult.USED;
                      _model.attendee = _model.attendeeResponse;
                      _model.event = functions
                          .parseEventRow(FFAppState().selectedEvent.toList())
                          .where((e) =>
                              e.eventId == _model.attendeeResponse?.eventId)
                          .toList()
                          .firstOrNull;
                    }
                } else {
                  _model.scanResult = ScanResult.NOT_FOUND;
                  _model.event = FFAppState().selectedEvent.length == 1
                      ? functions.parseEventRow(FFAppState().selectedEvent.toList()).firstOrNull
                      : null;
                }
                try{
                  await actions.addCheckInLog(
                    _model.scanResult!,
                    _model.logId,
                    _model.attendeeResponse,
                    FFAppState().user.deviceId,
                    _model.event?.eventId,
                    FFAppState().user.userId,
                    getCurrentTimestamp.toString(),
                    value,
                  );
                }catch(e){
                  debugPrint("============= Add Check In Logs ERROR ============");
                  debugPrint(e.toString());
                  debugPrint("==================================================");
                }
              } else {
                _model.scanResult = _model.permissionResult;
              }
              safeSetState(() {});
            },
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20.0, 50.0, 20.0, 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              wrapWithModel(
                model: _model.scannerEventSelectionModel,
                updateCallback: () => safeSetState(() {}),
                child: ScannerEventSelectionWidget(
                  initialIndex: _model.selectedIndex,
                  onTapChange: (value) async {
                    logFirebaseEvent('SCAN_COMPONENT_Container_8h2q7khr_CALLBA');
                    _model.selectedIndex = value;
                    safeSetState(() {});
                  },
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Automatic',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'MonaSans',
                          letterSpacing: 0.0,
                        ),
                  ),
                  Icon(
                    FFIcons.kicArrowRight,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 16.0,
                  ),
                  Text(
                    'Check In',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'MonaSans',
                          letterSpacing: 0.0,
                        ),
                  ),
                ].divide(SizedBox(width: 10.0)),
              ),
              if (FFAppState().selectedEvent.length == 1)
                Text(
                  '${functions.parseEventRow(FFAppState().selectedEvent.toList()).firstOrNull?.title} ${dateTimeFormat("dd-MMM-yyyy", functions.parseEventRow(FFAppState().selectedEvent.toList()).firstOrNull?.startDate)} at ${dateTimeFormat("hh:mm a", functions.parseEventRow(FFAppState().selectedEvent.toList()).firstOrNull?.startDate)}',
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'MonaSans',
                        letterSpacing: 0.0,
                      ),
                ),
              SizedBox(height: 45,),
            ].divide(SizedBox(height: 8.0)),
          ),
        ),
        if (FFAppState().syncStatus.downloading && !FFAppState().hasFirstSync)
          wrapWithModel(
            model: _model.riveAnimationViewModel,
            updateCallback: () => safeSetState(() {}),
            child: RiveAnimationViewWidget(
              type: RiveAnimType.BarcodeLoading,
            ),
          ),
        if (_model.scanResult != null)
          wrapWithModel(
            model: _model.scannedViewModel,
            updateCallback: () => safeSetState(() {}),
            child: ScannedViewWidget(
              result: _model.scanResult!,
              scannedValue: _model.scannedValue,
              scanForIndex: _model.scannerEventSelectionModel.selectedIndex,
              attendee: _model.attendee,
              event: _model.event,
              onTap: () async {
                logFirebaseEvent('SCAN_COMPONENT_Container_dzpn50tm_CALLBA');
                await actions.startScanner();
                _model.scanResult = null;
                _model.attendee = null;
                _model.event = null;
                safeSetState(() {});
              },
              onScanForChange: (value) async {
                logFirebaseEvent('SCAN_COMPONENT_Container_dzpn50tm_CALLBA');
                _model.selectedIndex = value;
                safeSetState(() {});
              },
            ),
          ),
      ],
    );
  }
}

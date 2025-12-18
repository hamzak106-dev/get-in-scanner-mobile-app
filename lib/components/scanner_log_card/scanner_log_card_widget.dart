import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'scanner_log_card_model.dart';
export 'scanner_log_card_model.dart';

class ScannerLogCardWidget extends StatefulWidget {
  const ScannerLogCardWidget({
    super.key,
    required this.checkInLog,
  });

  final CheckInLogsRow? checkInLog;

  @override
  State<ScannerLogCardWidget> createState() => _ScannerLogCardWidgetState();
}

class _ScannerLogCardWidgetState extends State<ScannerLogCardWidget> {
  late ScannerLogCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ScannerLogCardModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('SCANNER_LOG_CARD_ScannerLogCard_ON_INIT_');
      _model.attendeeResponse = await actions.findAttendee(
        widget.checkInLog?.scanResult,
        ((int eventId) {
          return [eventId];
        }(widget.checkInLog!.eventId!))
            .toList(),
      );
      _model.attendee = _model.attendeeResponse;
      safeSetState(() {});
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
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      valueOrDefault<String>(
                        _model.attendee != null
                            ? _model.attendee?.name
                            : widget.checkInLog?.scanResult,
                        ' N/A',
                      ),
                      maxLines: 2,
                      style: FlutterFlowTheme.of(context).bodyLarge.override(
                            fontFamily: 'MonaSans',
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Builder(
                          builder: (context) {
                            if (widget.checkInLog?.status == ScanResult.CHECK_IN.name) {
                              return Icon(
                                FFIcons.kicCheckFillCircle,
                                color: FlutterFlowTheme.of(context).success,
                                size: 24.0,
                              );
                            } else if (widget.checkInLog?.status == ScanResult.USED.name) {
                              return Icon(
                                FFIcons.kicError,
                                color: FlutterFlowTheme.of(context).warning,
                                size: 24.0,
                              );
                            } else if (widget.checkInLog?.status == ScanResult.CHECK_OUT.name) {
                              return Icon(
                                FFIcons.kicCheckOut,
                                color: FlutterFlowTheme.of(context).success,
                                size: 24.0,
                              );
                            } else if (widget.checkInLog?.status == ScanResult.REVALIDATE.name) {
                              return Icon(
                                Icons.playlist_add_check_circle_rounded,
                                color: FlutterFlowTheme.of(context).success,
                                size: 24.0,
                              );
                            } else {
                              return Icon(
                                FFIcons.kicDanger,
                                color: FlutterFlowTheme.of(context).error,
                                size: 24.0,
                              );
                            }
                          },
                        ),
                        Text(
                          widget.checkInLog!.status,
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'MonaSans',
                                color: () {
                                  if ((widget.checkInLog?.status == ScanResult.CHECK_IN.name) ||
                                      (widget.checkInLog?.status == ScanResult.CHECK_OUT.name) ||
                                      (widget.checkInLog?.status == ScanResult.REVALIDATE.name)) {
                                    return FlutterFlowTheme.of(context).success;
                                  } else if (widget.checkInLog?.status == ScanResult.USED.name) {
                                    return FlutterFlowTheme.of(context).warning;
                                  } else {
                                    return FlutterFlowTheme.of(context).error;
                                  }
                                }(),
                                letterSpacing: 0.0,
                              ),
                        ),
                        Text(
                          valueOrDefault<String>(
                            dateTimeFormat(
                                "relative", widget.checkInLog?.scanAt),
                            'N/A',
                          ),
                          style: FlutterFlowTheme.of(context).labelMedium.override(
                                fontFamily: 'MonaSans',
                                letterSpacing: 0.0,

                              ),
                        ),
                      ].divide(SizedBox(width: 8.0)),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                          child: Text(
                            '${widget.checkInLog?.scanResult}${_model.attendee != null ? ' - ${_model.attendee?.ticketName}' : ''}',
                            style: FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'MonaSans',
                                  color: FlutterFlowTheme.of(context).info,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ].divide(SizedBox(height: 8.0)),
                ),
              ),
              if (false)
                Icon(
                  FFIcons.kicError,
                  color: FlutterFlowTheme.of(context).accent2,
                  size: 24.0,
                ),
            ],
          ),
        ),
        Divider(
          height: 1.0,
          thickness: 1.0,
          color: FlutterFlowTheme.of(context).accent2,
        ),
      ],
    );
  }
}

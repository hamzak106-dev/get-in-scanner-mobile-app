import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:rive/rive.dart' hide LinearGradient;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'event_card_for_scanner_model.dart';
export 'event_card_for_scanner_model.dart';

class EventCardForScannerWidget extends StatefulWidget {
  const EventCardForScannerWidget({
    super.key,
    required this.onTap,
    required this.event,
  });

  final Future Function()? onTap;
  final EventsRow? event;

  @override
  State<EventCardForScannerWidget> createState() => _EventCardForScannerWidgetState();
}

class _EventCardForScannerWidgetState extends State<EventCardForScannerWidget> {
  late EventCardForScannerModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EventCardForScannerModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        logFirebaseEvent('EVENT_CARD_FOR_SCANNER_Container_d3icgic');
        await widget.onTap?.call();
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0x322A2C32), Color(0x340E0F11)],
            stops: [0.0, 1.0],
            begin: AlignmentDirectional(0.0, -1.0),
            end: AlignmentDirectional(0, 1.0),
          ),
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: FlutterFlowTheme.of(context).tertiary,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      valueOrDefault<String>(
                        widget.event?.title,
                        'N/A',
                      ),
                      maxLines: 2,
                      style: FlutterFlowTheme.of(context).bodyLarge.override(
                            fontFamily: 'MonaSans',
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  Icon(
                    FFIcons.kicArrowNext,
                    color: FlutterFlowTheme.of(context).secondaryText,
                    size: 20.0,
                  ),
                ].divide(SizedBox(width: 12.0)),
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                  child: Text(
                    valueOrDefault<String>(
                      dateTimeFormat("dd MMM yyyy", widget.event?.startDate),
                      ' -',
                    ),
                    style: FlutterFlowTheme.of(context).labelMedium.override(
                          fontFamily: 'MonaSans',
                          color: Color(0xCCFFFFFF),
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondary,
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20.0, 10.0, 20.0, 10.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              FFIcons.kicOutlineUser,
                              color: FlutterFlowTheme.of(context).primaryBackground,
                              size: 16.0,
                            ),
                            Builder(
                              builder: (context) {
                                // Defensive null checks to avoid runtime null-check errors
                                final ev = widget.event;
                                final syncStatus = FFAppState().syncStatus;
                                final priorityList = syncStatus.prioritySyncedStatus; // getter returns non-null
                                final int? pr = ev?.priority;

                                // Determine whether this priority index is marked as synced
                                final bool isPrioritySynced =
                                    (pr != null && pr >= 0 && pr < priorityList.length)
                                        ? (priorityList[pr] == true)
                                        : false;

                                final bool inProgress = ev?.syncStatus == 'InProgress';

                                if (!inProgress && isPrioritySynced) {
                                  return Text(
                                    valueOrDefault<String>(
                                      ev?.totalAttendees?.toString(),
                                      '0',
                                    ),
                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: 'MonaSans',
                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  );
                                } else {
                                  return Container(
                                    width: 16.0,
                                    height: 16.0,
                                    child: RiveAnimation.asset(
                                      'assets/rive_animations/syncing.riv',
                                      artboard: 'Inprogress',
                                      fit: BoxFit.contain,
                                      controllers: _model.riveAnimationControllers,
                                    ),
                                  );
                                }
                              },
                            ),
                          ].divide(SizedBox(width: 8.0)),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).tertiary,
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16.0, 10.0, 16.0, 10.0),
                          child: Text(
                            valueOrDefault<String>(
                              'Event ID ${widget.event?.eventId.toString()}',
                              '-',
                            ),
                            style: FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'MonaSans',
                                  color: FlutterFlowTheme.of(context).secondaryText,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

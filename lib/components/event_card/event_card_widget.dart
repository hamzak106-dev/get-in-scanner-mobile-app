import '/backend/supabase/supabase.dart';
import '/components/dialogs/info_dialog/info_dialog_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:rive/rive.dart' hide LinearGradient;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'event_card_model.dart';
export 'event_card_model.dart';

class EventCardWidget extends StatefulWidget {
  const EventCardWidget({
    super.key,
    required this.onTap,
    required this.event,
  });

  final Future Function()? onTap;
  final EventsRow? event;

  @override
  State<EventCardWidget> createState() => _EventCardWidgetState();
}

class _EventCardWidgetState extends State<EventCardWidget> {
  late EventCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EventCardModel());
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
        logFirebaseEvent('EVENT_CARD_COMP_Column_vfqqy55v_ON_TAP');
        await widget.onTap?.call();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12.0, 16.0, 12.0, 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
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
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              FFIcons.kicOutlineUser,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 16.0,
                            ),
                            Builder(
                              builder: (context) {
                                print(FFAppState()
                                    .syncStatus
                                    .prioritySyncedStatus
                                    .elementAtOrNull(widget.event!.priority!));
                                if ((widget.event?.syncStatus == 'InProgress') ||
                                    !FFAppState()
                                        .syncStatus
                                        .prioritySyncedStatus
                                        .elementAtOrNull(widget.event!.priority!)!) {
                                  return Builder(
                                    builder: (context) => InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        logFirebaseEvent('EVENT_CARD_RiveAnimation_8u50wo9i_ON_TAP');
                                        await showDialog(
                                          context: context,
                                          builder: (dialogContext) {
                                            return Dialog(
                                              elevation: 0,
                                              insetPadding: EdgeInsets.zero,
                                              backgroundColor: Colors.transparent,
                                              alignment:
                                                  AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                              child: InfoDialogWidget(
                                                title: 'Checking Updates.....',
                                                isLight: true,
                                                firstTap: () async {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Container(
                                        width: 16.0,
                                        height: 14.0,
                                        child: RiveAnimation.asset(
                                          'assets/rive_animations/syncing.riv',
                                          artboard: 'Inprogress',
                                          fit: BoxFit.contain,
                                          controllers: _model.riveAnimationControllers,
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Text(
                                    valueOrDefault<String>(
                                      widget.event?.totalAttendees?.toString(),
                                      '0',
                                    ),
                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: 'MonaSans',
                                          letterSpacing: 0.0,
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
                      child: Text(
                        valueOrDefault<String>(
                          dateTimeFormat("dd MMM yyyy", widget.event?.startDate),
                          ' -',
                        ),
                        style: FlutterFlowTheme.of(context).labelMedium.override(
                              fontFamily: 'MonaSans',
                              color: FlutterFlowTheme.of(context).secondaryText,
                              letterSpacing: 0.0,
                            ),
                      ),
                    ),
                    Flexible(
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
                  ],
                ),
              ].divide(SizedBox(height: 10.0)),
            ),
          ),
          Divider(
            height: 1.0,
            thickness: 1.0,
            color: FlutterFlowTheme.of(context).secondaryBackground,
          ),
        ],
      ),
    );
  }
}

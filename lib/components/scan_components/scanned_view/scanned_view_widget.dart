import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:g_e_t_i_n_scanner/components/addon_redeamed/redeem_addon_widget.dart'
    show RedeemAddonWidget;
import 'package:g_e_t_i_n_scanner/components/redeem_addon/addon_redeamed_widget.dart'
    show AddonRedeamedWidget;
import 'package:g_e_t_i_n_scanner/flutter_flow/flutter_flow_widgets.dart';
import 'package:provider/provider.dart';

import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/components/combine_text_view/combine_text_view_widget.dart';
import '/components/scanner_event_selection/scanner_event_selection_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '../../../pages/home_screens/add_ons_list_screen/add_ons_list_screen_widget.dart';
import 'scanned_view_model.dart';

export 'scanned_view_model.dart';

class ScannedViewWidget extends StatefulWidget {
  const ScannedViewWidget({
    super.key,
    required this.result,
    required this.onTap,
    this.scannedValue,
    required this.scanForIndex,
    required this.onScanForChange,
    this.attendee,
    this.event,
  });

  final ScanResult? result;
  final Future Function()? onTap;
  final String? scannedValue;
  final int? scanForIndex;
  final Future Function(int value)? onScanForChange;
  final AttendeeRow? attendee;
  final EventsRow? event;

  @override
  State<ScannedViewWidget> createState() => _ScannedViewWidgetState();
}

class _ScannedViewWidgetState extends State<ScannedViewWidget>
    with TickerProviderStateMixin {
  late ScannedViewModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ScannedViewModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('SCANNED_VIEW_ScannedView_ON_INIT_STATE');
      await actions.soundHandler(
        widget.result!,
      );
      if (widget.result == ScanResult.USED) {
        _model.scanByText = await actions.getCheckInBy(
          widget.attendee!.uid,
          widget.scanForIndex!,
        );
      }
      setState(() {});
    });

    animationsMap.addAll({
      'iconOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ScaleEffect(
            curve: Curves.bounceOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(2.0, 2.0),
            end: Offset(1.0, 1.0),
          ),
        ],
      ),
      'iconOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ScaleEffect(
            curve: Curves.bounceOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(2.0, 2.0),
            end: Offset(1.0, 1.0),
          ),
        ],
      ),
      'iconOnPageLoadAnimation3': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ScaleEffect(
            curve: Curves.bounceOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(2.0, 2.0),
            end: Offset(1.0, 1.0),
          ),
        ],
      ),
    });
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
        logFirebaseEvent('SCANNED_VIEW_Container_mfglpdjq_ON_TAP');
        await widget.onTap?.call();
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: () {
            if (widget.result == ScanResult.NOT_FOUND) {
              return FlutterFlowTheme.of(context).error;
            } else if ((widget.result == ScanResult.USED) ||
                (widget.result == ScanResult.INVALID) ||
                (widget.result == ScanResult.NOT_ALLOW)) {
              return FlutterFlowTheme.of(context).warning;
            } else {
              return FlutterFlowTheme.of(context).success;
            }
          }(),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20.0, 50.0, 20.0, 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  wrapWithModel(
                    model: _model.scannerEventSelectionModel,
                    updateCallback: () => safeSetState(() {}),
                    child: ScannerEventSelectionWidget(
                      initialIndex: widget.scanForIndex!,
                      onTapChange: (value) async {
                        logFirebaseEvent(
                            'SCANNED_VIEW_Container_e9zv7y5t_CALLBACK');
                        await widget.onScanForChange?.call(
                          value,
                        );
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
                        'Check${widget.result != null ? 'ed' : ''} In',
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
                ].divide(SizedBox(height: 8.0)),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Builder(
                          builder: (context) {
                            if ((widget.result == ScanResult.NOT_FOUND) ||
                                (widget.result == ScanResult.NOT_ALLOW)) {
                              return Icon(
                                FFIcons.kicDanger,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 48.0,
                              ).animateOnPageLoad(
                                  animationsMap['iconOnPageLoadAnimation1']!);
                            } else if ((widget.result == ScanResult.USED) ||
                                (widget.result == ScanResult.INVALID)) {
                              return Icon(
                                FFIcons.kicPrivacy,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 48.0,
                              ).animateOnPageLoad(
                                  animationsMap['iconOnPageLoadAnimation2']!);
                            } else {
                              return Icon(
                                FFIcons.kicCheckFillCircle,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 48.0,
                              ).animateOnPageLoad(
                                  animationsMap['iconOnPageLoadAnimation3']!);
                            }
                          },
                        ),
                      ].divide(SizedBox(height: 12.0)),
                    ),
                    Expanded(
                      child: Builder(
                        builder: (context) {
                          if ((widget.result != ScanResult.NOT_FOUND) &&
                              (widget.result != ScanResult.NOT_ALLOW)) {
                            return ListView(
                              shrinkWrap: true,
                              children: [
                                Text(
                                  () {
                                    if (widget.result == ScanResult.NOT_FOUND) {
                                      return 'Not Found';
                                    } else if (widget.result ==
                                        ScanResult.USED) {
                                      return 'Already ${_model.scannerEventSelectionModel.selectedIndex == 0 ? 'Checked In' : 'Checked Out'}';
                                    } else if (widget.result ==
                                        ScanResult.CHECK_IN) {
                                      return 'Checked In!';
                                    } else if (widget.result ==
                                        ScanResult.CHECK_OUT) {
                                      return 'Checked out!';
                                    } else if (widget.result ==
                                        ScanResult.INVALID) {
                                      return 'Invalidated';
                                    } else if (widget.result ==
                                        ScanResult.NOT_ALLOW) {
                                      return 'Permission Denied';
                                    } else {
                                      return 'Revalidated';
                                    }
                                  }(),
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .titleLarge
                                      .override(
                                        fontFamily: 'MonaSans',
                                        fontSize: 22.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),

                                if (widget.attendee != null)
                                  Text(
                                    '${valueOrDefault<String>(
                                      widget.attendee?.ticketName,
                                      'N/A',
                                    )} - ${functions.fetchTicketType(widget.attendee?.ticketType ?? 0)}',
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .override(
                                          fontFamily: 'MonaSans',
                                          fontSize: 22.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),

                                // Add a separator here if needed before the CombineTextViews
                                SizedBox(height: 12.0),

                                // The rest of the original ListView content
                                wrapWithModel(
                                  model: _model.combineTextViewModel1,
                                  updateCallback: () => safeSetState(() {}),
                                  child: CombineTextViewWidget(
                                    lable1: 'Name',
                                    lable2: valueOrDefault<String>(
                                      widget.attendee?.name,
                                      'N/A',
                                    ),
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.combineTextViewModel2,
                                  updateCallback: () => safeSetState(() {}),
                                  child: CombineTextViewWidget(
                                    lable1: 'Ticket Comment',
                                    lable2: valueOrDefault<String>(
                                      widget.attendee?.ticketComment,
                                      'N/A',
                                    ),
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.combineTextViewModel3,
                                  updateCallback: () => safeSetState(() {}),
                                  child: CombineTextViewWidget(
                                    lable1: 'User Purchase ID',
                                    lable2: valueOrDefault<String>(
                                      widget.attendee?.purchaseId.toString(),
                                      'N/A',
                                    ),
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.combineTextViewModel4,
                                  updateCallback: () => safeSetState(() {}),
                                  child: CombineTextViewWidget(
                                    lable1: 'Ticket Getin Name',
                                    lable2: valueOrDefault<String>(
                                      widget.attendee?.ticketName,
                                      'N/A',
                                    ),
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.combineTextViewModel5,
                                  updateCallback: () => safeSetState(() {}),
                                  child: CombineTextViewWidget(
                                    lable1: 'Phone',
                                    lable2: valueOrDefault<String>(
                                      widget.attendee?.phone,
                                      'N/A',
                                    ),
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.combineTextViewModel6,
                                  updateCallback: () => safeSetState(() {}),
                                  child: CombineTextViewWidget(
                                    lable1: 'Purchase ID',
                                    lable2: valueOrDefault<String>(
                                      widget.attendee?.transactionNumber
                                          .toString(),
                                      'N/A',
                                    ),
                                  ),
                                ),
                                if (widget.attendee?.seatSection != null &&
                                    widget.attendee?.seatSection != '')
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Seat',
                                        textAlign: TextAlign.start,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .override(
                                              fontFamily: 'MonaSans',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                      Flexible(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  'Section',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'MonaSans',
                                                        fontSize: 14.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                ),
                                                Text(
                                                  valueOrDefault<String>(
                                                    widget
                                                        .attendee?.seatSection,
                                                    '-',
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'MonaSans',
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                ),
                                              ].divide(SizedBox(height: 4.0)),
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  'Row',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'MonaSans',
                                                        fontSize: 14.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                ),
                                                Text(
                                                  valueOrDefault<String>(
                                                    widget.attendee?.seatRow,
                                                    '-',
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'MonaSans',
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                ),
                                              ].divide(SizedBox(height: 4.0)),
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  'Seat',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'MonaSans',
                                                        fontSize: 14.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                ),
                                                Text(
                                                  valueOrDefault<String>(
                                                    widget.attendee?.seatSeat,
                                                    '-',
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'MonaSans',
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                ),
                                              ].divide(SizedBox(height: 4.0)),
                                            ),
                                          ].divide(SizedBox(width: 16.0)),
                                        ),
                                      ),
                                    ],
                                  ),
                                if (widget.attendee?.addOns != null &&
                                    widget.attendee!.addOns.isNotEmpty)
                                  GestureDetector(
                                    onTap: () async {
                                      logFirebaseEvent(
                                          'SCANNED_VIEW_Container_ub0m4l9z_ON_TAP');
                                      await context.pushNamed(
                                          AddOnsListScreenWidget.routeName,
                                          pathParameters: {
                                            'attendeeUid': serializeParam(
                                                widget.attendee!.uid,
                                                ParamType.int)!,
                                          });
                                      widget.onTap?.call();
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 8.0, 12.0, 8.0),
                                      // height: 1.0,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Add-Ons",
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyLarge
                                                        .override(
                                                            fontFamily:
                                                                'MonaSans',
                                                            letterSpacing: 0.0,
                                                            fontSize: 20),
                                              ),
                                              Icon(
                                                FFIcons.kicArrowNext,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 30.0,
                                              ),
                                            ],
                                          ),
                                          if (widget.attendee?.addOns != null &&
                                              widget
                                                  .attendee!.addOns.isNotEmpty)
                                            ...widget.attendee!.addOns
                                                .map((e) =>
                                                    AddonStatus(addon: e))
                                                .toList()
                                        ],
                                      ),
                                    ),
                                  )
                              ].divide(SizedBox(height: 12.0)),
                            );
                          } else if (widget.result == ScanResult.NOT_ALLOW) {
                            // NOT_ALLOW: Re-wrap content to include status text
                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Permission Denied',
                                  style: FlutterFlowTheme.of(context)
                                      .titleLarge
                                      .override(
                                        fontFamily: 'MonaSans',
                                        fontSize: 22.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                SizedBox(height: 12.0),
                                Visibility(
                                  visible:
                                      widget.result == ScanResult.NOT_ALLOW,
                                  child: Text(
                                    'This scanner cannot scan this ticket type. Please contact your event admin.',
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                          fontFamily: 'MonaSans',
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            // NOT_FOUND: Re-wrap content to include status text
                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Not Found',
                                  style: FlutterFlowTheme.of(context)
                                      .titleLarge
                                      .override(
                                        fontFamily: 'MonaSans',
                                        fontSize: 22.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                SizedBox(height: 12.0),
                                Text(
                                  'Barcode',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .override(
                                        fontFamily: 'MonaSans',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                                Text(
                                  valueOrDefault<String>(
                                    widget.scannedValue,
                                    'N/A',
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .override(
                                        fontFamily: 'MonaSans',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ]
                                  .divide(SizedBox(height: 20.0))
                                  .addToEnd(SizedBox(height: 50.0)),
                            );
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 12.0),
                    if ((widget.attendee != null) &&
                        ((widget.attendee?.ticketStatus != 2) ||
                            (widget.result == ScanResult.USED)))
                      Container(
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondary,
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 6.0, 16.0, 6.0),
                          child: Text(
                            valueOrDefault<String>(
                              () {
                                if ((widget.attendee?.ticketStatus == 2) &&
                                    (widget.result == ScanResult.USED)) {
                                  return _model.scanByText;
                                } else if (widget.attendee?.ticketStatus == 1) {
                                  return 'Your ticket is pending and awaiting review.';
                                } else if (widget.attendee?.ticketStatus == 3) {
                                  return 'Your ticket has been declined.';
                                } else if (widget.attendee?.ticketStatus == 4) {
                                  return 'A refund has been issued for your ticket.';
                                } else if (widget.attendee?.ticketStatus == 5) {
                                  return 'Transaction failed.  ';
                                } else if (widget.attendee?.ticketStatus == 6) {
                                  return 'Refund request has been rejected.';
                                } else if (widget.attendee?.ticketStatus == 7) {
                                  return 'This ticket is hidden from view.';
                                } else if (widget.attendee?.ticketStatus == 8) {
                                  return 'This ticket has been marked as abandoned.';
                                } else if (widget.attendee?.ticketStatus ==
                                    10) {
                                  return 'Your ticket has been sent for approval.';
                                } else if (widget.attendee?.ticketStatus ==
                                    11) {
                                  return 'Approval process failed. Please contact support.';
                                } else if (widget.attendee?.ticketStatus ==
                                    15) {
                                  return 'Refund request is pending.';
                                } else if (widget.attendee?.ticketStatus ==
                                    16) {
                                  return 'Your ticket is currently being reviewed for approval.';
                                } else if (widget.attendee?.ticketStatus ==
                                    17) {
                                  return 'A dispute has been raised for this ticket.';
                                } else if (widget.attendee?.ticketStatus ==
                                    18) {
                                  return 'This ticket is on a cancelled waiting list.';
                                } else if (widget.attendee?.ticketStatus ==
                                    19) {
                                  return 'Your ticket has been transferred.';
                                } else {
                                  return 'Your ticket is invalid.';
                                }
                              }(),
                              '-',
                            ),
                            style: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'MonaSans',
                                  color: FlutterFlowTheme.of(context).warning,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              )
            ].divide(SizedBox(height: 8.0)),
          ),
        ),
      ),
    );
  }
}

class AddonStatus extends StatefulWidget {
  final AddOnRow addon;

  const AddonStatus({
    super.key,
    required this.addon,
  });

  @override
  State<AddonStatus> createState() => _AddonStatusState();
}

class _AddonStatusState extends State<AddonStatus> {
  late AddOnRow addon;

  @override
  void initState() {
    addon = widget.addon;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    addon = widget.addon;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            addon.name ?? '',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'MonaSans',
                  letterSpacing: 0.0,
                ),
          ),
          FFButtonWidget(
            onPressed: () async {
              if (addon.status == 1) {
                await showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return AddonRedeamedWidget(
                        title: addon.name,
                      );
                    });
              } else {
                logFirebaseEvent('ADD_ON_DETAILS_SCREEN_Container_1k2x4q5_ON');
                await showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return RedeemAddonWidget(
                        onTap: () {
                          logFirebaseEvent(
                              'ADD_ON_DETAILS_SCREEN_Container_1k2x4q5_ON');
                          actions.updateAddonStatus(
                              int.parse(
                                  addon.attendeeAddOnId.toString() ?? '0'),
                              1);
                          safeSetState(() {
                            addon.status = 1;
                          });
                        },
                        title: addon.name,
                      );
                    });
              }
            },
            text: addon.status == 1 ? 'Redeemed' : 'Not Redeemed',
            options: FFButtonOptions(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'MonaSans',
                    color: Colors.black,
                    letterSpacing: 0.0,
                  ),
              height: 32,
              padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
            ),
          )
        ],
      ),
    );
  }
}

import '../../../components/dialogs/info_dialog/info_dialog_widget.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/components/label_check/label_check_widget.dart';
import '/components/pin_event_selection_bottom_sheet/pin_event_selection_bottom_sheet_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'pin_events_screen_model.dart';
export 'pin_events_screen_model.dart';

class PinEventsScreenWidget extends StatefulWidget {
  const PinEventsScreenWidget({
    super.key,
    this.pin,
    bool? isNew,
  }) : this.isNew = isNew ?? false;

  final PinRow? pin;
  final bool isNew;

  static String routeName = 'PinEventsScreen';
  static String routePath = '/pinEventsScreen';

  @override
  State<PinEventsScreenWidget> createState() => _PinEventsScreenWidgetState();
}

class _PinEventsScreenWidgetState extends State<PinEventsScreenWidget> {
  late PinEventsScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PinEventsScreenModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'PinEventsScreen'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('PIN_EVENTS_SCREEN_PinEventsScreen_ON_INI');
      _model.userPinEvents = await actions.updatePinEventTicketSelection(
        widget.pin?.eventIds,
        widget.pin?.ticketIds,
      );
      _model.pinEvents = _model.userPinEvents!.toList().cast<PinEventStruct>();
      safeSetState(() {});
    });

    _model.switchValue = functions.getAccessPermissionAllow(
        widget.pin!.permissions, AccessPermission.allEvents, null);
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    FlutterFlowIconButton(
                      borderColor: Colors.transparent,
                      borderRadius: 30.0,
                      buttonSize: 40.0,
                      icon: Icon(
                        FFIcons.kicArrowBack,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 24.0,
                      ),
                      onPressed: () async {
                        logFirebaseEvent(
                            'PIN_EVENTS_SCREEN_icArrowBack_ICN_ON_TAP');
                        context.safePop();
                      },
                    ),
                    Expanded(
                      child: Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Text(
                          'Event Access',
                          style:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'MonaSans',
                                    letterSpacing: 0.0,
                                  ),
                        ),
                      ),
                    ),
                  ].addToEnd(SizedBox(width: 40.0)),
                ),
              ),
              Padding(
                padding:
                     EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      width: 1.0,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 20.0, 16.0, 20.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Flexible(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '📅  Access to All Events',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'MonaSans',
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                  Text(
                                    'When enabled, the user can access all events/tickets.',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'MonaSans',
                                          color: Color(0xFF909298),
                                          fontSize: 12.0,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ].divide(SizedBox(height: 8.0)),
                              ),
                            ),
                            Switch.adaptive(
                              value: _model.switchValue!,
                              onChanged: (newValue) async {
                                safeSetState(
                                    () => _model.switchValue = newValue);
                              },
                              activeColor:
                                  FlutterFlowTheme.of(context).primaryText,
                              activeTrackColor: Color(0xFF383A42),
                              inactiveTrackColor: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              inactiveThumbColor: Color(0xFF6B6D75),
                            ),
                          ].divide(SizedBox(width: 16.0)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                      20.0, 0.0, 20.0, 0.0),
                  child: Container(
                    decoration: BoxDecoration(),
                    child: Visibility(
                      visible: !_model.switchValue!,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 24.0, 16.0, 16.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Icon(
                                          FFIcons.kicTicketNew,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          size: 24.0,
                                        ),
                                        Text(
                                          'Select Events',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'MonaSans',
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      ].divide(SizedBox(width: 18.0)),
                                    ),
                                  ),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      logFirebaseEvent(
                                          'PIN_EVENTS_SCREEN_Icon_qao4zsf2_ON_TAP');
                                      await showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                        enableDrag: false,
                                        useSafeArea: true,
                                        context: context,
                                        builder: (context) {
                                          return GestureDetector(
                                            onTap: () {
                                              FocusScope.of(context).unfocus();
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                            },
                                            child: Padding(
                                              padding: MediaQuery.viewInsetsOf(
                                                  context),
                                              child: Container(
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.75,
                                                child:
                                                    PinEventSelectionBottomSheetWidget(),
                                              ),
                                            ),
                                          );
                                        },
                                      ).then((value) => safeSetState(
                                          () => _model.chooseEvent = value));

                                      if (_model.chooseEvent != null) {
                                        if (_model.pinEvents
                                            .where((e) =>
                                                e.uid ==
                                                _model.chooseEvent?.uid)
                                            .toList()
                                            .length <=
                                            0) {
                                          _model.choosePinEvent = await actions
                                              .getPinEventAndTickets(
                                            _model.chooseEvent!,
                                          );
                                          _model.addToPinEvents(
                                              _model.choosePinEvent!);
                                          safeSetState(() {});
                                        }
                                      }

                                      safeSetState(() {});
                                    },
                                    child: Icon(
                                      FFIcons.kicAddFillCircle,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 40.0,
                                    ),
                                  ),
                                ].divide(SizedBox(width: 10.0)),
                              ),
                            ),
                            Builder(
                              builder: (context) {
                                final event = _model.pinEvents.toList();

                                return Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children:
                                      List.generate(event.length, (eventIndex) {
                                    final eventItem = event[eventIndex];
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: eventItem.isSelected
                                            ? Color(0xFFF7F7F7)
                                            : FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                wrapWithModel(
                                                  model: _model
                                                      .labelCheckModels1
                                                      .getModel(
                                                    eventItem.uid.toString(),
                                                    eventIndex,
                                                  ),
                                                  updateCallback: () =>
                                                      safeSetState(() {}),
                                                  child: LabelCheckWidget(
                                                    key: Key(
                                                      'Keyet9_${eventItem.uid.toString()}',
                                                    ),
                                                    title: eventItem.title,
                                                    isCheck:
                                                        eventItem.isSelected,
                                                    bgColor:
                                                         Color(0x00FFFFFF),
                                                    onCheckChange:
                                                        (check) async {
                                                      logFirebaseEvent(
                                                          'PIN_EVENTS_SCREEN_Container_et99hzja_CAL');
                                                      _model
                                                          .updatePinEventsAtIndex(
                                                        eventIndex,
                                                        (e) => e
                                                          ..isSelected = check
                                                          ..tickets = functions
                                                              .checkAllTickets(
                                                                  eventItem
                                                                      .tickets
                                                                      .toList())!
                                                              .toList(),
                                                      );
                                                      safeSetState(() {});
                                                    },
                                                  ),
                                                ),
                                                Divider(
                                                  height: 1.0,
                                                  thickness: 1.0,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .tertiary,
                                                ),
                                              ],
                                            ),
                                            Builder(
                                              builder: (context) {
                                                final ticket =
                                                    eventItem.tickets.toList();

                                                return Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: List.generate(
                                                      ticket.length,
                                                      (ticketIndex) {
                                                    final ticketItem =
                                                        ticket[ticketIndex];
                                                    return LabelCheckWidget(
                                                      key: Key(
                                                          'Key9hi_${ticketIndex}_of_${ticket.length}'),
                                                      title:
                                                          ticketItem.ticketName,
                                                      isCheck:
                                                          ticketItem.isSelected,
                                                      bgColor: ticketItem
                                                              .isSelected
                                                          ? FlutterFlowTheme.of(
                                                                  context)
                                                              .secondary
                                                          : FlutterFlowTheme.of(
                                                                  context)
                                                              .tertiary,
                                                      onCheckChange:
                                                          (check) async {
                                                        logFirebaseEvent(
                                                            'PIN_EVENTS_SCREEN_Container_9hiqrp91_CAL');
                                                        _model
                                                            .updatePinEventsAtIndex(
                                                          eventIndex,
                                                          (e) => e
                                                            ..updateTickets(
                                                              (e) => e[
                                                                  ticketIndex]
                                                                ..isSelected =
                                                                    check,
                                                            )
                                                            ..isSelected = functions
                                                                .isAllCheckTickets(
                                                                    eventItem
                                                                        .tickets
                                                                        .toList()),
                                                        );
                                                        safeSetState(() {});
                                                      },
                                                    );
                                                  }).divide( SizedBox(
                                                      height: 8.0)),
                                                );
                                              },
                                            ),
                                            Padding(
                                              padding:
                                                   EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      0.0, 10.0, 20.0, 10.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      logFirebaseEvent(
                                                          'PIN_EVENTS_SCREEN_Text_pgdri1e7_ON_TAP');
                                                      _model
                                                          .removeAtIndexFromPinEvents(
                                                              eventIndex);
                                                      safeSetState(() {});
                                                    },
                                                    child: Text(
                                                      'Clear from the list',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'MonaSans',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .error,
                                                                fontSize: 16.0,
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ].divide(
                                              SizedBox(height: 16.0)),
                                        ),
                                      ),
                                    );
                                  }).divide(SizedBox(height: 16.0)),
                                );
                              },
                            ),
                          ].divide(SizedBox(height: 24.0)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Builder(
                builder: (context) => Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 20.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      logFirebaseEvent(
                          'PIN_EVENTS_SCREEN_PAGE_SAVE_BTN_ON_TAP');
                      _model.permissionNumber =
                          await actions.updatePermissionBitMask(
                        widget.pin!.permissions,
                        AccessPermission.allEvents,
                        _model.switchValue!,
                      );
                      if (!_model.switchValue!) {
                        _model.selectedIds =
                            await actions.getSelectedPinEventTicket(
                          _model.pinEvents.toList(),
                        );
                        _model.selectedEventIds = getJsonField(
                          _model.selectedIds,
                          r'''$.selectedEventIds''',
                        ).toString();
                        _model.selectedTicketIds = getJsonField(
                          _model.selectedIds,
                          r'''$.selectedTicketIds''',
                        ).toString();
                      }
                      if (!_model.switchValue! && ((_model.selectedEventIds == null ||
                                  _model.selectedEventIds == '') ||
                              (_model.selectedEventIds == 'null')) &&
                          ((_model.selectedTicketIds == null ||
                                  _model.selectedTicketIds == '') ||
                              (_model.selectedTicketIds == 'null'))
                          ) {
                        await showDialog(
                          context: context,
                          builder: (dialogContext) {
                            return Dialog(
                              elevation: 0,
                              insetPadding: EdgeInsets.zero,
                              backgroundColor: Colors.transparent,
                              alignment: AlignmentDirectional(0.0, 0.0)
                                  .resolve(Directionality.of(context)),
                              child: GestureDetector(
                                onTap: () {
                                  FocusScope.of(dialogContext).unfocus();
                                  FocusManager.instance.primaryFocus?.unfocus();
                                },
                                child: InfoDialogWidget(
                                  title: 'Select Events Alert',
                                  subTitle: 'Please select at least one event or ticket',
                                  firstBtnText: 'OK',
                                  firstBtnColor:
                                      FlutterFlowTheme.of(context).accent3,
                                  isLight: true,
                                  firstTap: () async {
                                    context.safePop();
                                  },
                                ),
                              ),
                            );
                          },
                        );
                        return;
                      }
                      _model.updatedPinResponseWithIds =
                          await PinTable().update(
                        data: {
                          'event_ids': _model.selectedEventIds,
                          'ticket_ids': _model.selectedTicketIds,
                          'permissions': _model.permissionNumber,
                        },
                        matchingRows: (rows) => rows.eqOrNull(
                          'uid',
                          widget.pin?.uid,
                        ),
                        returnRows: true,
                      );
                      if (widget.isNew) {
                        context.pushNamed(
                          PinPermissionsScreenWidget.routeName,
                          queryParameters: {
                            'pin': serializeParam(
                              _model.updatedPinResponseWithIds?.firstOrNull,
                              ParamType.SupabaseRow,
                            ),
                            'isNew': serializeParam(
                              true,
                              ParamType.bool,
                            ),
                          }.withoutNulls,
                        );
                      } else {
                        context.safePop();
                      }

                      safeSetState(() {});
                    },
                    text: 'Save',
                    icon: Icon(
                      FFIcons.kicCheckCircle,
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      size: 16.0,
                    ),
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 52.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).success,
                      textStyle: FlutterFlowTheme.of(context)
                          .titleSmall
                          .override(
                            fontFamily: 'MonaSans',
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.normal,
                          ),
                      elevation: 0.0,
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                ),
              ),
            ].divide(SizedBox(height: 12.0)),
          ),
        ),
      ),
    );
  }
}

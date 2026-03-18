import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:g_e_t_i_n_scanner/components/card_scanning/card_scanning_widget.dart';
import 'package:provider/provider.dart';

import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/components/attendee_card/attendee_card_widget.dart';
import '/components/dialogs/info_dialog/info_dialog_widget.dart';
import '/components/event_selection_bottom_sheet/event_selection_bottom_sheet_widget.dart';
import '/components/lookup_scanner_bottom_sheet/lookup_scanner_bottom_sheet_widget.dart';
import '/components/no_attendees_view/no_attendees_view_widget.dart';
import '/components/rive_animation_view/rive_animation_view_widget.dart';
import '/components/search_text_field/search_text_field_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import '../../../custom_code/actions/init_power_sync.dart';
import 'user_dashboard_model.dart';

export 'user_dashboard_model.dart';

class UserDashboardWidget extends StatefulWidget {
  const UserDashboardWidget({super.key});

  @override
  State<UserDashboardWidget> createState() => _UserDashboardWidgetState();
}

class _UserDashboardWidgetState extends State<UserDashboardWidget> {
  late UserDashboardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UserDashboardModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('USER_DASHBOARD_UserDashboard_ON_INIT_STA');
      if (!(FFAppState().selectedEvent.isNotEmpty)) {
        await showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          enableDrag: true,
          useSafeArea: true,
          context: context,
          builder: (context) {
            return Padding(
              padding: MediaQuery.viewInsetsOf(context),
              child: SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.9,
                  child: const EventSelectionBottomSheetWidget()),
            );
          },
        ).then((value) => safeSetState(() {}));
      }
      if (FFAppState().selectedEvent.isEmpty) {
        return;
      }
      await actions.watchAuthorisedAttendees(
        (result) async {
          _model.allowAttendees = await actions.getAttendeeList(
            result?.toList(),
          );
          _model.attedees = _model.allowAttendees!.toList().cast<AttendeeRow>();
          safeSetState(() {});
        },
        functions
            .parseEventRow(FFAppState().selectedEvent.toList())
            .map((e) => e.eventId)
            .toList()
            .toList(),
        true,
        AccessPermission.lookup,
      );
      _model.lookUpAvailable = await actions.isPermissionSelected(
        FFAppState().user.permissions,
        AccessPermission.lookup,
      );
      var utcDate = DateTime.fromMillisecondsSinceEpoch(
          getCurrentTimestamp.secondsSinceEpoch * 1000);
      _model.isLoading = false;
      _model.hasLookUp = _model.lookUpAvailable!;
      _model.isUpcoming = functions
              .parseEventRow(FFAppState().selectedEvent.toList())
              .firstOrNull!
              .endDate
              .secondsSinceEpoch >=
          utcDate.secondsSinceEpoch;
      _model.updatePage(() {});
      _model.allEventsFromStart = await actions.getEventsOfUser();
      _model.events = _model.allEventsFromStart!
          .where((e) => _model.isUpcoming
              ? (e.endDate.secondsSinceEpoch >= utcDate.secondsSinceEpoch)
              : (e.endDate.secondsSinceEpoch < utcDate.secondsSinceEpoch))
          .toList()
          .toList()
          .cast<EventsRow>();
      _model.isFirstEvent = _model.events.firstOrNull?.uid ==
          functions
              .parseEventRow(FFAppState().selectedEvent.toList())
              .firstOrNull
              ?.uid;
      _model.isLastEvent = _model.events.lastOrNull?.uid ==
          functions
              .parseEventRow(FFAppState().selectedEvent.toList())
              .firstOrNull
              ?.uid;
      safeSetState(() {});
      if (isiOS && !FFAppState().tapToPayTutorialDone) {
        actions.getPosEventId().then((posEventId) async {
          if(posEventId == null) return;
          log(posEventId.toString());
          await context.pushNamed(TapToPayDocumentWidget.routeName);
          await showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) {
                return CardScanningWidget(eventId: posEventId);
              });
          FFAppState().tapToPayTutorialDone = true;
          FFAppState().update(() {});
        }).catchError((e) {
          log(e.toString());
        });
      }
    });
  }

  @override
  void dispose() {
    _model.maybeDispose();
    actions.cancelSubscription(attendeesSubscription);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30.0,
                buttonSize: 40.0,
                icon: Icon(
                  FFIcons.kicArrowLeftRound,
                  color: _model.isFirstEvent
                      ? FlutterFlowTheme.of(context).accent4
                      : FlutterFlowTheme.of(context).primaryText,
                  size: 24.0,
                ),
                onPressed: () async {
                  logFirebaseEvent('USER_DASHBOARD_icArrowLeftRound_ICN_ON_T');
                  if (!_model.isFirstEvent) {
                    _model.isLoading = true;
                    _model.updatePage(() {});
                    _model.previousEvents =
                        await actions.choosePreviousNextEvent(
                      false,
                      _model.isUpcoming,
                    );
                    FFAppState().selectedEvent = functions
                        .parseRowToJson(_model.previousEvents?.toList(),
                            _model.previousEvents?.firstOrNull)
                        .toList()
                        .cast<dynamic>();
                    FFAppState().update(() {});
                    var utcDate = DateTime.fromMillisecondsSinceEpoch(
                        getCurrentTimestamp.secondsSinceEpoch * 1000);
                    _model.allEventsFromPrevious =
                        await actions.getEventsOfUser();
                    _model.events = _model.allEventsFromPrevious!
                        .where((e) => _model.isUpcoming
                            ? (e.endDate.secondsSinceEpoch >=
                                utcDate.secondsSinceEpoch)
                            : (e.endDate.secondsSinceEpoch <
                                utcDate.secondsSinceEpoch))
                        .toList()
                        .cast<EventsRow>();
                    _model.isFirstEvent = _model.events.firstOrNull?.uid ==
                        functions
                            .parseEventRow(FFAppState().selectedEvent.toList())
                            .firstOrNull
                            ?.uid;
                    _model.isLastEvent = _model.events.lastOrNull?.uid ==
                        functions
                            .parseEventRow(FFAppState().selectedEvent.toList())
                            .firstOrNull
                            ?.uid;
                    safeSetState(() {});
                    await actions.watchAuthorisedAttendees(
                      (result) async {
                        _model.getAttendeeListResponseLeft =
                            await actions.getAttendeeList(
                          result?.toList(),
                        );
                        _model.attedees = _model.getAttendeeListResponseLeft!
                            .toList()
                            .cast<AttendeeRow>();
                        _model.isLoading = false;
                        safeSetState(() {});
                      },
                      functions
                          .parseEventRow(FFAppState().selectedEvent.toList())
                          .map((e) => e.eventId)
                          .toList(),
                      true,
                      AccessPermission.lookup,
                    );
                  }

                  safeSetState(() {});
                },
              ),
              Expanded(
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    logFirebaseEvent(
                        'USER_DASHBOARD_COMP_Text_qet8uyme_ON_TAP');
                    await _model.openEventsBottomSheetActionBlock(context);
                    if (!(FFAppState().selectedEvent.isNotEmpty)) {
                      return;
                    }
                    var utcDate = DateTime.fromMillisecondsSinceEpoch(
                        getCurrentTimestamp.secondsSinceEpoch * 1000);
                    _model.isLoading = true;
                    _model.isUpcoming = functions
                            .parseEventRow(FFAppState().selectedEvent.toList())
                            .firstOrNull!
                            .endDate
                            .secondsSinceEpoch >=
                        utcDate.secondsSinceEpoch;
                    _model.textClickAllEvents = await EventsTable().queryRows(
                      queryFn: (q) => q
                          .eqOrNull(
                            'creator_user',
                            FFAppState().user.userId,
                          )
                          .order('start_date', ascending: true),
                    );
                    _model.events = _model.textClickAllEvents!
                        .where((e) => _model.isUpcoming
                            ? (e.endDate.secondsSinceEpoch >=
                                utcDate.secondsSinceEpoch)
                            : (e.endDate.secondsSinceEpoch <
                                utcDate.secondsSinceEpoch))
                        .toList()
                        .cast<EventsRow>();
                    _model.isFirstEvent = _model.events.firstOrNull?.uid ==
                        functions
                            .parseEventRow(FFAppState().selectedEvent.toList())
                            .firstOrNull
                            ?.uid;
                    _model.isLastEvent = _model.events.lastOrNull?.uid ==
                        functions
                            .parseEventRow(FFAppState().selectedEvent.toList())
                            .firstOrNull
                            ?.uid;
                    safeSetState(() {});
                    await actions.watchAuthorisedAttendees(
                      (result) async {
                        log('attendee ${result}');
                        _model.getAttendeeListResponseCenter =
                            await actions.getAttendeeList(
                          result?.toList(),
                        );
                        _model.attedees = _model.getAttendeeListResponseCenter!
                            .toList()
                            .cast<AttendeeRow>();
                        _model.isLoading = false;
                        safeSetState(() {});
                      },
                      functions
                          .parseEventRow(FFAppState().selectedEvent.toList())
                          .map((e) => e.eventId)
                          .toList(),
                      true,
                      AccessPermission.lookup,
                    );

                    safeSetState(() {});
                  },
                  child: Text(
                    FFAppState().selectedEvent.length == 1
                        ? valueOrDefault<String>(
                            functions
                                .parseEventRow(
                                    FFAppState().selectedEvent.toList())
                                .firstOrNull
                                ?.title,
                            '-',
                          )
                        : 'Select an Event',
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'MonaSans',
                          fontSize: 16.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                          useGoogleFonts: false,
                        ),
                  ),
                ),
              ),
              FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30.0,
                buttonSize: 40.0,
                icon: Icon(
                  FFIcons.kicArrowRightRound,
                  color: _model.isLastEvent
                      ? FlutterFlowTheme.of(context).accent4
                      : FlutterFlowTheme.of(context).primaryText,
                  size: 24.0,
                ),
                onPressed: () async {
                  logFirebaseEvent('USER_DASHBOARD_icArrowRightRound_ICN_ON_');
                  if (!_model.isLastEvent) {
                    var utcDate = DateTime.fromMillisecondsSinceEpoch(
                        getCurrentTimestamp.secondsSinceEpoch * 1000);
                    _model.isLoading = true;
                    _model.updatePage(() {});
                    _model.nextEvents = await actions.choosePreviousNextEvent(
                      true,
                      _model.isUpcoming,
                    );
                    FFAppState().selectedEvent = functions
                        .parseRowToJson(_model.nextEvents?.toList(),
                            _model.nextEvents?.firstOrNull)
                        .toList()
                        .cast<dynamic>();
                    FFAppState().update(() {});
                    _model.allEventsFromNext = await actions.getEventsOfUser();
                    _model.events = _model.allEventsFromNext!
                        .where((e) => _model.isUpcoming
                            ? (e.endDate.secondsSinceEpoch >=
                                utcDate.secondsSinceEpoch)
                            : (e.endDate.secondsSinceEpoch <
                                utcDate.secondsSinceEpoch))
                        .toList()
                        .cast<EventsRow>();
                    _model.isFirstEvent = _model.events.firstOrNull?.uid ==
                        functions
                            .parseEventRow(FFAppState().selectedEvent.toList())
                            .firstOrNull
                            ?.uid;
                    _model.isLastEvent = _model.events.lastOrNull?.uid ==
                        functions
                            .parseEventRow(FFAppState().selectedEvent.toList())
                            .firstOrNull
                            ?.uid;
                    safeSetState(() {});
                    await actions.watchAuthorisedAttendees(
                      (result) async {
                        _model.getAttendeeListResponseRight =
                            await actions.getAttendeeList(
                          result?.toList(),
                        );
                        _model.attedees = _model.getAttendeeListResponseRight!
                            .toList()
                            .cast<AttendeeRow>();
                        _model.isLoading = false;
                        safeSetState(() {});
                      },
                      functions
                          .parseEventRow(FFAppState().selectedEvent.toList())
                          .map((e) => e.eventId)
                          .toList(),
                      true,
                      AccessPermission.lookup,
                    );
                  }

                  safeSetState(() {});
                },
              ),
            ],
          ),
          Expanded(
            child: Builder(
              builder: (context) {
                if (FFAppState().selectedEvent.isNotEmpty) {
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Align(
                              alignment: const AlignmentDirectional(-1.0, 0.0),
                              child: Text(
                                'Attendees',
                                style: FlutterFlowTheme.of(context)
                                    .titleLarge
                                    .override(
                                      fontFamily: 'MonaSans',
                                      fontSize: 22.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                      useGoogleFonts: false,
                                    ),
                              ),
                            ),
                          ),
                          Builder(
                            builder: (context) => FlutterFlowIconButton(
                              borderColor: Colors.transparent,
                              borderRadius: 20.0,
                              buttonSize: 40.0,
                              fillColor: FlutterFlowTheme.of(context).tertiary,
                              icon: Icon(
                                FFIcons.kicOutlineCamera,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 20.0,
                              ),
                              onPressed: () async {
                                logFirebaseEvent(
                                    'USER_DASHBOARD_icOutlineCamera_ICN_ON_TA');
                                await showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  useSafeArea: true,
                                  context: context,
                                  builder: (context) {
                                    return Padding(
                                      padding: MediaQuery.viewInsetsOf(context),
                                      child: SizedBox(
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                0.9,
                                        child:
                                            const LookupScannerBottomSheetWidget(),
                                      ),
                                    );
                                  },
                                ).then((value) => safeSetState(
                                    () => _model.scannedValue = value));

                                if (_model.scannedValue != null &&
                                    _model.scannedValue != '') {
                                  _model.permissionResult = await actions
                                      .checkPermissionForScanTicket(
                                    _model.scannedValue,
                                    functions
                                        .parseEventRow(
                                            FFAppState().selectedEvent.toList())
                                        .map((e) => e.eventId)
                                        .toList(),
                                  );
                                  if (_model.permissionResult ==
                                      ScanResult.VALID) {
                                    _model.redirectAttendeeResponse =
                                        await actions.findAttendee(
                                      _model.scannedValue,
                                      functions
                                          .parseEventRow(FFAppState()
                                              .selectedEvent
                                              .toList())
                                          .map((e) => e.eventId)
                                          .toList(),
                                    );
                                    if (_model.redirectAttendeeResponse !=
                                        null) {
                                      context.pushNamed(
                                        AttendeesDetailScreenWidget.routeName,
                                        queryParameters: {
                                          'attendee': serializeParam(
                                            _model.redirectAttendeeResponse,
                                            ParamType.SupabaseRow,
                                          ),
                                        }.withoutNulls,
                                      );
                                    } else {
                                      await showDialog(
                                        context: context,
                                        builder: (dialogContext) {
                                          return Dialog(
                                            elevation: 0,
                                            insetPadding: EdgeInsets.zero,
                                            backgroundColor: Colors.transparent,
                                            alignment: AlignmentDirectional(
                                                    0.0, 0.0)
                                                .resolve(
                                                    Directionality.of(context)),
                                            child: InfoDialogWidget(
                                              title: 'No Results',
                                              subTitle: _model.scannedValue,
                                              firstBtnText: 'OK',
                                              firstBtnColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              firstTap: () async {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  } else {
                                    await showDialog(
                                      context: context,
                                      builder: (dialogContext) {
                                        return Dialog(
                                          elevation: 0,
                                          insetPadding: EdgeInsets.zero,
                                          backgroundColor: Colors.transparent,
                                          alignment: AlignmentDirectional(
                                                  0.0, 0.0)
                                              .resolve(
                                                  Directionality.of(context)),
                                          child: InfoDialogWidget(
                                            title: 'Permission Needed',
                                            subTitle:
                                                'You don\'t have permission to access this ticket. Please ask the owner to grant you access.',
                                            firstBtnText: 'OK',
                                            firstBtnColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryText,
                                            firstTap: () async {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  }
                                }

                                safeSetState(() {});
                              },
                            ),
                          ),
                          Container(
                            width: 40.0,
                            height: 40.0,
                            child: custom_widgets.FilterPopUp(
                              width: 40.0,
                              height: 40.0,
                              onChange: (value) async {
                                logFirebaseEvent(
                                    'USER_DASHBOARD_Container_0i8ktp3x_CALLBA');
                                _model.ascending = value == 0;
                                safeSetState(() {});
                              },
                            ),
                          ),
                          if (false)
                            Flexible(
                              child: Align(
                                alignment: AlignmentDirectional(1.0, 0.0),
                                child: FlutterFlowDropDown<String>(
                                  controller: _model.dropDownValueController ??=
                                      FormFieldController<String>(
                                    _model.dropDownValue ??= 'All',
                                  ),
                                  options: ['All', 'Events', 'Sessions'],
                                  onChanged: (val) => safeSetState(
                                      () => _model.dropDownValue = val),
                                  width: 116.0,
                                  height: 40.0,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'MonaSans',
                                        letterSpacing: 0.0,
                                        useGoogleFonts: false,
                                      ),
                                  icon: Icon(
                                    FFIcons.kicDown,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 16.0,
                                  ),
                                  fillColor: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  elevation: 4.0,
                                  borderColor: Colors.transparent,
                                  borderWidth: 0.0,
                                  borderRadius: 5.0,
                                  margin: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 12.0, 12.0, 12.0),
                                  hidesUnderline: true,
                                  isOverButton: false,
                                  isSearchable: false,
                                  isMultiSelect: false,
                                ),
                              ),
                            ),
                        ].divide(SizedBox(width: 16.0)),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: wrapWithModel(
                              model: _model.searchTextFieldModel,
                              updateCallback: () => safeSetState(() {}),
                              child: SearchTextFieldWidget(
                                onChange: () async {
                                  logFirebaseEvent(
                                      'USER_DASHBOARD_Container_n3vxt2oc_CALLBA');

                                  safeSetState(() {});
                                },
                              ),
                            ),
                          ),
                        ].divide(SizedBox(width: 16.0)),
                      ),
                      Expanded(
                        child: Builder(
                          builder: (context) {
                            if (_model.isLoading) {
                              return wrapWithModel(
                                model: _model.riveAnimationViewModel,
                                updateCallback: () => safeSetState(() {}),
                                child: RiveAnimationViewWidget(
                                  fillColor: Colors.transparent,
                                  type: RiveAnimType.AvatarSyncing,
                                  title: '',
                                  subTitle: 'Attendees Are Loading',
                                ),
                              );
                            } else {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: Builder(
                                      builder: (context) {
                                        final attendee = () {
                                          if (_model.status ==
                                              AttendeeFilterBy.CHECK_IN) {
                                            return (_model.ascending
                                                ? functions
                                                    .filterAttendeeList(
                                                        _model.attedees
                                                            .toList(),
                                                        _model
                                                            .searchTextFieldModel
                                                            .textController
                                                            .text)
                                                    .sortedList(
                                                        keyOf: (e) => e.name!,
                                                        desc: false)
                                                    .where((e) =>
                                                        e.status ==
                                                        ScanResult
                                                            .CHECK_IN.name)
                                                    .toList()
                                                : functions
                                                    .filterAttendeeList(
                                                        _model.attedees
                                                            .toList(),
                                                        _model
                                                            .searchTextFieldModel
                                                            .textController
                                                            .text)
                                                    .sortedList(
                                                        keyOf: (e) => e.name!,
                                                        desc: true)
                                                    .where((e) =>
                                                        e.status ==
                                                        ScanResult
                                                            .CHECK_IN.name)
                                                    .toList());
                                          } else if (_model.status ==
                                              AttendeeFilterBy.CHECK_OUT) {
                                            return (_model.ascending
                                                ? functions
                                                    .filterAttendeeList(
                                                        _model.attedees
                                                            .toList(),
                                                        _model
                                                            .searchTextFieldModel
                                                            .textController
                                                            .text)
                                                    .sortedList(
                                                        keyOf: (e) => e.name!,
                                                        desc: false)
                                                    .where((e) =>
                                                        e.status ==
                                                        ScanResult
                                                            .CHECK_OUT.name)
                                                    .toList()
                                                : functions
                                                    .filterAttendeeList(
                                                        _model.attedees
                                                            .toList(),
                                                        _model
                                                            .searchTextFieldModel
                                                            .textController
                                                            .text)
                                                    .sortedList(
                                                        keyOf: (e) => e.name!,
                                                        desc: true)
                                                    .where((e) =>
                                                        e.status ==
                                                        ScanResult
                                                            .CHECK_OUT.name)
                                                    .toList());
                                          } else if (_model.status ==
                                              AttendeeFilterBy.ABSENT) {
                                            return (_model.ascending
                                                ? functions
                                                    .filterAttendeeList(
                                                        _model.attedees
                                                            .toList(),
                                                        _model
                                                            .searchTextFieldModel
                                                            .textController
                                                            .text)
                                                    .sortedList(
                                                        keyOf: (e) => e.name!,
                                                        desc: false)
                                                    .where((e) =>
                                                        e.status == null ||
                                                        e.status == '')
                                                    .toList()
                                                : functions
                                                    .filterAttendeeList(
                                                        _model.attedees
                                                            .toList(),
                                                        _model
                                                            .searchTextFieldModel
                                                            .textController
                                                            .text)
                                                    .sortedList(
                                                        keyOf: (e) => e.name!,
                                                        desc: true)
                                                    .where((e) =>
                                                        e.status == null ||
                                                        e.status == '')
                                                    .toList());
                                          } else {
                                            return (_model.ascending
                                                ? functions
                                                    .filterAttendeeList(
                                                        _model.attedees
                                                            .toList(),
                                                        _model
                                                            .searchTextFieldModel
                                                            .textController
                                                            .text)
                                                    .sortedList(
                                                        keyOf: (e) => e.name!,
                                                        desc: false)
                                                : functions
                                                    .filterAttendeeList(
                                                        _model.attedees
                                                            .toList(),
                                                        _model
                                                            .searchTextFieldModel
                                                            .textController
                                                            .text)
                                                    .sortedList(
                                                        keyOf: (e) => e.name!,
                                                        desc: true));
                                          }
                                        }()
                                            .toList();
                                        if (attendee.isEmpty) {
                                          return Center(
                                            child: NoAttendeesViewWidget(),
                                          );
                                        }

                                        return ListView.builder(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount: attendee.length,
                                          itemBuilder:
                                              (context, attendeeIndex) {
                                            final attendeeItem =
                                                attendee[attendeeIndex];
                                            return AttendeeCardWidget(
                                              key: Key(
                                                  'Keysg4_${attendeeIndex}_of_${attendee.length}'),
                                              attendee: attendeeItem,
                                              onTap: () async {
                                                logFirebaseEvent(
                                                    'USER_DASHBOARD_Container_sg4wzfmh_CALLBA');

                                                context.pushNamed(
                                                  AttendeesDetailScreenWidget
                                                      .routeName,
                                                  queryParameters: {
                                                    'attendee': serializeParam(
                                                      attendeeItem,
                                                      ParamType.SupabaseRow,
                                                    ),
                                                  }.withoutNulls,
                                                );
                                              },
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  if (_model.attedees.isNotEmpty)
                                    Container(
                                      width: double.infinity,
                                      height: 52.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 4.0,
                                            color: Color(0x26000000),
                                            offset: Offset(
                                              1.0,
                                              1.0,
                                            ),
                                            spreadRadius: 0.0,
                                          )
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .tertiary,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(4.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  logFirebaseEvent(
                                                      'USER_DASHBOARD_Container_8qf7vjoy_ON_TAP');
                                                  _model.status =
                                                      AttendeeFilterBy.ALL;
                                                  safeSetState(() {});
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: _model.status ==
                                                            AttendeeFilterBy.ALL
                                                        ? FlutterFlowTheme.of(
                                                                context)
                                                            .secondary
                                                        : Colors.transparent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50.0),
                                                    shape: BoxShape.rectangle,
                                                  ),
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 0.0),
                                                  child: Text(
                                                    'All',
                                                    style:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily:
                                                                  'MonaSans',
                                                              color: _model.status ==
                                                                      AttendeeFilterBy
                                                                          .ALL
                                                                  ? FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground
                                                                  : FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                              fontSize: 14.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              useGoogleFonts:
                                                                  false,
                                                            ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  logFirebaseEvent(
                                                      'USER_DASHBOARD_Container_zvzm5deu_ON_TAP');
                                                  _model.status =
                                                      AttendeeFilterBy.ABSENT;
                                                  safeSetState(() {});
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: _model.status ==
                                                            AttendeeFilterBy
                                                                .ABSENT
                                                        ? FlutterFlowTheme.of(
                                                                context)
                                                            .secondary
                                                        : Colors.transparent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50.0),
                                                    shape: BoxShape.rectangle,
                                                  ),
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 0.0),
                                                  child: Text(
                                                    'Absent',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'MonaSans',
                                                          color: _model
                                                                      .status ==
                                                                  AttendeeFilterBy
                                                                      .ABSENT
                                                              ? FlutterFlowTheme
                                                                      .of(
                                                                          context)
                                                                  .primaryBackground
                                                              : FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryText,
                                                          fontSize: 14.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          useGoogleFonts: false,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  logFirebaseEvent(
                                                      'USER_DASHBOARD_Container_hpz8zwcs_ON_TAP');
                                                  _model.status =
                                                      AttendeeFilterBy
                                                          .CHECK_OUT;
                                                  safeSetState(() {});
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: _model.status ==
                                                            AttendeeFilterBy
                                                                .CHECK_OUT
                                                        ? FlutterFlowTheme.of(
                                                                context)
                                                            .secondary
                                                        : Colors.transparent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50.0),
                                                    shape: BoxShape.rectangle,
                                                  ),
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 0.0),
                                                  child: Text(
                                                    'Out',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'MonaSans',
                                                          color: _model
                                                                      .status ==
                                                                  AttendeeFilterBy
                                                                      .CHECK_OUT
                                                              ? FlutterFlowTheme
                                                                      .of(
                                                                          context)
                                                                  .primaryBackground
                                                              : FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryText,
                                                          fontSize: 14.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          useGoogleFonts: false,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  logFirebaseEvent(
                                                      'USER_DASHBOARD_Container_s2y8ro2u_ON_TAP');
                                                  _model.status =
                                                      AttendeeFilterBy.CHECK_IN;
                                                  safeSetState(() {});
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: _model.status ==
                                                            AttendeeFilterBy
                                                                .CHECK_IN
                                                        ? FlutterFlowTheme.of(
                                                                context)
                                                            .secondary
                                                        : Colors.transparent,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        blurRadius: 4.0,
                                                        color:
                                                            Color(0x25000000),
                                                        offset: Offset(
                                                          1.0,
                                                          1.0,
                                                        ),
                                                        spreadRadius: 0.0,
                                                      )
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50.0),
                                                    shape: BoxShape.rectangle,
                                                  ),
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 0.0),
                                                  child: Text(
                                                    'In',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'MonaSans',
                                                          color: _model
                                                                      .status ==
                                                                  AttendeeFilterBy
                                                                      .CHECK_IN
                                                              ? FlutterFlowTheme
                                                                      .of(
                                                                          context)
                                                                  .primaryBackground
                                                              : FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryText,
                                                          fontSize: 14.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          useGoogleFonts: false,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ].divide(SizedBox(width: 6.0)),
                                        ),
                                      ),
                                    ),
                                ].divide(SizedBox(height: 16.0)),
                              );
                            }
                          },
                        ),
                      ),
                    ].divide(SizedBox(height: 16.0)),
                  );
                } else {
                  return Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                'assets/images/img_select_event.png',
                                width: 148.0,
                                height: 144.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 32.0, 0.0, 0.0),
                              child: Text(
                                'No event chosen yet',
                                style: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'MonaSans',
                                      fontSize: 24.0,
                                      letterSpacing: 0.0,
                                      useGoogleFonts: false,
                                    ),
                              ),
                            ),
                            Text(
                              'Select one to reveal the attendees!',
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: 'MonaSans',
                                    letterSpacing: 0.0,
                                    useGoogleFonts: false,
                                  ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 32.0, 0.0, 0.0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  logFirebaseEvent(
                                      'USER_DASHBOARD_SELECT_AN_EVENT_BTN_ON_TA');
                                  await _model.openEventsBottomSheetActionBlock(
                                      context);
                                },
                                text: 'Select an Event',
                                icon: Icon(
                                  Icons.add_circle_outlined,
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  size: 16.0,
                                ),
                                options: FFButtonOptions(
                                  width: double.infinity,
                                  height: 52.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 16.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: FlutterFlowTheme.of(context).secondary,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: 'MonaSans',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.normal,
                                        useGoogleFonts: false,
                                        lineHeight: 1.43,
                                      ),
                                  elevation: 0.0,
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 45,
                            ),
                          ].divide(SizedBox(height: 12.0)),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ].divide(SizedBox(height: 16.0)),
      ),
    );
  }
}

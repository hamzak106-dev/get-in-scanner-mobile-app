import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:g_e_t_i_n_scanner/components/event_seating/seatsio_seat_manager_widget.dart';
import 'package:provider/provider.dart';

import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/components/attendee_detail_tile/attendee_detail_tile_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/random_data_util.dart' as random_data;
import '/index.dart';
import '../../../config/flavor_helper.dart';
import '../../../custom_code/actions/init_power_sync.dart';
import '../../../flutter_flow/flutter_flow_icon_button.dart';
import 'attendees_detail_screen_model.dart';

export 'attendees_detail_screen_model.dart';

class AttendeesDetailScreenWidget extends StatefulWidget {
  const AttendeesDetailScreenWidget({
    super.key,
    required this.attendee,
  });

  final AttendeeRow? attendee;

  static String routeName = 'AttendeesDetailScreen';
  static String routePath = '/attendeesDetailScreen';

  @override
  State<AttendeesDetailScreenWidget> createState() =>
      _AttendeesDetailScreenWidgetState();
}

class _AttendeesDetailScreenWidgetState
    extends State<AttendeesDetailScreenWidget> {
  late AttendeesDetailScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AttendeesDetailScreenModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'AttendeesDetailScreen'});
    _model.attendee = widget.attendee;
    safeSetState(() {});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('ATTENDEES_DETAIL_SCREEN_AttendeesDetailS');
      await actions.watchAttendeeDetails(
        (result) async {
          _model.attendee = result?.firstOrNull;
          // _model.attendee?.addOnsList(widget.attendee?.addOns ?? []);
          _model.checkedIn =
              (_model.attendee?.status == ScanResult.CHECK_IN.name) ||
                  (_model.attendee?.status == ScanResult.REVALIDATE.name);
          safeSetState(() {});
        },
        widget.attendee!.uid,
      );
      _model.pins = await PinTable().queryRows(
        queryFn: (q) => q.eqOrNull(
          'uid',
          FFAppState().user.pinId,
        ),
      );
      _model.pin = _model.pins?.firstOrNull;
      _model.hasManualEntry = functions.getAccessPermissionAllow(
              valueOrDefault<int>(
                _model.pin?.permissions,
                0,
              ),
              AccessPermission.manualEntry,
              FFAppState().user.profile) ||
          (_model.pin?.type == 'SYSTEM');
      safeSetState(() {});
    });
  }

  @override
  void dispose() {
    _model.dispose();
    actions.cancelSubscription(attendeeDetailsSubscription);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        top: true,
        child: Visibility(
          visible: _model.attendee != null,
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              logFirebaseEvent(
                                  'ATTENDEES_DETAIL_SCREEN_Icon_7m2rpz6e_ON');
                              context.safePop();
                            },
                            child: Icon(
                              FFIcons.kicArrowBack,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 30.0,
                            ),
                          ),
                          Text(
                            'Attendee',
                            style: FlutterFlowTheme.of(context)
                                .titleMedium
                                .override(
                                  fontFamily: 'MonaSans',
                                  letterSpacing: 0.0,
                                  useGoogleFonts: false,
                                ),
                          ),
                        ].divide(SizedBox(width: 6.0)),
                      ),
                    ),
                  ].divide(SizedBox(width: 16.0)),
                ),
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Builder(
                          builder: (context) {
                            if (_model.attendee?.profileImg == null ||
                                _model.attendee?.profileImg == '') {
                              return Container(
                                width: 80.0,
                                height: 80.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).secondary,
                                  shape: BoxShape.circle,
                                ),
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: SvgPicture.asset(
                                  'assets/images/img_logo.svg',
                                  width: 40.0,
                                  height: 40.0,
                                  fit: BoxFit.cover,
                                ),
                              );
                            } else {
                              return Container(
                                width: 80.0,
                                height: 80.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).secondary,
                                  shape: BoxShape.circle,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(2.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(80.0),
                                    child: Image.network(
                                      '${FlavorHelper.appFlavor.imageBaseUrl}/profile/${_model.attendee?.profileImg}',
                                      width: 80.0,
                                      height: 80.0,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Image.asset(
                                        'assets/images/error_image.png',
                                        width: 80.0,
                                        height: 80.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            logFirebaseEvent(
                                'ATTENDEES_DETAIL_SCREEN_Row_880gzdr9_ON_');
                            if (FFAppState().user.profile != Profile.scanner) {
                              context.pushNamed(
                                EditAttendeeScreenWidget.routeName,
                                queryParameters: {
                                  'attendee': serializeParam(
                                    widget!.attendee,
                                    ParamType.SupabaseRow,
                                  ),
                                }.withoutNulls,
                              );
                            }
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                valueOrDefault<String>(
                                  _model.attendee?.name,
                                  '-',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyLarge
                                    .override(
                                      fontFamily: 'MonaSans',
                                      fontSize: 22.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              if (FFAppState().user.profile != Profile.scanner)
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 8.0),
                                  child: FlutterFlowIconButton(
                                    borderRadius: 50.0,
                                    buttonSize: 26.0,
                                    fillColor:
                                        FlutterFlowTheme.of(context).tertiary,
                                    icon: Icon(
                                      FFIcons.kicEdit,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 11.0,
                                    ),
                                    // onPressed: () async {
                                    //   logFirebaseEvent('ATTENDEES_DETAIL_SCREEN_icEdit_ICN_ON_TA');
                                    //   if ((FFAppState().user.profile == Profile.admin) ||
                                    //       (FFAppState().user.profile == Profile.producer)) {
                                    //     context.pushNamed(
                                    //       EditAttendeeScreenWidget.routeName,
                                    //       queryParameters: {
                                    //         'attendee': serializeParam(
                                    //           _model.attendee,
                                    //           ParamType.SupabaseRow,
                                    //         ),
                                    //       }.withoutNulls,
                                    //     );
                                    //   }
                                    // },
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                wrapWithModel(
                                  model: _model.attendeeDetailTileModel1,
                                  updateCallback: () => safeSetState(() {}),
                                  child: AttendeeDetailTileWidget(
                                    icon: Icon(
                                      FFIcons.kicAccountCircle,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 16.0,
                                    ),
                                    title: 'Contact',
                                    endLable: _model.attendee?.name,
                                    isEndBold: false,
                                    onTap: () async {},
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.attendeeDetailTileModel2,
                                  updateCallback: () => safeSetState(() {}),
                                  child: AttendeeDetailTileWidget(
                                    icon: Icon(
                                      FFIcons.kicFileOpen,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 16.0,
                                    ),
                                    title: 'Type',
                                    endLable:
                                        '${_model.attendee?.ticketName} - ${functions.fetchTicketType(_model.attendee!.ticketType)}',
                                    isEndBold: true,
                                    onTap: () async {},
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.attendeeDetailTileModel3,
                                  updateCallback: () => safeSetState(() {}),
                                  child: AttendeeDetailTileWidget(
                                    icon: Icon(
                                      FFIcons.kicChecklist,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 16.0,
                                    ),
                                    title: 'List',
                                    endLable: 'Getin INC',
                                    isEndBold: false,
                                    onTap: () async {},
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.attendeeDetailTileModel4,
                                  updateCallback: () => safeSetState(() {}),
                                  child: AttendeeDetailTileWidget(
                                    icon: Icon(
                                      FFIcons.kicLable,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 16.0,
                                    ),
                                    title: 'Tags',
                                    endLable: 'Getin INC',
                                    isEndBold: false,
                                    onTap: () async {},
                                  ),
                                ),
                                if (_model.attendee?.addOns.isNotEmpty == true)
                                  wrapWithModel(
                                    model: _model.attendeeDetailTileModel4,
                                    updateCallback: () => safeSetState(() {}),
                                    child: AttendeeDetailTileWidget(
                                      icon: SvgPicture.asset(
                                        'assets/icons/add_on_icon.svg',
                                        width: 16.0,
                                        height: 16.0,
                                        fit: BoxFit.cover,
                                      ),
                                      title: 'Add-On',
                                      endLable: valueOrDefault<String>(
                                            '${_model.attendee?.addOns.first.name}',
                                            'N/A',
                                          ).maybeHandleOverflow(
                                              maxChars: 10,
                                              replacement: '...') +
                                          valueOrDefault<String>(
                                            '${_model.attendee!.addOns.length > 1 ? ' + ${_model.attendee!.addOns.length - 1} more' : ''}',
                                            '',
                                          ),
                                      isEndBold: true,
                                      showArrowIcon: true,
                                      onTap: () async {
                                        logFirebaseEvent(
                                            'ATTENDEES_DETAIL_SCREEN_Container_3b2k1q');
                                        context.pushNamed(
                                            AddOnsListScreenWidget.routeName,
                                            pathParameters: {
                                              'attendeeUid': _model
                                                  .attendee!.uid
                                                  .toString(),
                                            });
                                      },
                                    ),
                                  ),
                              ].divide(SizedBox(height: 10.0)),
                            ),
                          ),
                        ),
                        if (false)
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(
                                FFIcons.kicAddCircle,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                size: 16.0,
                              ),
                              Text(
                                'Custom Fields',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'MonaSans',
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ].divide(SizedBox(width: 10.0)),
                          ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                wrapWithModel(
                                  model: _model.attendeeDetailTileModel5,
                                  updateCallback: () => safeSetState(() {}),
                                  child: AttendeeDetailTileWidget(
                                    icon: Icon(
                                      FFIcons.kicAccountCircle,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 16.0,
                                    ),
                                    title: 'User Purchase ID',
                                    endLable:
                                        _model.attendee?.purchaseId.toString(),
                                    isEndBold: false,
                                    onTap: () async {},
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.attendeeDetailTileModel6,
                                  updateCallback: () => safeSetState(() {}),
                                  child: AttendeeDetailTileWidget(
                                    icon: Icon(
                                      FFIcons.kicSmartPhone,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 16.0,
                                    ),
                                    title: 'Phone',
                                    endLable: _model.attendee?.phone,
                                    isEndBold: false,
                                    onTap: () async {},
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.attendeeDetailTileModel7,
                                  updateCallback: () => safeSetState(() {}),
                                  child: AttendeeDetailTileWidget(
                                    icon: Icon(
                                      FFIcons.kicTickit,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 16.0,
                                    ),
                                    title: 'Ticket Getin Name',
                                    endLable: _model.attendee?.ticketName,
                                    isEndBold: false,
                                    onTap: () async {},
                                  ),
                                ),
                                if (false)
                                  wrapWithModel(
                                    model: _model.attendeeDetailTileModel8,
                                    updateCallback: () => safeSetState(() {}),
                                    child: AttendeeDetailTileWidget(
                                      icon: Icon(
                                        FFIcons.kicNumber,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 16.0,
                                      ),
                                      title: 'Purchase ID',
                                      endLable: _model.attendee?.purchaseId
                                          .toString(),
                                      isEndBold: false,
                                      onTap: () async {},
                                    ),
                                  ),
                                wrapWithModel(
                                  model: _model.attendeeDetailTileModel9,
                                  updateCallback: () => safeSetState(() {}),
                                  child: AttendeeDetailTileWidget(
                                    icon: Icon(
                                      FFIcons.kicNumber,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 16.0,
                                    ),
                                    title: 'Transaction Number',
                                    endLable: _model.attendee?.transactionNumber
                                        .toString(),
                                    isEndBold: false,
                                    onTap: () async {},
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.attendeeDetailTileModel10,
                                  updateCallback: () => safeSetState(() {}),
                                  child: AttendeeDetailTileWidget(
                                    icon: Icon(
                                      FFIcons.kicChat,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 16.0,
                                    ),
                                    title: 'Ticket Comment',
                                    endLable: valueOrDefault<String>(
                                      _model.attendee?.ticketComment,
                                      'N/A',
                                    ),
                                    isEndBold: false,
                                    onTap: () async {
                                      logFirebaseEvent(
                                          'ATTENDEES_DETAIL_SCREEN_Container_3beub9');
                                      if (widget.attendee?.ticketComment !=
                                              null &&
                                          widget.attendee?.ticketComment !=
                                              '') {
                                        context.pushNamed(
                                          TicketCommentScreenWidget.routeName,
                                          queryParameters: {
                                            'attendee': serializeParam(
                                              _model.attendee,
                                              ParamType.SupabaseRow,
                                            ),
                                          }.withoutNulls,
                                        );
                                      }
                                    },
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.attendeeDetailTileModel11,
                                  updateCallback: () => safeSetState(() {}),
                                  child: AttendeeDetailTileWidget(
                                    icon: Icon(
                                      FFIcons.kicOutlineReceipt,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 16.0,
                                    ),
                                    title: 'Remarks',
                                    endLable: valueOrDefault<String>(
                                      _model.attendee?.remark,
                                      'N/A',
                                    ),
                                    isEndBold: false,
                                    onTap: () async {
                                      logFirebaseEvent(
                                          'ATTENDEES_DETAIL_SCREEN_Container_w2sxm0');

                                      context.pushNamed(
                                        TicketCommentScreenWidget.routeName,
                                        queryParameters: {
                                          'attendee': serializeParam(
                                            _model.attendee,
                                            ParamType.SupabaseRow,
                                          ),
                                          'isRemark': serializeParam(
                                            true,
                                            ParamType.bool,
                                          ),
                                        }.withoutNulls,
                                      );
                                    },
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
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.event_seat_outlined,
                                            color:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryText,
                                            size: 16.0,
                                          ),
                                          Text(
                                            'Seat',
                                            textAlign: TextAlign.start,
                                            style:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'MonaSans',
                                                      letterSpacing: 0.0,
                                                    ),
                                          ),
                                        ].divide(SizedBox(width: 10.0)),
                                      ),
                                      Expanded(
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
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w500,
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
                                                        letterSpacing: 0.0,
                                                      ),
                                                ),
                                              ],
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
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w500,
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
                                                        letterSpacing: 0.0,
                                                      ),
                                                ),
                                              ],
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
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w500,
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
                                                        letterSpacing: 0.0,
                                                      ),
                                                ),
                                              ],
                                            ),
                                            IconButton(onPressed: (){
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => SeatsioSeatManagerWidget(
                                                    attendeeModel: _model, // pass the model directly
                                                  ),
                                                ),
                                              );
                                            }, icon: Icon(Icons.arrow_forward_ios,color: Colors.white,
                                            size: 16,))
                                          ].divide(SizedBox(width: 12.0)),
                                        ),
                                      ),
                                    ],
                                  ),
                              ].divide(SizedBox(height: 10.0)),
                            ),
                          ),
                        ),
                      ].divide(SizedBox(height: 30.0)),
                    ),
                  ),
                ),
                if (_model.hasManualEntry)
                  Builder(
                    builder: (context) {
                      if (_model.attendee?.ticketStatus == 2) {
                        return InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            logFirebaseEvent(
                                'ATTENDEES_DETAIL_SCREEN_Container_a7hmuz');
                            _model.logId =
                                random_data.randomInteger(0, 99999999) +
                                    99999999;
                            _model.checkedIn = !_model.checkedIn;
                            await actions.addCheckInLog(
                              _model.checkedIn
                                  ? ScanResult.CHECK_IN
                                  : ScanResult.CHECK_OUT,
                              _model.logId,
                              _model.attendee,
                              FFAppState().user.deviceId,
                              _model.attendee?.eventId,
                              FFAppState().user.userId,
                              getCurrentTimestamp.toString(),
                              _model.attendee?.ticketHash,
                            );
                            // await actions.updateAttendeeStatus(
                            //   _model.attendee,
                            //   _model.logId,
                            //   _model.checkedIn ? ScanResult.CHECK_IN : ScanResult.CHECK_OUT,
                            // );
                            safeSetState(() {});
                          },
                          child: Container(
                            width: double.infinity,
                            height: 60.0,
                            decoration: BoxDecoration(
                              color: _model.checkedIn
                                  ? FlutterFlowTheme.of(context).error
                                  : FlutterFlowTheme.of(context).success,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Builder(
                              builder: (context) {
                                if (_model.checkedIn) {
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        FFIcons.kicCancel,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 24.0,
                                      ),
                                      Text(
                                        'CHECK OUT',
                                        style: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily: 'MonaSans',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ].divide(SizedBox(width: 10.0)),
                                  );
                                } else {
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        FFIcons.kicCheckCircle,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 24.0,
                                      ),
                                      Text(
                                        'CHECK IN',
                                        style: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily: 'MonaSans',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ].divide(SizedBox(width: 10.0)),
                                  );
                                }
                              },
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          width: double.infinity,
                          height: 60.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Text(
                            () {
                              if (_model.attendee?.ticketStatus == 1) {
                                return 'Your ticket is pending and awaiting review.';
                              } else if (_model.attendee?.ticketStatus == 3) {
                                return 'Your ticket has been declined.';
                              } else if (_model.attendee?.ticketStatus == 4) {
                                return 'A refund has been issued for your ticket.';
                              } else if (_model.attendee?.ticketStatus == 5) {
                                return 'Transaction failed.  ';
                              } else if (_model.attendee?.ticketStatus == 6) {
                                return 'Refund request has been rejected.';
                              } else if (_model.attendee?.ticketStatus == 7) {
                                return 'This ticket is hidden from view.';
                              } else if (_model.attendee?.ticketStatus == 8) {
                                return 'This ticket has been marked as abandoned.';
                              } else if (_model.attendee?.ticketStatus == 10) {
                                return 'Your ticket has been sent for approval.';
                              } else if (_model.attendee?.ticketStatus == 11) {
                                return 'Approval process failed. Please contact support.';
                              } else if (_model.attendee?.ticketStatus == 15) {
                                return 'Refund request is pending.';
                              } else if (_model.attendee?.ticketStatus == 16) {
                                return 'Your ticket is currently being reviewed for approval.';
                              } else if (_model.attendee?.ticketStatus == 17) {
                                return 'A dispute has been raised for this ticket.';
                              } else if (_model.attendee?.ticketStatus == 18) {
                                return 'This ticket is on a cancelled waiting list.';
                              } else if (_model.attendee?.ticketStatus == 19) {
                                return 'Your ticket has been transferred.';
                              } else {
                                return 'Your ticket is invalid';
                              }
                            }(),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'MonaSans',
                                  letterSpacing: 0.0,
                                ),
                          ),
                        );
                      }
                    },
                  ),
              ].divide(SizedBox(height: 30.0)),
            ),
          ),
        ),
      ),
    );
  }
}

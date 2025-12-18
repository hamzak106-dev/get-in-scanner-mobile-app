import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '/backend/api_requests/api_calls.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/components/attendee_card/attendee_card_widget.dart';
import '/components/dialogs/export_dialog/export_dialog_widget.dart';
import '/components/dialogs/info_dialog/info_dialog_widget.dart';
import '/components/dialogs/logout_dialog/logout_dialog_widget.dart';
import '/components/dialogs/summary_dialog/summary_dialog_widget.dart';
import '/components/dialogs/upload_dialog/upload_dialog_widget.dart';
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
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import '../../../config/flavor_helper.dart';
import '../../../custom_code/actions/index.dart';
import '../../../custom_code/actions/init_power_sync.dart';
import 'attendees_screen_model.dart';

export 'attendees_screen_model.dart';

class AttendeesScreenWidget extends StatefulWidget {
  const AttendeesScreenWidget({
    super.key,
    required this.eventId,
  });

  final int? eventId;

  static String routeName = 'AttendeesScreen';
  static String routePath = '/attendeesScreen';

  @override
  State<AttendeesScreenWidget> createState() => _AttendeesScreenWidgetState();
}

class _AttendeesScreenWidgetState extends State<AttendeesScreenWidget> {
  late AttendeesScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AttendeesScreenModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'AttendeesScreen'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('ATTENDEES_SCREEN_AttendeesScreen_ON_INIT');
      _model.selectedEventId = widget.eventId;
      safeSetState(() {});
      await actions.watchAttendeeLists(
        (result) async {
          _model.attendeeList = await actions.getAttendeeList(
            result?.toList(),
          );
          _model.attendees = _model.attendeeList!.toList().cast<AttendeeRow>();
          _model.isLoading = false;
          safeSetState(() {});
        },
        ((int eventId) {
          return [eventId];
        }(_model.selectedEventId!))
            .toList(),
        true,
      );
    });
  }

  @override
  void dispose() {
    _model.dispose();
    cancelSubscription(attendeesSubscription);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xE60E0F11),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    FlutterFlowIconButton(
                      buttonSize: 40.0,
                      icon: Icon(
                        FFIcons.kicArrowBack,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 24.0,
                      ),
                      onPressed: () async {
                        logFirebaseEvent(
                            'ATTENDEES_SCREEN_icArrowBack_ICN_ON_TAP');
                        context.safePop();
                      },
                    ),
                    Builder(
                      builder: (context) => Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                        child: FlutterFlowIconButton(
                          buttonSize: 40.0,
                          icon: Icon(
                            FFIcons.kicOutlineCamera,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 24.0,
                          ),
                          onPressed: () async {
                            logFirebaseEvent(
                                'ATTENDEES_SCREEN_icOutlineCamera_ICN_ON_');
                            await showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
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
                                    padding: MediaQuery.viewInsetsOf(context),
                                    child: Container(
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.9,
                                      child: LookupScannerBottomSheetWidget(),
                                    ),
                                  ),
                                );
                              },
                            ).then((value) => safeSetState(
                                () => _model.scannedValue = value));

                            if (_model.scannedValue != null &&
                                _model.scannedValue != '') {
                              _model.redirectAttendeeResponse =
                                  await actions.findAttendee(
                                _model.scannedValue,
                                ((int eventId) {
                                  return [eventId];
                                }(widget.eventId!))
                                    .toList(),
                              );
                              if (_model.redirectAttendeeResponse != null) {
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
                                      alignment: AlignmentDirectional(0.0, 0.0)
                                          .resolve(Directionality.of(context)),
                                      child: GestureDetector(
                                        onTap: () {
                                          FocusScope.of(dialogContext)
                                              .unfocus();
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                        },
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
                    ),
                    Builder(
                      builder: (context) => FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        buttonSize: 40.0,
                        icon: Icon(
                          FFIcons.kicOutlineAdd,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 24.0,
                        ),
                        onPressed: () async {
                          logFirebaseEvent(
                              'ATTENDEES_SCREEN_icOutlineAdd_ICN_ON_TAP');
                          var _shouldSetState = false;
                          _model.whichOption = null;
                          safeSetState(() {});
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
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  },
                                  child: LogoutDialogWidget(
                                    title: 'New Import',
                                    subTitle: 'Upload CSV to add attendees',
                                    firstBtnText: 'Upload',
                                    secondBtnText: 'Go Back',
                                    firstBtnColor:
                                        FlutterFlowTheme.of(context).accent3,
                                    secondBtnColor: Color(0x99FFFFFF),
                                    showExport: true,
                                    firstTap: () async {
                                      _model.whichOption = true;
                                      safeSetState(() {});
                                      Navigator.pop(context);
                                    },
                                    secondTap: () async {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              );
                            },
                          );

                          if (_model.whichOption!) {
                            _model.selectedFileData = await actions.csvReader(
                              context,
                              widget.eventId!,
                            );
                            _shouldSetState = true;
                            if (_model.selectedFileData != null &&
                                (_model.selectedFileData?.bytes?.isNotEmpty ??
                                    false)) {
                              await Future.wait([
                                Future(() async {
                                  await showDialog(
                                    context: context,
                                    builder: (dialogContext) {
                                      return Dialog(
                                        elevation: 0,
                                        insetPadding: EdgeInsets.zero,
                                        backgroundColor: Colors.transparent,
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0)
                                                .resolve(
                                                    Directionality.of(context)),
                                        child: GestureDetector(
                                          onTap: () {
                                            FocusScope.of(dialogContext)
                                                .unfocus();
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                          },
                                          child: UploadDialogWidget(),
                                        ),
                                      );
                                    },
                                  );
                                }),
                                Future(() async {
                                  _model.uploadFileResponse =
                                      await GetInScannerAPIsGroup.uploadCSVCall
                                          .call(
                                    eventId: widget.eventId,
                                    file: _model.selectedFileData,
                                    apiBaseURL:
                                        FlavorHelper.appFlavor.apiBaseUrl,
                                    token: FlavorHelper.appFlavor.apiToken,
                                  );

                                  _shouldSetState = true;
                                  Navigator.pop(context);
                                  if (UploadDataResponseStruct.maybeFromMap(
                                          (_model.uploadFileResponse
                                                  ?.jsonBody ??
                                              ''))!
                                      .success) {
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
                                          child: GestureDetector(
                                            onTap: () {
                                              FocusScope.of(dialogContext)
                                                  .unfocus();
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                            },
                                            child: SummaryDialogWidget(
                                              summary: UploadDataResponseStruct
                                                      .maybeFromMap((_model
                                                              .uploadFileResponse
                                                              ?.jsonBody ??
                                                          ''))!
                                                  .data,
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          UploadDataResponseStruct.maybeFromMap(
                                                      (_model.uploadFileResponse
                                                              ?.jsonBody ??
                                                          ''))
                                                  ?.message ??
                                              _model.uploadFileResponse
                                                  ?.response?.reasonPhrase ??
                                              "Something went wrong!",
                                          style: TextStyle(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                          ),
                                        ),
                                        duration: Duration(milliseconds: 4000),
                                        backgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                      ),
                                    );
                                  }
                                }),
                              ]);
                            }
                          } else {
                            if (_shouldSetState) safeSetState(() {});
                            return;
                          }

                          if (_shouldSetState) safeSetState(() {});
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
                            onChanged: (val) =>
                                safeSetState(() => _model.dropDownValue = val),
                            width: 116.0,
                            height: 40.0,
                            textStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'MonaSans',
                                  letterSpacing: 0.0,
                                ),
                            icon: Icon(
                              FFIcons.kicDown,
                              color: FlutterFlowTheme.of(context).secondaryText,
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
                    if (_model.attendees.isNotEmpty)
                      Flexible(
                        child: Align(
                          alignment: AlignmentDirectional(1.0, 0.0),
                          child: Builder(
                            builder: (context) => FlutterFlowIconButton(
                              borderColor: Colors.transparent,
                              borderRadius: 30.0,
                              buttonSize: 40.0,
                              icon: FaIcon(
                                FontAwesomeIcons.solidShareFromSquare,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 16.0,
                              ),
                              onPressed: () async {
                                logFirebaseEvent(
                                    'ATTENDEES_SCREEN_PAGE_upload_ICN_ON_TAP');
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
                                          FocusScope.of(dialogContext)
                                              .unfocus();
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                        },
                                        child: ExportDialogWidget(
                                          export: Export.export,
                                        ),
                                      ),
                                    );
                                  },
                                ).then((value) => safeSetState(
                                    () => _model.haveExport = value));

                                if (_model.haveExport?.export ==
                                    Export.exporting) {
                                  await showDialog(
                                    context: context,
                                    builder: (dialogContext) {
                                      return Dialog(
                                        elevation: 0,
                                        insetPadding: EdgeInsets.zero,
                                        backgroundColor: Colors.transparent,
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0)
                                                .resolve(
                                                    Directionality.of(context)),
                                        child: GestureDetector(
                                          onTap: () {
                                            FocusScope.of(dialogContext)
                                                .unfocus();
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                          },
                                          child: ExportDialogWidget(
                                            export: Export.exporting,
                                            attendees: _model.attendees,
                                          ),
                                        ),
                                      );
                                    },
                                  ).then((value) => safeSetState(
                                      () => _model.exportResponse = value));

                                  if (_model.exportResponse?.export ==
                                      Export.exported) {
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
                                          child: GestureDetector(
                                            onTap: () {
                                              FocusScope.of(dialogContext)
                                                  .unfocus();
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                            },
                                            child: ExportDialogWidget(
                                              export: Export.exported,
                                              cancleBtnTxt: 'Skip for Now',
                                              doneBtnTxt: 'Open Now',
                                              fileName:
                                                  _model.exportResponse?.name,
                                              fileSize: valueOrDefault<int>(
                                                    _model.exportResponse?.size,
                                                    0,
                                                  ) /
                                                  (1024),
                                            ),
                                          ),
                                        );
                                      },
                                    ).then((value) => safeSetState(
                                        () => _model.hasOpenFile = value));

                                    if (_model.hasOpenFile?.export ==
                                        Export.export) {
                                      await actions.openFileFolder(
                                        _model.exportResponse?.path,
                                      );
                                    }
                                  }
                                }

                                safeSetState(() {});
                              },
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text(
                        'Attendees',
                        style: FlutterFlowTheme.of(context).titleLarge.override(
                              fontFamily: 'MonaSans',
                              fontSize: 22.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    // if ((FFAppState().user.profile == Profile.admin) ||
                    //     (FFAppState().user.profile == Profile.producer))
                    //   Builder(
                    //     builder: (context) => FlutterFlowIconButton(
                    //       borderRadius: 50.0,
                    //       buttonSize: 40.0,
                    //       fillColor: FlutterFlowTheme.of(context).tertiary,
                    //       icon: Icon(
                    //         FFIcons.kicRefresh,
                    //         color: FlutterFlowTheme.of(context).primaryText,
                    //         size: 24.0,
                    //       ),
                    //       showLoadingIndicator: true,
                    //       onPressed: () async {
                    //         logFirebaseEvent(
                    //             'ATTENDEES_SCREEN_icRefresh_ICN_ON_TAP');
                    //         var _shouldSetState = false;
                    //         if (FFAppState().isOnline) {
                    //           _model.bulkUpdateAttendees =
                    //               await actions.bulkStatusUpdate(
                    //             widget.eventId!,
                    //           );
                    //           _shouldSetState = true;
                    //           if (_model.bulkUpdateAttendees != null &&
                    //               (_model.bulkUpdateAttendees)!.isNotEmpty) {
                    //             _model.bulkUpdateStatusResposne =
                    //                 await GetInGroup.bulkUpdateStatusCall.call(
                    //               eventId: widget.eventId?.toString(),
                    //               apiBaseURL:
                    //                   getRemoteConfigString('GetInBaseUrl'),
                    //               scannerApiKey:
                    //                   getRemoteConfigString('scannerApiKey'),
                    //               updatedRecoredsJson:
                    //                   _model.bulkUpdateAttendees,
                    //             );
                    //
                    //             _shouldSetState = true;
                    //             if ((_model
                    //                     .bulkUpdateStatusResposne?.succeeded ??
                    //                 true)) {
                    //               if (_shouldSetState) safeSetState(() {});
                    //               return;
                    //             }
                    //
                    //             await showDialog(
                    //               context: context,
                    //               builder: (dialogContext) {
                    //                 return Dialog(
                    //                   elevation: 0,
                    //                   insetPadding: EdgeInsets.zero,
                    //                   backgroundColor: Colors.transparent,
                    //                   alignment: AlignmentDirectional(0.0, 0.0)
                    //                       .resolve(Directionality.of(context)),
                    //                   child: GestureDetector(
                    //                     onTap: () {
                    //                       FocusScope.of(dialogContext)
                    //                           .unfocus();
                    //                       FocusManager.instance.primaryFocus
                    //                           ?.unfocus();
                    //                     },
                    //                     child: InfoDialogWidget(
                    //                       title: 'Error',
                    //                       subTitle:
                    //                           'Error updating attendee status on the server. Please try again later.',
                    //                       firstBtnText: 'OK',
                    //                       firstBtnColor:
                    //                           FlutterFlowTheme.of(context)
                    //                               .primaryText,
                    //                       firstTap: () async {
                    //                         Navigator.pop(context);
                    //                       },
                    //                     ),
                    //                   ),
                    //                 );
                    //               },
                    //             );
                    //
                    //             if (_shouldSetState) safeSetState(() {});
                    //             return;
                    //           } else {
                    //             if (_shouldSetState) safeSetState(() {});
                    //             return;
                    //           }
                    //         } else {
                    //           await showDialog(
                    //             context: context,
                    //             builder: (dialogContext) {
                    //               return Dialog(
                    //                 elevation: 0,
                    //                 insetPadding: EdgeInsets.zero,
                    //                 backgroundColor: Colors.transparent,
                    //                 alignment: AlignmentDirectional(0.0, 0.0)
                    //                     .resolve(Directionality.of(context)),
                    //                 child: GestureDetector(
                    //                   onTap: () {
                    //                     FocusScope.of(dialogContext).unfocus();
                    //                     FocusManager.instance.primaryFocus
                    //                         ?.unfocus();
                    //                   },
                    //                   child: InfoDialogWidget(
                    //                     title: 'Error',
                    //                     subTitle:
                    //                         'You\'re offline! Please check your internet connection and try again.',
                    //                     firstBtnText: 'OK',
                    //                     firstBtnColor:
                    //                         FlutterFlowTheme.of(context)
                    //                             .primaryText,
                    //                     firstTap: () async {
                    //                       Navigator.pop(context);
                    //                     },
                    //                   ),
                    //                 ),
                    //               );
                    //             },
                    //           );
                    //         }
                    //
                    //         if (_shouldSetState) safeSetState(() {});
                    //       },
                    //     ),
                    //   ),
                    Align(
                      alignment: AlignmentDirectional(1.0, 0.0),
                      child: custom_widgets.FilterPopUp(
                        width: 40.0,
                        height: 40.0,
                        onChange: (value) async {
                          logFirebaseEvent(
                              'ATTENDEES_SCREEN_Container_94y2wphr_CALL');
                          _model.ascending = value == 0;
                          safeSetState(() {});
                        },
                      ),
                    ),
                  ].divide(SizedBox(width: 12.0)),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (functions.getAccessPermissionAllow(
                        FFAppState().user.permissions,
                        AccessPermission.searchAttendee,
                        FFAppState().user.profile))
                      Expanded(
                        child: wrapWithModel(
                          model: _model.searchTextFieldModel,
                          updateCallback: () => safeSetState(() {}),
                          child: SearchTextFieldWidget(
                            onChange: () async {
                              logFirebaseEvent(
                                  'ATTENDEES_SCREEN_Container_kxfc5lfy_CALL');

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
                            type: RiveAnimType.AvatarSyncing,
                            fillColor: Colors.transparent,
                          ),
                        );
                      } else {
                        return Column(
                          mainAxisSize: MainAxisSize.max,
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
                                                  _model.attendees.toList(),
                                                  _model.searchTextFieldModel
                                                      .textController.text)
                                              .sortedList(
                                                  keyOf: (e) => e.name ?? "",
                                                  desc: false)
                                              .where((e) =>
                                                  e.status ==
                                                  ScanResult.CHECK_IN.name)
                                              .toList()
                                          : functions
                                              .filterAttendeeList(
                                                  _model.attendees.toList(),
                                                  _model.searchTextFieldModel
                                                      .textController.text)
                                              .sortedList(
                                                  keyOf: (e) => e.name ?? "",
                                                  desc: true)
                                              .where((e) =>
                                                  e.status ==
                                                  ScanResult.CHECK_IN.name)
                                              .toList());
                                    } else if (_model.status ==
                                        AttendeeFilterBy.CHECK_OUT) {
                                      return (_model.ascending
                                          ? functions
                                              .filterAttendeeList(
                                                  _model.attendees.toList(),
                                                  _model.searchTextFieldModel
                                                      .textController.text)
                                              .sortedList(
                                                  keyOf: (e) => e.name ?? "",
                                                  desc: false)
                                              .where((e) =>
                                                  e.status ==
                                                  ScanResult.CHECK_OUT.name)
                                              .toList()
                                          : functions
                                              .filterAttendeeList(
                                                  _model.attendees.toList(),
                                                  _model.searchTextFieldModel
                                                      .textController.text)
                                              .sortedList(
                                                  keyOf: (e) => e.name ?? "",
                                                  desc: true)
                                              .where((e) =>
                                                  e.status ==
                                                  ScanResult.CHECK_OUT.name)
                                              .toList());
                                    } else if (_model.status ==
                                        AttendeeFilterBy.ABSENT) {
                                      return (_model.ascending
                                          ? functions
                                              .filterAttendeeList(
                                                  _model.attendees.toList(),
                                                  _model.searchTextFieldModel
                                                      .textController.text)
                                              .sortedList(
                                                  keyOf: (e) => e.name ?? "",
                                                  desc: false)
                                              .where((e) =>
                                                  e.status == null ||
                                                  e.status == '')
                                              .toList()
                                          : functions
                                              .filterAttendeeList(
                                                  _model.attendees.toList(),
                                                  _model.searchTextFieldModel
                                                      .textController.text)
                                              .sortedList(
                                                  keyOf: (e) => e.name ?? "",
                                                  desc: true)
                                              .where((e) =>
                                                  e.status == null ||
                                                  e.status == '')
                                              .toList());
                                    } else {
                                      return (_model.ascending
                                          ? functions
                                              .filterAttendeeList(
                                                  _model.attendees.toList(),
                                                  _model.searchTextFieldModel
                                                      .textController.text)
                                              .sortedList(
                                                  keyOf: (e) => e.name ?? "",
                                                  desc: false)
                                          : functions
                                              .filterAttendeeList(
                                                  _model.attendees.toList(),
                                                  _model.searchTextFieldModel
                                                      .textController.text)
                                              .sortedList(
                                                  keyOf: (e) => e.name ?? "",
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
                                    itemBuilder: (context, attendeeIndex) {
                                      final attendeeItem =
                                          attendee[attendeeIndex];
                                      return AttendeeCardWidget(
                                        key: Key(
                                            'Keyo5c_${attendeeIndex}_of_${attendee.length}'),
                                        attendee: attendeeItem,
                                        onTap: () async {
                                          logFirebaseEvent(
                                              'ATTENDEES_SCREEN_Container_o5cykw0g_CALL');

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
                            if (_model.attendees.isNotEmpty)
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
                                  borderRadius: BorderRadius.circular(50.0),
                                  border: Border.all(
                                    color:
                                        FlutterFlowTheme.of(context).tertiary,
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
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            logFirebaseEvent(
                                                'ATTENDEES_SCREEN_Container_ek8k8xzo_ON_T');
                                            _model.status =
                                                AttendeeFilterBy.ALL;
                                            safeSetState(() {});
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: _model.status ==
                                                      AttendeeFilterBy.ALL
                                                  ? FlutterFlowTheme.of(context)
                                                      .secondary
                                                  : Colors.transparent,
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 4.0,
                                                  color: Color(0x33000000),
                                                  offset: Offset(
                                                    0.0,
                                                    2.0,
                                                  ),
                                                )
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(50.0),
                                              shape: BoxShape.rectangle,
                                            ),
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            child: Text(
                                              'All',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'MonaSans',
                                                    color: _model.status ==
                                                            AttendeeFilterBy.ALL
                                                        ? FlutterFlowTheme.of(
                                                                context)
                                                            .primaryBackground
                                                        : FlutterFlowTheme.of(
                                                                context)
                                                            .secondaryText,
                                                    fontSize: 14.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
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
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            logFirebaseEvent(
                                                'ATTENDEES_SCREEN_Container_68z2eaw4_ON_T');
                                            _model.status =
                                                AttendeeFilterBy.ABSENT;
                                            safeSetState(() {});
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: _model.status ==
                                                      AttendeeFilterBy.ABSENT
                                                  ? FlutterFlowTheme.of(context)
                                                      .secondary
                                                  : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(50.0),
                                              shape: BoxShape.rectangle,
                                            ),
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            child: Text(
                                              'Absent',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'MonaSans',
                                                    color: _model.status ==
                                                            AttendeeFilterBy
                                                                .ABSENT
                                                        ? FlutterFlowTheme.of(
                                                                context)
                                                            .primaryBackground
                                                        : FlutterFlowTheme.of(
                                                                context)
                                                            .secondaryText,
                                                    fontSize: 14.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
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
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            logFirebaseEvent(
                                                'ATTENDEES_SCREEN_Container_hnb0lmdv_ON_T');
                                            _model.status =
                                                AttendeeFilterBy.CHECK_OUT;
                                            safeSetState(() {});
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: _model.status ==
                                                      AttendeeFilterBy.CHECK_OUT
                                                  ? FlutterFlowTheme.of(context)
                                                      .secondary
                                                  : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(50.0),
                                              shape: BoxShape.rectangle,
                                            ),
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            child: Text(
                                              'Out',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'MonaSans',
                                                    color: _model.status ==
                                                            AttendeeFilterBy
                                                                .CHECK_OUT
                                                        ? FlutterFlowTheme.of(
                                                                context)
                                                            .primaryBackground
                                                        : FlutterFlowTheme.of(
                                                                context)
                                                            .secondaryText,
                                                    fontSize: 14.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
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
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            logFirebaseEvent(
                                                'ATTENDEES_SCREEN_Container_uy9oh3bo_ON_T');
                                            _model.status =
                                                AttendeeFilterBy.CHECK_IN;
                                            safeSetState(() {});
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: _model.status ==
                                                      AttendeeFilterBy.CHECK_IN
                                                  ? FlutterFlowTheme.of(context)
                                                      .secondary
                                                  : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(50.0),
                                              shape: BoxShape.rectangle,
                                            ),
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            child: Text(
                                              'In',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'MonaSans',
                                                    color: _model.status ==
                                                            AttendeeFilterBy
                                                                .CHECK_IN
                                                        ? FlutterFlowTheme.of(
                                                                context)
                                                            .primaryBackground
                                                        : FlutterFlowTheme.of(
                                                                context)
                                                            .secondaryText,
                                                    fontSize: 14.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
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
            ),
          ),
        ),
      ),
    );
  }
}

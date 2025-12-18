import '../../../backend/schema/enums/enums.dart';
import '../../../custom_code/actions/cancel_subscription.dart';
import '../../../custom_code/actions/init_power_sync.dart';
import '/backend/supabase/supabase.dart';
import '/components/dialogs/delete_scanner_dialog/delete_scanner_dialog_widget.dart';
import '/components/dialogs/success_dialog/success_dialog_widget.dart';
import '/components/setting_tile/setting_tile_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'pin_details_screen_model.dart';
export 'pin_details_screen_model.dart';

class PinDetailsScreenWidget extends StatefulWidget {
  const PinDetailsScreenWidget({
    super.key,
    this.pinData,
    bool? isNew,
  }) : this.isNew = isNew ?? false;

  final PinRow? pinData;
  final bool isNew;

  static String routeName = 'PinDetailsScreen';
  static String routePath = '/pinDetailsScreen';

  @override
  State<PinDetailsScreenWidget> createState() => _PinDetailsScreenWidgetState();
}

class _PinDetailsScreenWidgetState extends State<PinDetailsScreenWidget> {
  late PinDetailsScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PinDetailsScreenModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'PinDetailsScreen'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('PIN_DETAILS_SCREEN_PinDetailsScreen_ON_I');
      await actions.watchPinDetails(
        (result) async {
          _model.watchPIn = result;
          safeSetState(() {});
        },
        widget.pinData!.uid,
      );
    });
  }

  @override
  void dispose() {
    _model.dispose();
    cancelSubscription(pinSubscription);
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
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
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
                        logFirebaseEvent('PIN_DETAILS_SCREEN_icArrowBack_ICN_ON_TA');
                        context.safePop();
                      },
                    ),
                    Expanded(
                      child: Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Text(
                          widget.isNew
                              ? 'New Access Code'
                              : (_model.watchPIn?.name ?? widget.pinData?.name ?? widget.pinData?.pin.toString() ?? ""),
                          style: FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'MonaSans',
                                letterSpacing: 0.0,
                              ),
                        ),
                      ),
                    ),
                  ].addToEnd(SizedBox(width: 40.0)),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            wrapWithModel(
                              model: _model.settingTileModel1,
                              updateCallback: () => safeSetState(() {}),
                              child: SettingTileWidget(
                                icon: Icon(
                                  FFIcons.kicInfoCircle,
                                  color: FlutterFlowTheme.of(context).primaryText,
                                  size: 20.0,
                                ),
                                title: 'Info',
                                endLable: '',
                                showTrailingIcon: true,
                                onTap: () async {
                                  logFirebaseEvent('PIN_DETAILS_SCREEN_Container_74ajwia9_CA');

                                  context.pushNamed(
                                    PinInfoScreenWidget.routeName,
                                    queryParameters: {
                                      'pin': serializeParam(
                                        _model.watchPIn,
                                        ParamType.SupabaseRow,
                                      ),
                                      'isNew': serializeParam(
                                        widget.isNew,
                                        ParamType.bool,
                                      ),
                                    }.withoutNulls,
                                  );
                                },
                              ),
                            ),
                            if(FFAppState().user.profile == Profile.admin || FFAppState().user.profile == Profile.producer || FFAppState().user.userId == FFAppState().selectedProducer.userId)
                              wrapWithModel(
                                model: _model.settingTileModel2,
                                updateCallback: () => safeSetState(() {}),
                                child: SettingTileWidget(
                                  icon: Icon(
                                    FFIcons.kicTicketNew,
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    size: 20.0,
                                  ),
                                  title: 'Events Access',
                                  endLable: '',
                                  showTrailingIcon: true,
                                  onTap: () async {
                                    logFirebaseEvent('PIN_DETAILS_SCREEN_Container_nha0482w_CA');

                                    context.pushNamed(
                                      PinEventsScreenWidget.routeName,
                                      queryParameters: {
                                        'pin': serializeParam(
                                          _model.watchPIn,
                                          ParamType.SupabaseRow,
                                        ),
                                      }.withoutNulls,
                                    );
                                  },
                                ),
                              ),
                            if (!widget.isNew)
                              wrapWithModel(
                                model: _model.settingTileModel3,
                                updateCallback: () => safeSetState(() {}),
                                child: SettingTileWidget(
                                  icon: Icon(
                                    FFIcons.kicMobile,
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    size: 20.0,
                                  ),
                                  title: 'Manage Devices',
                                  endLable: '',
                                  showTrailingIcon: true,
                                  onTap: () async {
                                    logFirebaseEvent('PIN_DETAILS_SCREEN_Container_3do2kld7_CA');

                                    context.pushNamed(
                                      PinDevicesScreenWidget.routeName,
                                      queryParameters: {
                                        'pin': serializeParam(
                                          _model.watchPIn,
                                          ParamType.SupabaseRow,
                                        ),
                                      }.withoutNulls,
                                    );
                                  },
                                ),
                              ),
                            wrapWithModel(
                              model: _model.settingTileModel4,
                              updateCallback: () => safeSetState(() {}),
                              child: SettingTileWidget(
                                icon: Icon(
                                  FFIcons.kicPermission,
                                  color: FlutterFlowTheme.of(context).primaryText,
                                  size: 20.0,
                                ),
                                title: 'Permission',
                                endLable: '',
                                showTrailingIcon: true,
                                onTap: () async {
                                  logFirebaseEvent('PIN_DETAILS_SCREEN_Container_merxa74f_CA');

                                  context.pushNamed(
                                    PinPermissionsScreenWidget.routeName,
                                    queryParameters: {
                                      'pin': serializeParam(
                                        _model.watchPIn,
                                        ParamType.SupabaseRow,
                                      ),
                                      'isNew': serializeParam(
                                        widget.isNew,
                                        ParamType.bool,
                                      ),
                                    }.withoutNulls,
                                  );
                                },
                              ),
                            ),
                          ].divide(SizedBox(height: 24.0)),
                        ),
                      ),
                      if (!widget.isNew)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Builder(
                                builder: (context) => FFButtonWidget(
                                  onPressed: () async {
                                    logFirebaseEvent('PIN_DETAILS_SCREEN_DELETE_BTN_ON_TAP');
                                    await showDialog(
                                      context: context,
                                      builder: (dialogContext) {
                                        return Dialog(
                                          elevation: 0,
                                          insetPadding: EdgeInsets.zero,
                                          backgroundColor: Colors.transparent,
                                          alignment: AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                          child: GestureDetector(
                                            onTap: () {
                                              FocusScope.of(dialogContext).unfocus();
                                              FocusManager.instance.primaryFocus?.unfocus();
                                            },
                                            child: DeleteScannerDialogWidget(
                                              title: 'Delete ${widget.pinData?.name}',
                                              subTitle:
                                                  'This action cannot be undone. All associated data will be lost.',
                                              firstBtnText: 'Delete',
                                              secondBtnText: 'Cancel',
                                              firstBtnColor: FlutterFlowTheme.of(context).error,
                                              secondBtnColor: Color(0x99FFFFFF),
                                            ),
                                          ),
                                        );
                                      },
                                    ).then((value) => safeSetState(() => _model.isDeletePin = value));

                                    if (_model.isDeletePin!) {
                                      _model.availablePins = await DeviceTable().queryRows(
                                        queryFn: (q) => q.eqOrNull(
                                          'pin_id',
                                          widget.pinData?.uid,
                                        ),
                                      );
                                      _model.devices = _model.availablePins!.toList().cast<DeviceRow>();
                                      while (_model.devices.isNotEmpty) {
                                        await CheckInLogsTable().delete(
                                          matchingRows: (rows) => rows.eqOrNull(
                                            'device_id',
                                            _model.devices.firstOrNull?.uid,
                                          ),
                                        );
                                        await DeviceTable().delete(
                                          matchingRows: (rows) => rows.eqOrNull(
                                            'uid',
                                            _model.devices.firstOrNull?.uid,
                                          ),
                                        );
                                        _model.removeFromDevices(_model.devices.firstOrNull!);
                                      }
                                      await PinTable().delete(
                                        matchingRows: (rows) => rows.eqOrNull(
                                          'uid',
                                          widget.pinData?.uid,
                                        ),
                                      );
                                      await showDialog(
                                        context: context,
                                        builder: (dialogContext) {
                                          return Dialog(
                                            elevation: 0,
                                            insetPadding: EdgeInsets.zero,
                                            backgroundColor: Colors.transparent,
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                            child: GestureDetector(
                                              onTap: () {
                                                FocusScope.of(dialogContext).unfocus();
                                                FocusManager.instance.primaryFocus?.unfocus();
                                              },
                                              child: SuccessDialogWidget(
                                                title: 'Pin Deleted',
                                                subTitle: 'The pin has been successfully removed.',
                                              ),
                                            ),
                                          );
                                        },
                                      );

                                      context.safePop();
                                    }

                                    safeSetState(() {});
                                  },
                                  text: 'Delete',
                                  icon: Icon(
                                    FFIcons.kicCloseCircle,
                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                    size: 16.0,
                                  ),
                                  options: FFButtonOptions(
                                    height: 52.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                    color: FlutterFlowTheme.of(context).error,
                                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                          fontFamily: 'MonaSans',
                                          color: FlutterFlowTheme.of(context).primaryBackground,
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
                            Expanded(
                              child: Builder(
                                builder: (context) => FFButtonWidget(
                                  onPressed: () async {
                                    logFirebaseEvent('PIN_DETAILS_SCREEN_DISABLE_BTN_ON_TAP');
                                    if (widget!.pinData!.isEnable ?? false) {
                                      await showDialog(
                                        context: context,
                                        builder: (dialogContext) {
                                          return Dialog(
                                            elevation: 0,
                                            insetPadding: EdgeInsets.zero,
                                            backgroundColor: Colors.transparent,
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                            child: GestureDetector(
                                              onTap: () {
                                                FocusScope.of(dialogContext).unfocus();
                                                FocusManager.instance.primaryFocus?.unfocus();
                                              },
                                              child: DeleteScannerDialogWidget(
                                                title: 'Disable Kobi\'s Scanner',
                                                subTitle:
                                                    ' The associated data will remain intact, but new devices will no longer be able to log in using this PIN.',
                                                firstBtnText: 'Disable',
                                                secondBtnText: 'Cancel',
                                                firstBtnColor: FlutterFlowTheme.of(context).warning,
                                                secondBtnColor: Color(0x99FFFFFF),
                                              ),
                                            ),
                                          );
                                        },
                                      ).then((value) => safeSetState(() => _model.isDisablePin = value));

                                      if (_model.isDisablePin!) {
                                        await PinTable().update(
                                          data: {
                                            'is_enable': false,
                                          },
                                          matchingRows: (rows) => rows.eqOrNull(
                                            'uid',
                                            widget.pinData?.uid,
                                          ),
                                        );
                                        await showDialog(
                                          context: context,
                                          builder: (dialogContext) {
                                            return Dialog(
                                              elevation: 0,
                                              insetPadding: EdgeInsets.zero,
                                              backgroundColor: Colors.transparent,
                                              alignment:
                                                  AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                              child: GestureDetector(
                                                onTap: () {
                                                  FocusScope.of(dialogContext).unfocus();
                                                  FocusManager.instance.primaryFocus?.unfocus();
                                                },
                                                child: SuccessDialogWidget(
                                                  title: 'Pin Disabled',
                                                  subTitle: 'The pin has been successfully disabled.',
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      }
                                    } else {
                                      await PinTable().update(
                                        data: {
                                          'is_enable': true,
                                        },
                                        matchingRows: (rows) => rows.eqOrNull(
                                          'uid',
                                          widget.pinData?.uid,
                                        ),
                                      );
                                    }

                                    context.pop();

                                    safeSetState(() {});
                                  },
                                  text: (widget.pinData?.isEnable ?? false) ? 'Disable' : "Enable",
                                  icon: Icon(
                                    FFIcons.kicCloseCircle,
                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                    size: 16.0,
                                  ),
                                  options: FFButtonOptions(
                                    height: 52.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                    color: valueOrDefault<Color>(
                                      widget!.pinData!.isEnable ?? false
                                          ? FlutterFlowTheme.of(context).warning
                                          : FlutterFlowTheme.of(context).success,
                                      FlutterFlowTheme.of(context).warning,
                                    ),
                                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                          fontFamily: 'MonaSans',
                                          color: FlutterFlowTheme.of(context).primaryBackground,
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
                          ].divide(SizedBox(width: 24.0)),
                        ),
                    ].divide(SizedBox(height: 24.0)),
                  ),
                ),
              ),
            ].divide(SizedBox(height: 8.0)),
          ),
        ),
      ),
    );
  }
}

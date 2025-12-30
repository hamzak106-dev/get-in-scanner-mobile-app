import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:g_e_t_i_n_scanner/components/card_scanning/card_scanning_widget.dart'
    show CardScanningWidget;
import 'package:g_e_t_i_n_scanner/components/setting/splash_setting_widget.dart';
import 'package:g_e_t_i_n_scanner/components/setting_tile/setting_tile_widget_2.dart';
import 'package:provider/provider.dart';

import '/actions/actions.dart' as action_blocks;
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/components/dialogs/logout_dialog/logout_dialog_widget.dart';
import '/components/setting_tile/setting_tile_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import '../../../custom_code/actions/init_power_sync.dart';
import 'setting_screen_model.dart';

export 'setting_screen_model.dart';

class SettingScreenWidget extends StatefulWidget {
  const SettingScreenWidget({super.key});

  static String routeName = 'SettingScreen';
  static String routePath = '/settingScreen';

  @override
  State<SettingScreenWidget> createState() => _SettingScreenWidgetState();
}

class _SettingScreenWidgetState extends State<SettingScreenWidget>
    with TickerProviderStateMixin {
  late SettingScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SettingScreenModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'SettingScreen'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('SETTING_SCREEN_SettingScreen_ON_INIT_STA');
      _model.posEventId = await actions.getPosEventId();
      _model.appVersionNameResult = await actions.getAppVersionName();
      _model.appVersionName = _model.appVersionNameResult!;
      _model.userResponse = await actions.fetchUser();
      if (_model.userResponse != null) {
        FFAppState().updateUserStruct(
          (e) => e
            ..updateUser(
              (e) => e
                ..firstName = (String name) {
                  return name.split(" ").first;
                }(_model.userResponse!.name!)
                ..lastName = (String name) {
                  return name.split(" ").last;
                }(_model.userResponse!.name!)
                ..phone = _model.userResponse?.phone
                ..email = _model.userResponse?.email
                ..phoneCountryCode = _model.userResponse?.phoneCountryCode
                ..profileImg = _model.userResponse?.profileImg,
            ),
        );
        safeSetState(() {});
      }
      watchPins();
    });

    animationsMap.addAll({
      'iconOnPageLoadAnimation': AnimationInfo(
        loop: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          RotateEffect(
            curve: Curves.linear,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
    });
  }

  watchPins() async {
    _model.pinData = [];
    _model.devices = [];
    safeSetState(() {});
    await actions.watchAuthorisedPins(
      (result) async {
        _model.pinResponse = await actions.getPinList(
          result?.toList(),
        );
        _model.pinData = _model.pinResponse!.toList().cast<PinRow>();
        safeSetState(() {});
        await actions.watchDeviceLists(
          (result) async {
            _model.deviceResponse = await actions.getDeviceList(
              result?.toList(),
            );
            _model.devices = _model.deviceResponse!.toList().cast<DeviceRow>();
            safeSetState(() {});
          },
          _model.pinData.map((e) => e.uid).toList().toList(),
        );
      },
    );
    safeSetState(() {});
  }

  @override
  void dispose() {
    _model.dispose();
    actions.cancelSubscription(listsSubscription);
    actions.cancelSubscription(deviceSubscription);
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
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Settings',
                style: FlutterFlowTheme.of(context).titleLarge.override(
                      fontFamily: 'MonaSans',
                      fontSize: 22.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      if ((FFAppState().user.profile == Profile.admin) ||
                          (FFAppState().user.profile == Profile.producer))
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  12.0, 0.0, 0.0, 0.0),
                              child: Text(
                                'General',
                                style: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'MonaSans',
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ),
                            wrapWithModel(
                              model: _model.settingTileModel1,
                              updateCallback: () => safeSetState(() {}),
                              child: SettingTileWidget(
                                icon: Icon(
                                  FFIcons.kicApartment,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 20.0,
                                ),
                                title: 'Organization',
                                endLable: 'GetIn INC',
                                onTap: () async {},
                              ),
                            ),
                            if (FFAppState().user.user.phone != '')
                              wrapWithModel(
                                model: _model.settingTileModel2,
                                updateCallback: () => safeSetState(() {}),
                                child: SettingTileWidget(
                                  icon: Icon(
                                    FFIcons.kicSmartPhone,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 20.0,
                                  ),
                                  title: 'Phone',
                                  endLable: FFAppState().user.user.phone,
                                  onTap: () async {},
                                ),
                              ),
                            wrapWithModel(
                              model: _model.settingTileModel3,
                              updateCallback: () => safeSetState(() {}),
                              child: SettingTileWidget(
                                icon: Icon(
                                  FFIcons.kicMail,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 20.0,
                                ),
                                title: 'Email Address',
                                endLable: FFAppState().user.user.email,
                                onTap: () async {},
                              ),
                            ),
                          ],
                        ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 0.0, 0.0),
                            child: Text(
                              'Info',
                              style: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'MonaSans',
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    12.0, 16.0, 12.0, 16.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    logFirebaseEvent(
                                        'SETTING_SCREEN_PAGE_Row_jqinbkta_ON_TAP');
                                    if (functions.getAccessPermissionAllow(
                                        FFAppState().user.permissions,
                                        AccessPermission.settings,
                                        FFAppState().user.profile)) {
                                      context.pushNamed(
                                          SyncScreenWidget.routeName);
                                    }
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Icon(
                                        FFIcons.kicBackup,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 20.0,
                                      ),
                                      Expanded(
                                        child: Text(
                                          'Sync Status',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyLarge
                                              .override(
                                                fontFamily: 'MonaSans',
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            () {
                                              if ((FFAppState().syncStatus ==
                                                      null) ||
                                                  valueOrDefault<bool>(
                                                    FFAppState()
                                                        .syncStatus
                                                        .uploading,
                                                    true,
                                                  )) {
                                                return 'Syncing';
                                              } else if (FFAppState()
                                                  .syncStatus
                                                  .hasSynced) {
                                                return 'OK';
                                              } else {
                                                return 'Needed';
                                              }
                                            }(),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyLarge
                                                .override(
                                                  fontFamily: 'MonaSans',
                                                  color: () {
                                                    if ((FFAppState()
                                                                .syncStatus ==
                                                            null) ||
                                                        valueOrDefault<bool>(
                                                          FFAppState()
                                                              .syncStatus
                                                              .uploading,
                                                          true,
                                                        )) {
                                                      return FlutterFlowTheme
                                                              .of(context)
                                                          .warning;
                                                    } else if (FFAppState()
                                                        .syncStatus
                                                        .hasSynced) {
                                                      return FlutterFlowTheme
                                                              .of(context)
                                                          .success;
                                                    } else {
                                                      return FlutterFlowTheme
                                                              .of(context)
                                                          .error;
                                                    }
                                                  }(),
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                          Builder(
                                            builder: (context) {
                                              if ((FFAppState().syncStatus ==
                                                      null) ||
                                                  valueOrDefault<bool>(
                                                    FFAppState()
                                                        .syncStatus
                                                        .uploading,
                                                    true,
                                                  )) {
                                                return Icon(
                                                  Icons.sync,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .warning,
                                                  size: 16.0,
                                                ).animateOnPageLoad(animationsMap[
                                                    'iconOnPageLoadAnimation']!);
                                              } else if (FFAppState()
                                                  .syncStatus
                                                  .hasSynced) {
                                                return Icon(
                                                  FFIcons.kicCheckCircle,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .success,
                                                  size: 16.0,
                                                );
                                              } else {
                                                return Icon(
                                                  FFIcons.kicError,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .error,
                                                  size: 16.0,
                                                );
                                              }
                                            },
                                          ),
                                        ].divide(SizedBox(width: 12.0)),
                                      ),
                                      if (functions.getAccessPermissionAllow(
                                          FFAppState().user.permissions,
                                          AccessPermission.settings,
                                          FFAppState().user.profile))
                                        Icon(
                                          FFIcons.kicArrowNext,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          size: 24.0,
                                        ),
                                    ].divide(SizedBox(width: 20.0)),
                                  ),
                                ),
                              ),
                              /// disabled POS for ios
                              if (false && isiOS && _model.posEventId != null)
                                Builder(builder: (context) {
                                  final currentDevice = _model.devices
                                      .firstWhere(
                                          (e) =>
                                              e.deviceId == FFAppState().uuid,
                                          orElse: () => DeviceRow({}));
                                  if (currentDevice.tapToPayEnabled != true) {
                                    return Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 16.0, 12.0, 16.0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          logFirebaseEvent(
                                              'SETTING_SCREEN_PAGE_Row_jqinbka_ON_TAP');
                                          await showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              builder: (context) {
                                                return CardScanningWidget(
                                                    eventId:
                                                        _model.posEventId!);
                                              });
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            SvgPicture.asset(
                                              'assets/svg/tap_to_pay_icon.svg',
                                              width: 25,
                                            ),
                                            Expanded(
                                              child: Text(
                                                'Enable Tap to Pay on iPhone',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyLarge
                                                        .override(
                                                          fontFamily:
                                                              'MonaSans',
                                                          letterSpacing: 0.0,
                                                        ),
                                              ),
                                            ),
                                            // if (functions
                                            //     .getAccessPermissionAllow(
                                            //         FFAppState()
                                            //             .user
                                            //             .permissions,
                                            //         AccessPermission.settings,
                                            //         FFAppState().user.profile))
                                            Icon(
                                              FFIcons.kicArrowNext,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              size: 24.0,
                                            ),
                                          ].divide(SizedBox(width: 20.0)),
                                        ),
                                      ),
                                    );
                                  }
                                  return Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 16.0, 12.0, 16.0),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        logFirebaseEvent(
                                            'SETTING_SCREEN_PAGE_Row_jqinbfa_ON_TAP');
                                        await actions.disableTapToPay(
                                            FFAppState().uuid,
                                            FFAppState().user.userId);
                                        safeSetState(() {});
                                        // await showModalBottomSheet(
                                        //     context: context,
                                        //     isScrollControlled: true,
                                        //     builder: (context) {
                                        //       return CardScanningWidget(
                                        //           eventId: _model.posEventId!);
                                        //     });
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          SvgPicture.asset(
                                            'assets/svg/tap_to_pay_icon.svg',
                                            width: 25,
                                          ),
                                          Expanded(
                                            child: Text(
                                              'Disable Tap to Pay on iPhone',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyLarge
                                                      .override(
                                                        fontFamily: 'MonaSans',
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                          ),
                                          // if (functions
                                          //     .getAccessPermissionAllow(
                                          //     FFAppState()
                                          //         .user
                                          //         .permissions,
                                          //     AccessPermission.settings,
                                          //     FFAppState().user.profile))
                                          Icon(
                                            FFIcons.kicArrowNext,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 24.0,
                                          ),
                                        ].divide(SizedBox(width: 20.0)),
                                      ),
                                    ),
                                  );
                                }),
                              Divider(
                                height: 1.0,
                                thickness: 1.0,
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                            ],
                          ),
                          if (false)
                            wrapWithModel(
                              model: _model.settingTileModel4,
                              updateCallback: () => safeSetState(() {}),
                              child: SettingTileWidget(
                                icon: Icon(
                                  FFIcons.kicInspect,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 20.0,
                                ),
                                title: 'Sync Status',
                                endLable: '589250',
                                onTap: () async {},
                              ),
                            ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 0.0, 0.0),
                            child: Text(
                              'Users',
                              style: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'MonaSans',
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ),
                          wrapWithModel(
                            model: _model.settingTileModel5,
                            updateCallback: () => safeSetState(() {}),
                            child: SettingTileWidget(
                              icon: Icon(
                                FFIcons.kicPath,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                size: 20.0,
                              ),
                              title: 'Version',
                              endLable: _model.appVersionName,
                              onTap: () async {},
                            ),
                          ),
                          // if ((FFAppState().user.isProducer == 1) && (FFAppState().user.isManager == 1))
                          //   wrapWithModel(
                          //     model: _model.settingTileModel6,
                          //     updateCallback: () => safeSetState(() {}),
                          //     child: SettingTileWidget(
                          //       icon: Icon(
                          //         FFIcons.kicOutlineUser,
                          //         color: FlutterFlowTheme.of(context).secondaryText,
                          //         size: 20.0,
                          //       ),
                          //       title: 'Switch Role',
                          //       endLable: FFAppState().user.profile == Profile.manager ? 'Manager' : 'Producer',
                          //       showTrailingIcon: true,
                          //       onTap: () async {
                          //         logFirebaseEvent('SETTING_SCREEN_Container_nxv1rm7m_CALLBA');
                          //
                          //         context.pushNamed(SelectProfileScreenWidget.routeName);
                          //       },
                          //     ),
                          //   ),
                          if (FFAppState().user.profile == Profile.manager)
                            wrapWithModel(
                              model: _model.settingTileModel7,
                              updateCallback: () => safeSetState(() {}),
                              child: SettingTileWidget(
                                icon: Icon(
                                  FFIcons.kicOutlineUser,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 20.0,
                                ),
                                title: 'Account',
                                endLable: valueOrDefault<String>(
                                  FFAppState().selectedProducer.firstName,
                                  '-',
                                ),
                                showTrailingIcon: true,
                                onTap: () async {
                                  logFirebaseEvent(
                                      'SETTING_SCREEN_Container_vr6dtx4e_CALLBA');
                                  await action_blocks
                                      .producerSelectionBlock(context);
                                  watchPins();
                                  safeSetState(() {});
                                },
                              ),
                            ),
                          wrapWithModel(
                            model: _model.settingTileModel8,
                            updateCallback: () => safeSetState(() {}),
                            child: SettingTileWidget(
                              icon: Icon(
                                FFIcons.kicSmartPhone,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                size: 20.0,
                              ),
                              title: 'Device',
                              endLable: (FFAppState().user.profile ==
                                      Profile.manager)
                                  ? '${FFAppState().selectedProducer.firstName}\'s Scanner ( ${FFAppState().selectedProducer.userId.toString()} )'
                                  : '${FFAppState().user.user.firstName}\'s Scanner ( ${FFAppState().user.userId.toString()} )',
                              showTrailingIcon: false,
                              onTap: () async {},
                            ),
                          ),
                          if (_model.pinData.isNotEmpty)
                            wrapWithModel(
                              model: _model.settingTileModel9,
                              updateCallback: () => safeSetState(() {}),
                              child: SettingTileWidget(
                                icon: Icon(
                                  FFIcons.kicLock,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 20.0,
                                ),
                                title: 'Access Code',
                                endLable: valueOrDefault<String>(
                                  _model.pinData.firstOrNull?.accessCode,
                                  'N/A',
                                ),
                                onTap: () async {},
                              ),
                            ),
                          if (_model.pinData.isNotEmpty)
                            wrapWithModel(
                              model: _model.settingTileModel10,
                              updateCallback: () => safeSetState(() {}),
                              child: SettingTileWidget(
                                icon: Icon(
                                  FFIcons.kicLock,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 20.0,
                                ),
                                title: 'Pin',
                                endLable: FFAppState().user.profile ==
                                        Profile.scanner
                                    ? valueOrDefault<String>(
                                        _model.pinData
                                            .where((e) =>
                                                e.uid ==
                                                FFAppState().user.pinId)
                                            .toList()
                                            .firstOrNull
                                            ?.pin
                                            .toString(),
                                        'N/A',
                                      )
                                    : valueOrDefault<String>(
                                        _model.pinData
                                            .where((e) => e.type == 'SYSTEM')
                                            .toList()
                                            .firstOrNull
                                            ?.pin
                                            .toString(),
                                        'N/A',
                                      ),
                                showTrailingIcon: false,
                                onTap: () async {},
                              ),
                            ),
                          wrapWithModel(
                            model: _model.settingTileModel13,
                            updateCallback: () => safeSetState(() {}),
                            child: SettingTileWidget2(
                              iconPath: "assets/svg/magic-star.svg",
                              title: 'Splash Screen',
                              endLable: FFAppState().splashScreenStatus,
                              showTrailingIcon: true,
                              onTap: () async {
                                        context.pushNamed(SplashSettingWidget.routeName);

                                // logFirebaseEvent('SETTING_SCREEN_SPLASH_SCREEN_TILE_ON_TAP');
                                //
                                // final newStatus = FFAppState().splashScreenStatus == 'Enabled' ? 'Disabled' : 'Enabled';
                                //
                                // showDialog(
                                //   context: context,
                                //   builder: (dialogContext) {
                                //     return AlertDialog(
                                //       title: Text('Change Splash Screen'),
                                //       content: Text('Are you sure you want to $newStatus the splash screen for future loads?'),
                                //       actions: [
                                //         TextButton(
                                //           onPressed: () {
                                //             Navigator.pop(dialogContext); // close dialog
                                //           },
                                //           child: Text('Cancel'),
                                //         ),
                                //         TextButton(
                                //           onPressed: () {
                                //             FFAppState().splashScreenStatus = newStatus;
                                //             safeSetState(() {}); // update UI
                                //             Navigator.pop(dialogContext); // close dialog
                                //           },
                                //           child: Text('Confirm'),
                                //         ),
                                //       ],
                                //     );
                                //   },
                                // );


                              },
                            ),
                          ),


                        ],
                      ),
                      if ((FFAppState().user.profile == Profile.admin) ||
                          (FFAppState().user.profile == Profile.producer))
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (_model.devices.isNotEmpty)
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    12.0, 0.0, 0.0, 0.0),
                                child: Text(
                                  'Team',
                                  style: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: 'MonaSans',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ),
                            Builder(
                              builder: (context) {
                                final device = _model.devices.toList();

                                return Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: List.generate(device.length,
                                      (deviceIndex) {
                                    final deviceItem = device[deviceIndex];
                                    return SettingTileWidget(
                                      key: Key(
                                          'Keydd6_${deviceIndex}_of_${device.length}'),
                                      icon: Icon(
                                        FFIcons.kicSmartPhone,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 20.0,
                                      ),
                                      title: deviceItem.name,
                                      endLable: '',
                                      showTrailingIcon: true,
                                      onTap: () async {
                                        logFirebaseEvent(
                                            'SETTING_SCREEN_Container_dd6wt1i1_CALLBA');

                                        context.pushNamed(
                                          AddScannersScreenWidget.routeName,
                                          queryParameters: {
                                            'scanner': serializeParam(
                                              _model.pinData.firstOrNull,
                                              ParamType.SupabaseRow,
                                            ),
                                            'device': serializeParam(
                                              deviceItem,
                                              ParamType.SupabaseRow,
                                            ),
                                          }.withoutNulls,
                                        );
                                      },
                                    );
                                  }),
                                );
                              },
                            ),
                          ],
                        ),
                      if (FFAppState().user.profile != Profile.scanner)
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (_model.pinData.isNotEmpty)
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    12.0, 0.0, 0.0, 12.0),
                                child: Text(
                                  'On Site Pin',
                                  style: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: 'MonaSans',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ),
                            Builder(
                              builder: (context) {
                                final pin = _model.pinData
                                    .where((e) => (FFAppState().user.profile ==
                                                Profile.manager &&
                                            FFAppState().user.userId !=
                                                FFAppState()
                                                    .selectedProducer
                                                    .userId)
                                        ? e.type == 'ON_SITE_PIN' &&
                                            e.createdBy ==
                                                FFAppState().user.userId
                                        : e.type == 'ON_SITE_PIN')
                                    .toList();
                                // final pin = _model.pinData.where((e) => e.type == 'ON_SITE_PIN' && (FFAppState().user.profile != Profile.manager || e.createdBy == FFAppState().user.userId)).toList();

                                return Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children:
                                      List.generate(pin.length, (pinIndex) {
                                    final pinItem = pin[pinIndex];
                                    return wrapWithModel(
                                      model:
                                          _model.settingTileModels12.getModel(
                                        pinItem.uid.toString(),
                                        pinIndex,
                                      ),
                                      updateCallback: () => safeSetState(() {}),
                                      child: SettingTileWidget(
                                        key: Key(
                                          'Key402_${pinItem.uid.toString()}',
                                        ),
                                        icon: Icon(
                                          FFIcons.kicPassword,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          size: 20.0,
                                        ),
                                        title: pinItem.name != null &&
                                                pinItem.name!.isNotEmpty
                                            ? '${pinItem.name ?? ""} ( ${pinItem.pin.toString()} )'
                                            : pinItem.pin.toString(),
                                        endLable: '',
                                        showTrailingIcon: true,
                                        onTap: () async {
                                          logFirebaseEvent(
                                              'SETTING_SCREEN_Container_402cfbov_CALLBA');

                                          context.pushNamed(
                                            PinDetailsScreenWidget.routeName,
                                            queryParameters: {
                                              'pinData': serializeParam(
                                                pinItem,
                                                ParamType.SupabaseRow,
                                              ),
                                              'isNew': serializeParam(
                                                false,
                                                ParamType.bool,
                                              ),
                                            }.withoutNulls,
                                          );
                                        },
                                      ),
                                    );
                                  }),
                                );
                              },
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                logFirebaseEvent(
                                    'SETTING_SCREEN_Container_1l68dtn9_ON_TAP');
                                if ((FFAppState().user.profile ==
                                        Profile.manager) &&
                                    (FFAppState().selectedProducer.userId !=
                                        FFAppState().user.userId)) {
                                  context.pushNamed(
                                      PinManagerEventsScreenWidget.routeName);
                                } else {
                                  context.pushNamed(
                                    PinInfoScreenWidget.routeName,
                                    queryParameters: {
                                      'isNew': serializeParam(
                                        true,
                                        ParamType.bool,
                                      ),
                                      'pin': serializeParam(
                                        _model.pinData.firstOrNull,
                                        ParamType.SupabaseRow,
                                      ),
                                    }.withoutNulls,
                                  );
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                height: 60.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 50.0,
                                      color: Color(0x80000000),
                                      offset: Offset(
                                        4.0,
                                        4.0,
                                      ),
                                      spreadRadius: 10.0,
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      FFIcons.kicAddFillCircle,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 24.0,
                                    ),
                                    Text(
                                      'New Access Pin',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'MonaSans',
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ].divide(SizedBox(width: 12.0)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      Builder(
                        builder: (context) => Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              12.0, 16.0, 12.0, 16.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              logFirebaseEvent(
                                  'SETTING_SCREEN_PAGE_Row_ajv8okqb_ON_TAP');
                              await showDialog(
                                context: context,
                                builder: (dialogContext) {
                                  return Dialog(
                                    elevation: 0,
                                    insetPadding: EdgeInsets.zero,
                                    backgroundColor: Colors.transparent,
                                    alignment: AlignmentDirectional(0.0, 0.0)
                                        .resolve(Directionality.of(context)),
                                    child: LogoutDialogWidget(
                                      title: 'Logout?',
                                      subTitle:
                                          'This will delete all app data and take you back to main login screen.',
                                      firstBtnText: 'Logout',
                                      secondBtnText: 'Go Back',
                                      firstBtnColor:
                                          FlutterFlowTheme.of(context).error,
                                      secondBtnColor:
                                          FlutterFlowTheme.of(context).info,
                                      firstTap: () async {
                                        actions.clearDatabase();
                                        Navigator.pop(context);
                                        context.goNamed(
                                          LoadingScreenWidget.routeName,
                                          queryParameters: {
                                            'avoidWaiting': serializeParam(
                                              true,
                                              ParamType.bool,
                                            ),
                                          }.withoutNulls,
                                        );
                                      },
                                      secondTap: () async {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  FFIcons.kicLogout,
                                  color: FlutterFlowTheme.of(context).error,
                                  size: 20.0,
                                ),
                                Expanded(
                                  child: Text(
                                    'Logout',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                          fontFamily: 'MonaSans',
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ),
                                Icon(
                                  FFIcons.kicArrowNext,
                                  color: FlutterFlowTheme.of(context).error,
                                  size: 24.0,
                                ),
                              ].divide(SizedBox(width: 20.0)),
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(height: 45,),
                    ].divide(SizedBox(height: 20.0)),
                  ),
                ),
              ),
              SizedBox(height: 45,),
            ].divide(SizedBox(height: 20.0)),
          ),
        ),
      ),
    );
  }
}

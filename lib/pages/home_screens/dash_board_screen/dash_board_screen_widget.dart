import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:g_e_t_i_n_scanner/components/card_scanning/card_scanning_widget.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:powersync/powersync.dart' as powersync;
import 'package:provider/provider.dart';

import '';
import '/actions/actions.dart' as action_blocks;
import '/backend/schema/enums/enums.dart';
import '/components/dialogs/delete_scanner_dialog/delete_scanner_dialog_widget.dart';
import '/components/rive_animation_view/rive_animation_view_widget.dart';
import '/components/screen_component/admin_dashboard/admin_dashboard_widget.dart';
import '/components/screen_component/user_dashboard/user_dashboard_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import '/pages/manager/manager_dashboard/manager_dashboard_widget.dart';
import '../../../custom_code/actions/init_power_sync.dart' as initPowersync;
import '../../../custom_code/actions/init_power_sync.dart';
import 'dash_board_screen_model.dart';

export 'dash_board_screen_model.dart';

class DashBoardScreenWidget extends StatefulWidget {
  const DashBoardScreenWidget({super.key});

  static String routeName = 'DashBoardScreen';
  static String routePath = '/dashBoardScreen';

  @override
  State<DashBoardScreenWidget> createState() => _DashBoardScreenWidgetState();
}

class _DashBoardScreenWidgetState extends State<DashBoardScreenWidget> {
  late DashBoardScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DashBoardScreenModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'DashBoardScreen'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('DASH_BOARD_SCREEN_DashBoardScreen_ON_INI');
      if (!FFAppState().hasFirstSync) {
        _model.topBannerVisible = true;
        _model.messageSyncing = 'Syncing Started ...';
        _model.bannerColor = FlutterFlowTheme.of(context).accent3;
        await action_blocks.syncData(context);
        _model.messageSyncing = 'Syncing Complete.';
        _model.bannerColor = FlutterFlowTheme.of(context).success;
        await Future.delayed(const Duration(milliseconds: 1000));
        _model.topBannerVisible = false;
        FFAppState().hasFirstSync = true;
        safeSetState(() {});
      }

      await actions.watchDeviceDetails(
        (result) async {
          if (!(result != null && (result).isNotEmpty) &&
              !_model.isDeleteDialogOpen) {
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
                    child: DeleteScannerDialogWidget(
                      title: 'Account Deleted',
                      subTitle: 'Your account has been deleted by the admin.',
                      firstBtnText: 'Okay',
                      firstBtnColor: FlutterFlowTheme.of(context).error,
                    ),
                  ),
                );
              },
            ).then((value) => safeSetState(() => _model.deleteAccount = value));

            _model.isDeleteDialogOpen = true;
            unawaited(
              () async {
                await actions.clearDatabase();
              }(),
            );

            context.goNamed(
              LoadingScreenWidget.routeName,
              queryParameters: {
                'avoidWaiting': serializeParam(
                  true,
                  ParamType.bool,
                ),
              }.withoutNulls,
            );
          }
        },
        FFAppState().user.deviceId,
      );

      await actions.watchAuthorisedPins(
        (result) async {
          FFAppState().updateUserStruct(
            (e) => e
              ..permissions = result
                      ?.where((e) => e.uid == FFAppState().user.pinId)
                      .toList()
                      .firstOrNull
                      ?.permissions ??
                  0,
          );
          safeSetState(() {});
        },
      );
    });
  }

  @override
  void dispose() {
    _model.dispose();
    actions.cancelSubscription(listsSubscription);
    actions.cancelSubscription(deviceDetailSubscription);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Builder(
      builder: (context) => GestureDetector(
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
              children: [
                Expanded(
                  child: Builder(
                    builder: (context) {
                      if (FFAppState().hasFirstSync) {
                        return Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0,
                              valueOrDefault<double>(
                                !FFAppState().hasFirstSync ? 56.0 : 0.0,
                                0.0,
                              ),
                              0.0,
                              0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Flexible(
                                child: Builder(
                                  builder: (context) {
                                    if (FFAppState().user.profile ==
                                        Profile.manager) {
                                      return wrapWithModel(
                                        model: _model.managerDashboardModel,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: ManagerDashboardWidget(),
                                      );
                                    } else if (FFAppState().user.profile ==
                                        Profile.scanner) {
                                      return wrapWithModel(
                                        model: _model.userDashboardModel,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: UserDashboardWidget(),
                                      );
                                    } else {
                                      return wrapWithModel(
                                        model: _model.adminDashboardModel,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: AdminDashboardWidget(),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            wrapWithModel(
                              model: _model.riveAnimationViewModel,
                              updateCallback: () => safeSetState(() {}),
                              child: RiveAnimationViewWidget(
                                type: RiveAnimType.LoadingLogo,
                              ),
                            ),
                            StreamBuilder(
                                stream: initPowersync.db.statusStream,
                                builder: (context, snapshot) {
                                  debugPrint(snapshot.data?.priorityStatusEntries
                                      .toList()
                                      .toString());
                                  if (snapshot.data?.downloadProgress == null) {
                                    return Text(
                                      "Getting things ready...",
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'MonaSans',
                                            letterSpacing: 0.0,
                                            useGoogleFonts: false,
                                          ),
                                    );
                                  }

                                  powersync.SyncDownloadProgress syncData =
                                      snapshot.data!.downloadProgress!;

                                  if (syncData.downloadedFraction >
                                      _model.currentProgress) {
                                    _model.currentProgress =
                                        syncData.downloadedFraction;
                                  }

                                  return Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            44.0, 0.0, 44.0, 0.0),
                                        child: LinearPercentIndicator(
                                          percent: _model.currentProgress,
                                          lineHeight: 10.0,
                                          animation: true,
                                          animateFromLastPercent: true,
                                          progressColor:
                                              FlutterFlowTheme.of(context).secondary,
                                          backgroundColor:
                                              FlutterFlowTheme.of(context).info,
                                          barRadius: Radius.circular(50.0),
                                          padding: EdgeInsets.zero,
                                        ),
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            '${(_model.currentProgress * 100).toInt()} of 100%',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'MonaSans',
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts: false,
                                                ),
                                          ),
                                          Text(
                                            'Fetching data...',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'MonaSans',
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts: false,
                                                ),
                                          ),
                                        ].divide(SizedBox(height: 4.0)),
                                      ),
                                    ].divide(SizedBox(height: 16.0)),
                                  );
                                }),
                          ].divide(SizedBox(height: 16.0)),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(height: 45),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

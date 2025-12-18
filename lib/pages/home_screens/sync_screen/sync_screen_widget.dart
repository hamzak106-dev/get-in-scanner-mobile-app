import '/components/dialogs/info_dialog/info_dialog_widget.dart';
import '/components/sync_tile/sync_tile_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'sync_screen_model.dart';
export 'sync_screen_model.dart';

class SyncScreenWidget extends StatefulWidget {
  const SyncScreenWidget({super.key});

  static String routeName = 'SyncScreen';
  static String routePath = '/syncScreen';

  @override
  State<SyncScreenWidget> createState() => _SyncScreenWidgetState();
}

class _SyncScreenWidgetState extends State<SyncScreenWidget> {
  late SyncScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SyncScreenModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'SyncScreen'});
  }

  @override
  void dispose() {
    _model.dispose();

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
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  logFirebaseEvent('SYNC_SCREEN_PAGE_Row_x31c51hn_ON_TAP');
                  context.safePop();
                },
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      FFIcons.kicArrowBack,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      size: 32.0,
                    ),
                    Text(
                      'Settings',
                      style: FlutterFlowTheme.of(context).titleLarge.override(
                            fontFamily: 'MonaSans',
                            color: FlutterFlowTheme.of(context).secondaryText,
                            fontSize: 14.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                  ].divide(SizedBox(width: 8.0)),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 16.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sync Status',
                          style:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'MonaSans',
                                    fontSize: 18.0,
                                    letterSpacing: 0.0,
                                  ),
                        ),
                        Builder(
                          builder: (context) => FFButtonWidget(
                            onPressed: () async {
                              logFirebaseEvent(
                                  'SYNC_SCREEN_PAGE_SYNC_BTN_ON_TAP');
                              if (FFAppState().syncStatus.downloading) {
                                await showDialog(
                                  context: context,
                                  builder: (dialogContext) {
                                    return Dialog(
                                      elevation: 0,
                                      insetPadding: EdgeInsets.zero,
                                      backgroundColor: Colors.transparent,
                                      alignment: AlignmentDirectional(0.0, 0.0)
                                          .resolve(Directionality.of(context)),
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
                              } else {
                                _model.lastSyncAt =
                                    await actions.powersyncLastSyncAt();
                                if ((_model.lastSyncAt != null) &&
                                    (_model.lastSyncAt!.secondsSinceEpoch <
                                        (getCurrentTimestamp.secondsSinceEpoch -
                                            30))) {
                                  await action_blocks.syncData(context);
                                } else {
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
                                        child: InfoDialogWidget(
                                          title: 'No sync necessary',
                                          isLight: true,
                                          subTitle: 'The device is up to date.',
                                          firstBtnText: 'OK',
                                          firstBtnColor:
                                              FlutterFlowTheme.of(context)
                                                  .accent3,
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
                            text: 'Sync',
                            icon: Icon(
                              FFIcons.kicRefresh,
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              size: 16.0,
                            ),
                            options: FFButtonOptions(
                              height: 36.0,
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
                                  ),
                              elevation: 0.0,
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  wrapWithModel(
                    model: _model.syncTileModel1,
                    updateCallback: () => safeSetState(() {}),
                    child: SyncTileWidget(
                      icon: Icon(
                        FFIcons.kicRefreshCircle,
                        color: FlutterFlowTheme.of(context).secondary,
                        size: 20.0,
                      ),
                      title: 'Last Sync',
                      endLable: FFAppState().syncStatus.uploading ||
                              FFAppState().syncStatus.downloading
                          ? 'Syncing'
                          : dateTimeFormat(
                              "relative", FFAppState().syncStatus.lastSync),
                      showStatus: true,
                      status: () {
                        if (FFAppState().syncStatus.uploadError ||
                            FFAppState().syncStatus.downloadError) {
                          return 'Error';
                        } else if (FFAppState().syncStatus.uploading ||
                            FFAppState().syncStatus.downloading) {
                          return 'Inprogress';
                        } else {
                          return 'Completed';
                        }
                      }(),
                      onTap: () async {},
                    ),
                  ),
                  wrapWithModel(
                    model: _model.syncTileModel2,
                    updateCallback: () => safeSetState(() {}),
                    child: SyncTileWidget(
                      icon: Icon(
                        FFIcons.kicOutlineArrowUp,
                        color: FlutterFlowTheme.of(context).secondary,
                        size: 20.0,
                      ),
                      title: 'Upload',
                      endLable: () {
                        if (FFAppState().syncStatus.uploadError) {
                          return 'Error';
                        } else if (FFAppState().syncStatus.uploading) {
                          return 'Syncing';
                        } else {
                          return 'Nothing to Upload';
                        }
                      }(),
                      showStatus: true,
                      status: () {
                        if (FFAppState().syncStatus.uploadError) {
                          return 'Error';
                        } else if (FFAppState().syncStatus.uploading) {
                          return 'Inprogress';
                        } else {
                          return 'Completed';
                        }
                      }(),
                      onTap: () async {},
                    ),
                  ),
                  wrapWithModel(
                    model: _model.syncTileModel3,
                    updateCallback: () => safeSetState(() {}),
                    child: SyncTileWidget(
                      icon: Icon(
                        FFIcons.kicOutlineArrowDown,
                        color: FlutterFlowTheme.of(context).secondary,
                        size: 20.0,
                      ),
                      title: 'Download',
                      endLable: () {
                        if (FFAppState().syncStatus.downloadError) {
                          return 'Error';
                        } else if (FFAppState().syncStatus.downloading) {
                          return 'Inprogress';
                        } else {
                          return 'Completed';
                        }
                      }(),
                      showStatus: true,
                      status: () {
                        if (FFAppState().syncStatus.downloadError) {
                          return 'Error';
                        } else if (FFAppState().syncStatus.downloading) {
                          return 'Inprogress';
                        } else {
                          return 'Completed';
                        }
                      }(),
                      onTap: () async {},
                    ),
                  ),
                  wrapWithModel(
                    model: _model.syncTileModel4,
                    updateCallback: () => safeSetState(() {}),
                    child: SyncTileWidget(
                      icon: Icon(
                        FFIcons.kicTimer,
                        color: FlutterFlowTheme.of(context).secondary,
                        size: 20.0,
                      ),
                      title: 'Sync Mode',
                      endLable: 'Auto',
                      showStatus: false,
                      onTap: () async {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

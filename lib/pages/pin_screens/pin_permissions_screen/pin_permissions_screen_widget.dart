import '../../../custom_code/actions/index.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/components/permission_tile/permission_tile_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'pin_permissions_screen_model.dart';
export 'pin_permissions_screen_model.dart';

class PinPermissionsScreenWidget extends StatefulWidget {
  const PinPermissionsScreenWidget({
    super.key,
    this.pin,
    bool? isNew,
  }) : this.isNew = isNew ?? false;

  final PinRow? pin;
  final bool isNew;

  static String routeName = 'PinPermissionsScreen';
  static String routePath = '/pinPermissionsScreen';

  @override
  State<PinPermissionsScreenWidget> createState() =>
      _PinPermissionsScreenWidgetState();
}

class _PinPermissionsScreenWidgetState
    extends State<PinPermissionsScreenWidget> {
  late PinPermissionsScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PinPermissionsScreenModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'PinPermissionsScreen'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('PIN_PERMISSIONS_SCREEN_PinPermissionsScr');
      if (widget.pin != null) {
        _model.permissions = widget.pin!.permissions;
        _model.pinPermissionNumber = widget.pin!.permissions;
        _model.isScannerCheck = await isPermissionSelected(
            widget.pin!.permissions, AccessPermission.scan);
        _model.isManualEntry = await isPermissionSelected(
            widget.pin!.permissions, AccessPermission.manualEntry);
        _model.isLookUpCheck = await isPermissionSelected(
            widget.pin!.permissions, AccessPermission.lookup);
        _model.isStatCheck = await isPermissionSelected(
            widget.pin!.permissions, AccessPermission.stats);
        _model.isSettingsCheck = await isPermissionSelected(
            widget.pin!.permissions, AccessPermission.settings);
        safeSetState(() {});
      } else {
        _model.permissions = 0;
        _model.pinPermissionNumber = 0;
        safeSetState(() {});
      }
    });
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
                            'PIN_PERMISSIONS_SCREEN_icArrowBack_ICN_O');
                        context.safePop();
                      },
                    ),
                    Expanded(
                      child: Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Text(
                          'Permission',
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
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                      20.0, 0.0, 20.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      wrapWithModel(
                        model: _model.permissionTileModel1,
                        updateCallback: () => safeSetState(() {}),
                        child: PermissionTileWidget(
                          title: '📡  Scanner',
                          description:
                              'Once activated, the user can scan events/tickets for which they have permission.',
                          isCheck: _model.isScannerCheck,
                          onCheck: (check) async {
                            logFirebaseEvent(
                                'PIN_PERMISSIONS_SCREEN_Container_w1m79w0');
                            _model.permissionNumber =
                                await actions.updatePermissionBitMask(
                              _model.permissions,
                              AccessPermission.scan,
                              check,
                            );
                            _model.isScannerCheck = check;
                            _model.permissions = _model.permissionNumber!;
                            safeSetState(() {});

                            safeSetState(() {});
                          },
                        ),
                      ),
                      wrapWithModel(
                        model: _model.permissionTileModel2,
                        updateCallback: () => safeSetState(() {}),
                        child: PermissionTileWidget(
                          title: '📝️ Manual Entry',
                          description:
                              'Allows manual ticket entry when QR codes are unavailable, ideal for damaged or misssing codes.',
                          isCheck: _model.isManualEntry,
                          onCheck: (check) async {
                            logFirebaseEvent(
                                'PIN_PERMISSIONS_SCREEN_Container_nehap6m');
                            _model.permissionNumber1 =
                                await actions.updatePermissionBitMask(
                              _model.permissions,
                              AccessPermission.manualEntry,
                              check,
                            );
                            _model.isManualEntry = check;
                            _model.permissions = _model.permissionNumber1!;
                            safeSetState(() {});

                            safeSetState(() {});
                          },
                        ),
                      ),
                      wrapWithModel(
                        model: _model.permissionTileModel3,
                        updateCallback: () => safeSetState(() {}),
                        child: PermissionTileWidget(
                          title: '🧑‍🤝‍🧑 Full Attendee List',
                          description:
                              'Enabling this allows employees to view the entire list of attendees with search functionality.',
                          isCheck: _model.isLookUpCheck,
                          onCheck: (check) async {
                            logFirebaseEvent(
                                'PIN_PERMISSIONS_SCREEN_Container_dam1meb');
                            _model.permissionNumber2 =
                                await actions.updatePermissionBitMask(
                              _model.permissions,
                              AccessPermission.lookup,
                              check,
                            );
                            _model.isLookUpCheck = check;
                            _model.permissions = _model.permissionNumber2!;
                            safeSetState(() {});

                            safeSetState(() {});
                          },
                        ),
                      ),
                      wrapWithModel(
                        model: _model.permissionTileModel4,
                        updateCallback: () => safeSetState(() {}),
                        child: PermissionTileWidget(
                          title: '📈 Statistics',
                          description:
                              'Grants permission to access statistics.',
                          isCheck: _model.isStatCheck,
                          onCheck: (check) async {
                            logFirebaseEvent(
                                'PIN_PERMISSIONS_SCREEN_Container_efabest');
                            _model.permissionNumber3 =
                                await actions.updatePermissionBitMask(
                              _model.permissions,
                              AccessPermission.stats,
                              check,
                            );
                            _model.isStatCheck = check;
                            _model.permissions = _model.permissionNumber3!;
                            safeSetState(() {});

                            safeSetState(() {});
                          },
                        ),
                      ),
                      wrapWithModel(
                        model: _model.permissionTileModel5,
                        updateCallback: () => safeSetState(() {}),
                        child: PermissionTileWidget(
                          title: '⚙️ Settings',
                          description: 'Grants permission to modify settings.',
                          isCheck: _model.isSettingsCheck,
                          onCheck: (check) async {
                            logFirebaseEvent(
                                'PIN_PERMISSIONS_SCREEN_Container_jnl32j9');
                            _model.permissionNumber4 =
                                await actions.updatePermissionBitMask(
                              _model.permissions,
                              AccessPermission.settings,
                              check,
                            );
                            _model.isSettingsCheck = check;
                            _model.permissions = _model.permissionNumber4!;
                            safeSetState(() {});

                            safeSetState(() {});
                          },
                        ),
                      ),
                    ].divide(SizedBox(height: 16.0)),
                  ),
                ),
              ),
              Padding(
                padding:
                     EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FFButtonWidget(
                      onPressed: () async {
                        logFirebaseEvent(
                            'PIN_PERMISSIONS_SCREEN_SAVE_BTN_ON_TAP');
                        if (_model.permissions != _model.pinPermissionNumber) {
                          _model.updatedPinRows = await PinTable().update(
                            data: {
                              'permissions': _model.permissions,
                            },
                            matchingRows: (rows) => rows.eqOrNull(
                              'uid',
                              widget.pin?.uid,
                            ),
                            returnRows: true,
                          );
                          if (widget.isNew) {
                            GoRouter router = GoRouter.of(context);
                            String currentRoute = router.getCurrentLocation();
                            while (router.canPop() &&
                                "PinDetailsScreen" != currentRoute) {
                              currentRoute = router.getCurrentLocation();
                              if ("PinDetailsScreen" != currentRoute) {
                                router.pop();
                              }
                            }
                            context.pushNamed(
                              PinDetailsScreenWidget.routeName,
                              queryParameters: {
                                'pinData': serializeParam(
                                  _model.updatedPinRows?.firstOrNull,
                                  ParamType.SupabaseRow,
                                ),
                                'isNew': serializeParam(
                                  false,
                                  ParamType.bool,
                                ),
                              }.withoutNulls,
                            );
                          } else {
                            context.safePop();
                          }
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
                        padding:  EdgeInsetsDirectional.fromSTEB(
                            0.0, 0.0, 0.0, 0.0),
                        iconPadding:  EdgeInsetsDirectional.fromSTEB(
                            0.0, 0.0, 0.0, 0.0),
                        color: _model.permissions == _model.pinPermissionNumber
                            ? FlutterFlowTheme.of(context).tertiary
                            : FlutterFlowTheme.of(context).success,
                        textStyle:
                            FlutterFlowTheme.of(context).titleSmall.override(
                                  fontFamily: 'MonaSans',
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                ),
                        elevation: 0.0,
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                  ].divide(SizedBox(height: 24.0)),
                ),
              ),
            ].divide(SizedBox(height: 12.0)),
          ),
        ),
      ),
    );
  }
}

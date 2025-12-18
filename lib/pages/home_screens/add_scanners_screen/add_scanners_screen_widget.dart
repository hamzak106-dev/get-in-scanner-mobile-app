import '/backend/supabase/supabase.dart';
import '/components/dialogs/delete_scanner_dialog/delete_scanner_dialog_widget.dart';
import '/components/dialogs/success_dialog/success_dialog_widget.dart';
import '/components/label_text_field/label_text_field_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'add_scanners_screen_model.dart';
export 'add_scanners_screen_model.dart';

class AddScannersScreenWidget extends StatefulWidget {
  const AddScannersScreenWidget({
    super.key,
    this.scanner,
    this.device,
  });

  final PinRow? scanner;
  final DeviceRow? device;

  static String routeName = 'AddScannersScreen';
  static String routePath = '/addScannersScreen';

  @override
  State<AddScannersScreenWidget> createState() =>
      _AddScannersScreenWidgetState();
}

class _AddScannersScreenWidgetState extends State<AddScannersScreenWidget> {
  late AddScannersScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddScannersScreenModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'AddScannersScreen'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('ADD_SCANNERS_SCREEN_AddScannersScreen_ON');
      _model.isAdmin = await actions.isAdminDevice(
        widget.device!.uid,
      );
      _model.isAdminDevice = _model.isAdmin!;
      safeSetState(() {});
    });
  }

  @override
  void dispose() {
    _model.dispose();

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
                            'ADD_SCANNERS_SCREEN_icArrowBack_ICN_ON_T');
                        context.safePop();
                      },
                    ),
                    Expanded(
                      child: Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Text(
                          '${FFAppState().user.user.firstName}\'s Scanner',
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
                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        wrapWithModel(
                          model: _model.nameLabelTextFieldModel,
                          updateCallback: () => safeSetState(() {}),
                          child: LabelTextFieldWidget(
                            initialValue: widget.device?.name,
                            title: 'Name',
                            icon: Icon(
                              FFIcons.kicPerson,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 16.0,
                            ),
                            readOnly: false,
                          ),
                        ),
                        wrapWithModel(
                          model: _model.scannerLabelTextFieldModel,
                          updateCallback: () => safeSetState(() {}),
                          child: LabelTextFieldWidget(
                            initialValue:
                                '${FFAppState().user.user.firstName}\'s Scanner ( ${FFAppState().user.userId.toString()} )',
                            title: 'Scanner Name',
                            icon: Icon(
                              FFIcons.kicScannerRound,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 16.0,
                            ),
                            readOnly: true,
                          ),
                        ),
                        wrapWithModel(
                          model: _model.labelTextFieldModel1,
                          updateCallback: () => safeSetState(() {}),
                          child: LabelTextFieldWidget(
                            initialValue: widget.scanner?.accessCode,
                            title: 'Access Code',
                            icon: Icon(
                              FFIcons.kicAccessCode,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 16.0,
                            ),
                            readOnly: true,
                          ),
                        ),
                        wrapWithModel(
                          model: _model.labelTextFieldModel2,
                          updateCallback: () => safeSetState(() {}),
                          child: LabelTextFieldWidget(
                            initialValue: widget.scanner?.pin.toString(),
                            title: 'Pin',
                            icon: Icon(
                              FFIcons.kicPassword,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 16.0,
                            ),
                            readOnly: true,
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FFButtonWidget(
                              onPressed: () async {
                                logFirebaseEvent(
                                    'ADD_SCANNERS_SCREEN_PAGE_SAVE_BTN_ON_TAP');
                                _model.updatedRow = await DeviceTable().update(
                                  data: {
                                    'name': _model.nameLabelTextFieldModel
                                        .textController.text,
                                  },
                                  matchingRows: (rows) => rows.eqOrNull(
                                    'uid',
                                    widget.device?.uid,
                                  ),
                                  returnRows: true,
                                );
                                if (_model.updatedRow != null &&
                                    (_model.updatedRow)!.isNotEmpty) {
                                  context.safePop();
                                }

                                safeSetState(() {});
                              },
                              text: 'Save',
                              icon: Icon(
                                FFIcons.kicCheck,
                                color: widget.scanner != null
                                    ? FlutterFlowTheme.of(context)
                                        .secondaryBackground
                                    : FlutterFlowTheme.of(context).primaryText,
                                size: 24.0,
                              ),
                              options: FFButtonOptions(
                                width: double.infinity,
                                height: 60.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: widget.scanner != null
                                    ? FlutterFlowTheme.of(context).secondary
                                    : FlutterFlowTheme.of(context).tertiary,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'MonaSans',
                                      color: widget.scanner != null
                                          ? FlutterFlowTheme.of(context)
                                              .secondaryBackground
                                          : FlutterFlowTheme.of(context)
                                              .primaryText,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                    ),
                                elevation: 0.0,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            if ((widget.device?.uid !=
                                    FFAppState().user.deviceId) &&
                                !(widget.device?.isAdmin ?? false))
                              Builder(
                                builder: (context) => FFButtonWidget(
                                  onPressed: () async {
                                    logFirebaseEvent(
                                        'ADD_SCANNERS_SCREEN_DELETE_BTN_ON_TAP');
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
                                            child: DeleteScannerDialogWidget(
                                              title:
                                                  'Delete ${widget.device?.name}',
                                              subTitle:
                                                  'This action cannot be undone. All associated data will be lost.',
                                              firstBtnText: 'Delete',
                                              secondBtnText: 'Cancel',
                                              firstBtnColor:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              secondBtnColor: Color(0x99FFFFFF),
                                            ),
                                          ),
                                        );
                                      },
                                    ).then((value) => safeSetState(
                                        () => _model.deleteDevice = value));

                                    if (_model.deleteDevice!) {
                                      await CheckInLogsTable().delete(
                                        matchingRows: (rows) => rows.eqOrNull(
                                          'device_id',
                                          widget.device?.uid,
                                        ),
                                      );
                                      await DeviceTable().delete(
                                        matchingRows: (rows) => rows.eqOrNull(
                                          'uid',
                                          widget.device?.uid,
                                        ),
                                      );
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
                                                FocusManager
                                                    .instance.primaryFocus
                                                    ?.unfocus();
                                              },
                                              child: SuccessDialogWidget(),
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
                                    FFIcons.kicDelete,
                                    size: 24.0,
                                  ),
                                  options: FFButtonOptions(
                                    width: double.infinity,
                                    height: 60.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: FlutterFlowTheme.of(context).error,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'MonaSans',
                                          color: Colors.white,
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                        ),
                                    elevation: 0.0,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                          ].divide(SizedBox(height: 24.0)),
                        ),
                      ].divide(SizedBox(height: 24.0)),
                    ),
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

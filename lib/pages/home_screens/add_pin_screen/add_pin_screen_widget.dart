import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/components/check_tile/check_tile_widget.dart';
import '/components/dialogs/delete_scanner_dialog/delete_scanner_dialog_widget.dart';
import '/components/dialogs/info_dialog/info_dialog_widget.dart';
import '/components/dialogs/success_dialog/success_dialog_widget.dart';
import '/components/label_text_field/label_text_field_widget.dart';
import '/components/value_generate_text_field/value_generate_text_field_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'add_pin_screen_model.dart';
export 'add_pin_screen_model.dart';

class AddPinScreenWidget extends StatefulWidget {
  const AddPinScreenWidget({
    super.key,
    this.pinData,
    bool? isNew,
  }) : this.isNew = isNew ?? true;

  final PinRow? pinData;
  final bool isNew;

  static String routeName = 'AddPinScreen';
  static String routePath = '/addPinScreen';

  @override
  State<AddPinScreenWidget> createState() => _AddPinScreenWidgetState();
}

class _AddPinScreenWidgetState extends State<AddPinScreenWidget> {
  late AddPinScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddPinScreenModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'AddPinScreen'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('ADD_PIN_SCREEN_AddPinScreen_ON_INIT_STAT');
      _model.permissionsValue =
          !widget.isNew ? widget.pinData!.permissions : 0;
      _model.pLookUp = await actions.isPermissionSelected(
        _model.permissionsValue,
        AccessPermission.lookup,
      );
      _model.pCanView = await actions.isPermissionSelected(
        _model.permissionsValue,
        AccessPermission.canViewList,
      );
      _model.pRequireEvent = await actions.isPermissionSelected(
        _model.permissionsValue,
        AccessPermission.allEvents,
      );
      _model.pManualEntry = await actions.isPermissionSelected(
        _model.permissionsValue,
        AccessPermission.manualEntry,
      );
      _model.pSearch = await actions.isPermissionSelected(
        _model.permissionsValue,
        AccessPermission.searchAttendee,
      );
      _model.pScan = await actions.isPermissionSelected(
        _model.permissionsValue,
        AccessPermission.scan,
      );
      _model.pStats = await actions.isPermissionSelected(
        _model.permissionsValue,
        AccessPermission.stats,
      );
      _model.pSettings = await actions.isPermissionSelected(
        _model.permissionsValue,
        AccessPermission.settings,
      );
      _model.generatedPin =
          !widget.isNew ? widget.pinData?.pin.toString() : null;
      _model.isLookUp = _model.pLookUp!;
      _model.canViewLookUp = _model.pCanView!;
      _model.requireEventLookUp = _model.pRequireEvent!;
      _model.manualEntry = _model.pManualEntry!;
      _model.scanSelected = _model.pScan!;
      _model.statSelected = _model.pStats!;
      _model.searchSelected = _model.pSearch!;
      _model.settingSelected = _model.pSettings!;
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
                            'ADD_PIN_SCREEN_icArrowBack_ICN_ON_TAP');
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
                child: Form(
                  key: _model.formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Padding(
                    padding:  EdgeInsetsDirectional.fromSTEB(
                        20.0, 0.0, 20.0, 20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          wrapWithModel(
                            model: _model.nameLabelTextFieldModel,
                            updateCallback: () => safeSetState(() {}),
                            child: LabelTextFieldWidget(
                              hintText: 'Pin Name',
                              initialValue:
                                  !widget.isNew ? widget.pinData?.name : null,
                              title: 'Pin Name',
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
                            model: _model.labelTextFieldModel,
                            updateCallback: () => safeSetState(() {}),
                            child: LabelTextFieldWidget(
                              initialValue: widget.pinData?.accessCode,
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
                            model: _model.valueGenerateTextFieldModel,
                            updateCallback: () => safeSetState(() {}),
                            child: ValueGenerateTextFieldWidget(
                              hintText: 'Pin',
                              initialValue: !widget.isNew
                                  ? widget.pinData?.pin.toString()
                                  : null,
                              title: 'Pin',
                              icon: Icon(
                                FFIcons.kicPassword,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 16.0,
                              ),
                              readOnly: !widget.isNew,
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Icon(
                                        FFIcons.kicPermission,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 16.0,
                                      ),
                                      Text(
                                        'Permission',
                                        style: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily: 'MonaSans',
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ].divide(SizedBox(width: 8.0)),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      wrapWithModel(
                                        model: _model.checkTileModel1,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: CheckTileWidget(
                                          initialValue: _model.isLookUp,
                                          titleText: 'Lookup Tab',
                                          onCheckChange: (check) async {
                                            logFirebaseEvent(
                                                'ADD_PIN_SCREEN_Container_2vkpn4v8_CALLBA');
                                            _model.updateLookUpPermissionValue =
                                                await actions
                                                    .updatePermissionBitMask(
                                              _model.permissionsValue,
                                              AccessPermission.lookup,
                                              check,
                                            );
                                            _model.permissionsValue = _model
                                                .updateLookUpPermissionValue!;
                                            _model.isLookUp = check;
                                            safeSetState(() {});

                                            safeSetState(() {});
                                          },
                                        ),
                                      ),
                                      if (_model.isLookUp)
                                        Padding(
                                          padding:  EdgeInsetsDirectional
                                              .fromSTEB(28.0, 0.0, 0.0, 0.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              wrapWithModel(
                                                model: _model.checkTileModel2,
                                                updateCallback: () =>
                                                    safeSetState(() {}),
                                                child: CheckTileWidget(
                                                  initialValue:
                                                      _model.isLookUp &&
                                                          _model.canViewLookUp,
                                                  titleText: 'Can view list?',
                                                  hintText:
                                                      'If enabled, employee can view the whole list without searching.',
                                                  onCheckChange: (check) async {
                                                    logFirebaseEvent(
                                                        'ADD_PIN_SCREEN_Container_1gdrco3k_CALLBA');
                                                    _model.updateCanViewPermissionValue =
                                                        await actions
                                                            .updatePermissionBitMask(
                                                      _model.permissionsValue,
                                                      AccessPermission
                                                          .canViewList,
                                                      check,
                                                    );
                                                    _model.permissionsValue = _model
                                                        .updateCanViewPermissionValue!;
                                                    _model.canViewLookUp =
                                                        check;
                                                    safeSetState(() {});
                                                  },
                                                ),
                                              ),
                                              if (false)
                                                wrapWithModel(
                                                  model: _model.checkTileModel3,
                                                  updateCallback: () =>
                                                      safeSetState(() {}),
                                                  child: CheckTileWidget(
                                                    initialValue: _model
                                                        .requireEventLookUp,
                                                    titleText: 'Require event',
                                                    onCheckChange:
                                                        (check) async {
                                                      logFirebaseEvent(
                                                          'ADD_PIN_SCREEN_Container_8eq02ts0_CALLBA');
                                                      _model.updateRequireEventPermissionValue =
                                                          await actions
                                                              .updatePermissionBitMask(
                                                        _model.permissionsValue,
                                                        AccessPermission
                                                            .allEvents,
                                                        check,
                                                      );
                                                      _model.permissionsValue =
                                                          _model
                                                              .updateRequireEventPermissionValue!;
                                                      _model.requireEventLookUp =
                                                          check;
                                                      safeSetState(() {});

                                                      safeSetState(() {});
                                                    },
                                                  ),
                                                ),
                                            ].divide(
                                                SizedBox(height: 8.0)),
                                          ),
                                        ),
                                    ].divide(SizedBox(height: 10.0)),
                                  ),
                                ].divide(SizedBox(height: 16.0)),
                              ),
                              if (false)
                                wrapWithModel(
                                  model: _model.checkTileModel4,
                                  updateCallback: () => safeSetState(() {}),
                                  child: CheckTileWidget(
                                    initialValue: _model.manualEntry,
                                    titleText: 'Manual Entry',
                                    hintText:
                                        'Allows manual ticket entry when QR codes are unavailable, ideal for damaged or missing codes.',
                                    onCheckChange: (check) async {
                                      logFirebaseEvent(
                                          'ADD_PIN_SCREEN_Container_jdenqjn8_CALLBA');
                                      _model.updateManualEntryPermissionValue =
                                          await actions.updatePermissionBitMask(
                                        _model.permissionsValue,
                                        AccessPermission.manualEntry,
                                        check,
                                      );
                                      _model.permissionsValue = _model
                                          .updateManualEntryPermissionValue!;
                                      _model.manualEntry = check;
                                      safeSetState(() {});

                                      safeSetState(() {});
                                    },
                                  ),
                                ),
                              wrapWithModel(
                                model: _model.checkTileModel5,
                                updateCallback: () => safeSetState(() {}),
                                child: CheckTileWidget(
                                  initialValue: _model.searchSelected,
                                  titleText: 'Search Attendee',
                                  onCheckChange: (check) async {
                                    logFirebaseEvent(
                                        'ADD_PIN_SCREEN_Container_pmn4gx04_CALLBA');
                                    _model.updateSearchPermissionValue =
                                        await actions.updatePermissionBitMask(
                                      _model.permissionsValue,
                                      AccessPermission.searchAttendee,
                                      check,
                                    );
                                    _model.permissionsValue =
                                        _model.updateSearchPermissionValue!;
                                    _model.searchSelected = check;
                                    safeSetState(() {});

                                    safeSetState(() {});
                                  },
                                ),
                              ),
                              wrapWithModel(
                                model: _model.checkTileModel6,
                                updateCallback: () => safeSetState(() {}),
                                child: CheckTileWidget(
                                  initialValue: _model.scanSelected,
                                  titleText: 'Scan Tab',
                                  onCheckChange: (check) async {
                                    logFirebaseEvent(
                                        'ADD_PIN_SCREEN_Container_rb85ypk6_CALLBA');
                                    _model.updateScanPermissionValue =
                                        await actions.updatePermissionBitMask(
                                      _model.permissionsValue,
                                      AccessPermission.scan,
                                      check,
                                    );
                                    _model.permissionsValue =
                                        _model.updateScanPermissionValue!;
                                    _model.scanSelected = check;
                                    safeSetState(() {});

                                    safeSetState(() {});
                                  },
                                ),
                              ),
                              wrapWithModel(
                                model: _model.checkTileModel7,
                                updateCallback: () => safeSetState(() {}),
                                child: CheckTileWidget(
                                  initialValue: _model.statSelected,
                                  titleText: 'Stats Tab',
                                  onCheckChange: (check) async {
                                    logFirebaseEvent(
                                        'ADD_PIN_SCREEN_Container_4p4bzkj6_CALLBA');
                                    _model.updateStatsPermissionValue =
                                        await actions.updatePermissionBitMask(
                                      _model.permissionsValue,
                                      AccessPermission.stats,
                                      check,
                                    );
                                    _model.permissionsValue =
                                        _model.updateStatsPermissionValue!;
                                    _model.statSelected = check;
                                    safeSetState(() {});

                                    safeSetState(() {});
                                  },
                                ),
                              ),
                              wrapWithModel(
                                model: _model.checkTileModel8,
                                updateCallback: () => safeSetState(() {}),
                                child: CheckTileWidget(
                                  initialValue: _model.settingSelected,
                                  titleText: 'Settings Tab',
                                  onCheckChange: (check) async {
                                    logFirebaseEvent(
                                        'ADD_PIN_SCREEN_Container_wswzpv8s_CALLBA');
                                    _model.updateSettingPermissionValue =
                                        await actions.updatePermissionBitMask(
                                      _model.permissionsValue,
                                      AccessPermission.settings,
                                      check,
                                    );
                                    _model.permissionsValue =
                                        _model.updateSettingPermissionValue!;
                                    _model.settingSelected = check;
                                    safeSetState(() {});

                                    safeSetState(() {});
                                  },
                                ),
                              ),
                              if (false)
                                wrapWithModel(
                                  model: _model.checkTileModel9,
                                  updateCallback: () => safeSetState(() {}),
                                  child: CheckTileWidget(
                                    initialValue: false,
                                    titleText: 'Auto add to events?',
                                    hintText:
                                        'If enabled, user will be granted permission to all new events automatically.',
                                    onCheckChange: (check) async {},
                                  ),
                                ),
                            ].divide(SizedBox(height: 16.0)),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Builder(
                                builder: (context) => FFButtonWidget(
                                  onPressed: () async {
                                    logFirebaseEvent(
                                        'ADD_PIN_SCREEN_PAGE_SAVE_BTN_ON_TAP');
                                    _model.validInput = true;
                                    if (_model.formKey.currentState == null ||
                                        !_model.formKey.currentState!
                                            .validate()) {
                                      safeSetState(
                                          () => _model.validInput = false);
                                      return;
                                    }
                                    if (_model.permissionsValue > 0) {
                                      _model.pinRows =
                                          await PinTable().queryRows(
                                        queryFn: (q) => q
                                            .eqOrNull(
                                              'access_code',
                                              widget.pinData?.accessCode,
                                            )
                                            .eqOrNull(
                                              'pin',
                                              int.tryParse(_model
                                                  .valueGenerateTextFieldModel
                                                  .textController
                                                  .text),
                                            ),
                                      );
                                      if (!(_model.pinRows != null &&
                                          (_model.pinRows)!.isNotEmpty)) {
                                        _model.addPinResponse =
                                            await PinTable().insert({
                                          'user_id': widget.pinData?.userId,
                                          'access_code':
                                              widget.pinData?.accessCode,
                                          'pin': int.tryParse(_model
                                              .valueGenerateTextFieldModel
                                              .textController
                                              .text),
                                          'type': PinType.ON_SITE_PIN.name,
                                          'permissions':
                                              _model.permissionsValue,
                                          'name': _model.nameLabelTextFieldModel
                                              .textController.text,
                                        });
                                        context.safePop();
                                      } else {
                                        if (widget.isNew) {
                                          await showDialog(
                                            context: context,
                                            builder: (dialogContext) {
                                              return Dialog(
                                                elevation: 0,
                                                insetPadding: EdgeInsets.zero,
                                                backgroundColor:
                                                    Colors.transparent,
                                                alignment: AlignmentDirectional(
                                                        0.0, 0.0)
                                                    .resolve(Directionality.of(
                                                        context)),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    FocusScope.of(dialogContext)
                                                        .unfocus();
                                                    FocusManager
                                                        .instance.primaryFocus
                                                        ?.unfocus();
                                                  },
                                                  child: InfoDialogWidget(
                                                    title: 'Pin Exists',
                                                    subTitle:
                                                        'The PIN already exists. Please use a different PIN.',
                                                    firstBtnText: 'Okay',
                                                    firstBtnColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .accent3,
                                                    firstTap: () async {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        } else {
                                          await PinTable().update(
                                            data: {
                                              'permissions':
                                                  _model.permissionsValue,
                                              'name': _model
                                                  .nameLabelTextFieldModel
                                                  .textController
                                                  .text,
                                            },
                                            matchingRows: (rows) =>
                                                rows.eqOrNull(
                                              'uid',
                                              widget.pinData?.uid,
                                            ),
                                          );
                                          context.safePop();
                                        }
                                      }
                                    } else {
                                      await showDialog(
                                        context: context,
                                        builder: (dialogContext) {
                                          return Dialog(
                                            elevation: 0,
                                            insetPadding: EdgeInsets.zero,
                                            backgroundColor: Colors.transparent,
                                            alignment:
                                                 AlignmentDirectional(
                                                        0.0, 0.0)
                                                    .resolve(Directionality.of(
                                                        context)),
                                            child: GestureDetector(
                                              onTap: () {
                                                FocusScope.of(dialogContext)
                                                    .unfocus();
                                                FocusManager
                                                    .instance.primaryFocus
                                                    ?.unfocus();
                                              },
                                              child: InfoDialogWidget(
                                                title: 'Permission Needed',
                                                subTitle:
                                                    'Permission required to proceed. Please grant the necessary access. ',
                                                firstBtnText: 'Okay',
                                                firstBtnColor:
                                                    FlutterFlowTheme.of(context)
                                                        .accent3,
                                                firstTap: () async {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }

                                    safeSetState(() {});
                                  },
                                  text: 'Save',
                                  icon: Icon(
                                    FFIcons.kicCheck,
                                    color: widget.pinData != null
                                        ? FlutterFlowTheme.of(context)
                                            .secondaryBackground
                                        : FlutterFlowTheme.of(context)
                                            .primaryText,
                                    size: 24.0,
                                  ),
                                  options: FFButtonOptions(
                                    width: double.infinity,
                                    height: 60.0,
                                    padding:
                                         EdgeInsetsDirectional.fromSTEB(
                                            16.0, 0.0, 16.0, 0.0),
                                    iconPadding:
                                         EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 0.0),
                                    color: widget.pinData != null
                                        ? FlutterFlowTheme.of(context).secondary
                                        : FlutterFlowTheme.of(context).tertiary,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'MonaSans',
                                          color: widget.pinData != null
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
                              ),
                              if (!widget.isNew)
                                Builder(
                                  builder: (context) => FFButtonWidget(
                                    onPressed: () async {
                                      logFirebaseEvent(
                                          'ADD_PIN_SCREEN_PAGE_DELETE_BTN_ON_TAP');
                                      await showDialog(
                                        context: context,
                                        builder: (dialogContext) {
                                          return Dialog(
                                            elevation: 0,
                                            insetPadding: EdgeInsets.zero,
                                            backgroundColor: Colors.transparent,
                                            alignment:
                                                 AlignmentDirectional(
                                                        0.0, 0.0)
                                                    .resolve(Directionality.of(
                                                        context)),
                                            child: GestureDetector(
                                              onTap: () {
                                                FocusScope.of(dialogContext)
                                                    .unfocus();
                                                FocusManager
                                                    .instance.primaryFocus
                                                    ?.unfocus();
                                              },
                                              child: DeleteScannerDialogWidget(
                                                title:
                                                    'Delete ${widget.pinData?.name}',
                                                subTitle:
                                                    'This action cannot be undone. All associated data will be lost.',
                                                firstBtnText: 'Delete',
                                                secondBtnText: 'Cancel',
                                                firstBtnColor:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                secondBtnColor:
                                                    Color(0x99FFFFFF),
                                              ),
                                            ),
                                          );
                                        },
                                      ).then((value) => safeSetState(
                                          () => _model.deletePin = value));

                                      if (_model.deletePin!) {
                                        _model.availablePins =
                                            await DeviceTable().queryRows(
                                          queryFn: (q) => q.eqOrNull(
                                            'pin_id',
                                            widget.pinData?.uid,
                                          ),
                                        );
                                        _model.devices = _model.availablePins!
                                            .toList()
                                            .cast<DeviceRow>();
                                        while (_model.devices.isNotEmpty) {
                                          await CheckInLogsTable().delete(
                                            matchingRows: (rows) =>
                                                rows.eqOrNull(
                                              'device_id',
                                              _model.devices.firstOrNull?.uid,
                                            ),
                                          );
                                          await DeviceTable().delete(
                                            matchingRows: (rows) =>
                                                rows.eqOrNull(
                                              'uid',
                                              _model.devices.firstOrNull?.uid,
                                            ),
                                          );
                                          _model.removeFromDevices(
                                              _model.devices.firstOrNull!);
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
                                              backgroundColor:
                                                  Colors.transparent,
                                              alignment:
                                                  AlignmentDirectional(
                                                          0.0, 0.0)
                                                      .resolve(
                                                          Directionality.of(
                                                              context)),
                                              child: GestureDetector(
                                                onTap: () {
                                                  FocusScope.of(dialogContext)
                                                      .unfocus();
                                                  FocusManager
                                                      .instance.primaryFocus
                                                      ?.unfocus();
                                                },
                                                child:
                                                     SuccessDialogWidget(
                                                  title: 'Pin Deleted',
                                                  subTitle:
                                                      'The pin has been successfully removed.',
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
                                      FFIcons.kicDelete,
                                      size: 24.0,
                                    ),
                                    options: FFButtonOptions(
                                      width: double.infinity,
                                      height: 60.0,
                                      padding:
                                           EdgeInsetsDirectional.fromSTEB(
                                              16.0, 0.0, 16.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
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
              ),
            ].divide(SizedBox(height: 8.0)),
          ),
        ),
      ),
    );
  }
}

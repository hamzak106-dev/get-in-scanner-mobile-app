import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/components/dialogs/info_dialog/info_dialog_widget.dart';
import '/components/info_text_field/info_text_field_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'pin_info_screen_model.dart';
export 'pin_info_screen_model.dart';

class PinInfoScreenWidget extends StatefulWidget {
  const PinInfoScreenWidget({
    super.key,
    this.pin,
    bool? isNew,
  }) : this.isNew = isNew ?? false;

  final PinRow? pin;
  final bool isNew;

  static String routeName = 'PinInfoScreen';
  static String routePath = '/pinInfoScreen';

  @override
  State<PinInfoScreenWidget> createState() => _PinInfoScreenWidgetState();
}

class _PinInfoScreenWidgetState extends State<PinInfoScreenWidget> {
  late PinInfoScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PinInfoScreenModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'PinInfoScreen'});
    _model.codeInfoTextFieldTextController ??= TextEditingController(
        text: widget.isNew ? null : widget.pin?.pin.toString());
    _model.codeInfoTextFieldFocusNode ??= FocusNode();
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
                            'PIN_INFO_SCREEN_icArrowBack_ICN_ON_TAP');
                        context.safePop();
                      },
                    ),
                    Expanded(
                      child: Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Text(
                          'Info',
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
                          model: _model.nameInfoTextFieldModel,
                          updateCallback: () => safeSetState(() {}),
                          child: InfoTextFieldWidget(
                            hintText: 'Name',
                            initialValue:
                                !widget.isNew ? widget.pin?.name : null,
                            info:
                                'This is how you identify the user or entity linked to the event or system.',
                            icon: Icon(
                              FFIcons.kicPerson,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 16.0,
                            ),
                            readOnly: false,
                            hasGenerator: false,
                          ),
                        ),
                        wrapWithModel(
                          model: _model.scannerNameInfoTextFieldModel,
                          updateCallback: () => safeSetState(() {}),
                          child: InfoTextFieldWidget(
                            hintText: 'Scanner Name',
                            initialValue:
                                '${FFAppState().user.user.firstName}\'s Scanner ( ${FFAppState().user.userId.toString()} )',
                            info:
                                'A system-generated name assigned to the device or tool for scanning tickets or verifying access.',
                            icon: Icon(
                              FFIcons.kicScannerRound,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 16.0,
                            ),
                            readOnly: true,
                          ),
                        ),
                        wrapWithModel(
                          model: _model.accessCodeInfoTextFieldModel,
                          updateCallback: () => safeSetState(() {}),
                          child: InfoTextFieldWidget(
                            hintText: 'Access Code',
                            initialValue: widget.pin?.accessCode,
                            info:
                                'A secure, unique generated code to grant entry to specific events or resources.',
                            icon: Icon(
                              FFIcons.kicAccessCode,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 16.0,
                            ),
                            readOnly: true,
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              alignment: AlignmentDirectional(1.0, 0.0),
                              children: [
                                TextFormField(
                                  controller:
                                      _model.codeInfoTextFieldTextController,
                                  focusNode: _model.codeInfoTextFieldFocusNode,
                                  autofocus: false,
                                  readOnly: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    isDense: false,
                                    hintText: 'Pin',
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'MonaSans',
                                          letterSpacing: 0.0,
                                        ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .tertiary,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    filled: true,
                                    fillColor: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    contentPadding: EdgeInsets.all(8.0),
                                    prefixIcon: Icon(
                                      FFIcons.kicPassword,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 16.0,
                                    ),
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'MonaSans',
                                        letterSpacing: 0.0,
                                      ),
                                  maxLength: 4,
                                  maxLengthEnforcement:
                                      MaxLengthEnforcement.enforced,
                                  buildCounter: (context,
                                          {required currentLength,
                                          required isFocused,
                                          maxLength}) =>
                                      null,
                                  keyboardType: TextInputType.phone,
                                  cursorColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  validator: _model
                                      .codeInfoTextFieldTextControllerValidator
                                      .asValidator(context),
                                ),
                                if (widget.isNew)
                                  Padding(
                                    padding:
                                         EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 16.0, 0.0),
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        logFirebaseEvent(
                                            'PIN_INFO_SCREEN_PAGE_GENERATE_BTN_ON_TAP');
                                        _model.code =
                                            await actions.generateCode();
                                        safeSetState(() {
                                          _model.codeInfoTextFieldTextController
                                              ?.text = _model.code!;
                                        });

                                        safeSetState(() {});
                                      },
                                      text: 'Generate',
                                      options: FFButtonOptions(
                                        height: 32.0,
                                        padding: EdgeInsetsDirectional
                                            .fromSTEB(16.0, 0.0, 16.0, 0.0),
                                        iconPadding:  EdgeInsetsDirectional
                                            .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                        color: FlutterFlowTheme.of(context)
                                            .secondary,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily: 'MonaSans',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                              fontSize: 14.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                        elevation: 0.0,
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            Text(
                              'A 4 Digit generated pin used to confirm your identity.',
                              style: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'MonaSans',
                                    color: Color(0xFFB5B6BA),
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ].divide(SizedBox(height: 8.0)),
                        ),
                      ].divide(SizedBox(height: 24.0)),
                    ),
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
                    Builder(
                      builder: (context) => FFButtonWidget(
                        onPressed: () async {
                          logFirebaseEvent(
                              'PIN_INFO_SCREEN_PAGE_SAVE_BTN_ON_TAP');
                          if ((_model.nameInfoTextFieldModel.textController
                                          .text !=
                                      '') &&
                              (_model.codeInfoTextFieldTextController.text !=
                                      '')) {
                            if (widget.isNew) {
                              _model.existingPins = await PinTable().queryRows(
                                queryFn: (q) => q
                                    .eqOrNull(
                                      'access_code',
                                      widget.pin?.accessCode,
                                    )
                                    .eqOrNull(
                                      'pin',
                                      int.tryParse(_model
                                          .codeInfoTextFieldTextController
                                          .text),
                                    ),
                              );
                              if (_model.existingPins != null &&
                                  (_model.existingPins)!.isNotEmpty) {
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
                                          title: 'Pin exists',
                                          subTitle:
                                              'Selected pin already exist, Please choose different one.',
                                          firstBtnText: 'OK',
                                          firstBtnColor:
                                              FlutterFlowTheme.of(context)
                                                  .accent3,
                                          isLight: true,
                                          firstTap: () async {
                                            context.safePop();
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else {
                                _model.addPinResponse =
                                    await PinTable().insert({
                                  'user_id': widget.pin?.userId,
                                  'access_code': widget.pin?.accessCode,
                                  'pin': int.tryParse(_model
                                      .codeInfoTextFieldTextController.text),
                                  'type': PinType.ON_SITE_PIN.name,
                                  'permissions': 0,
                                  'name': _model.nameInfoTextFieldModel
                                      .textController.text,
                                });

                                context.pushNamed(
                                  PinEventsScreenWidget.routeName,
                                  queryParameters: {
                                    'pin': serializeParam(
                                      _model.addPinResponse,
                                      ParamType.SupabaseRow,
                                    ),
                                    'isNew': serializeParam(
                                      true,
                                      ParamType.bool,
                                    ),
                                  }.withoutNulls,
                                );
                              }
                            } else {
                              _model.updatedRow = await PinTable().update(
                                data: {
                                  'name': _model.nameInfoTextFieldModel
                                      .textController.text,
                                },
                                matchingRows: (rows) => rows.eqOrNull(
                                  'uid',
                                  widget.pin?.uid,
                                ),
                                returnRows: true,
                              );
                              if (_model.updatedRow != null &&
                                  (_model.updatedRow)!.isNotEmpty) {
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
                                  alignment: AlignmentDirectional(0.0, 0.0)
                                      .resolve(Directionality.of(context)),
                                  child: GestureDetector(
                                    onTap: () {
                                      FocusScope.of(dialogContext).unfocus();
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                    },
                                    child: InfoDialogWidget(
                                      title: 'Pin Info Alert',
                                      subTitle: () {
                                        if (_model.nameInfoTextFieldModel
                                                    .textController.text ==
                                                '') {
                                          return 'Please enter name.';
                                        } else if (_model.codeInfoTextFieldTextController
                                                    .text ==
                                                '') {
                                          return 'Please generate pin code.';
                                        } else {
                                          return 'Name and Code are required. Please enter them.';
                                        }
                                      }(),
                                      firstBtnText: 'OK',
                                      firstBtnColor:
                                          FlutterFlowTheme.of(context).accent3,
                                      isLight: true,
                                      firstTap: () async {
                                        context.safePop();
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
                          FFIcons.kicCheckCircle,
                          color: FlutterFlowTheme.of(context).primaryBackground,
                          size: 16.0,
                        ),
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 52.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).success,
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

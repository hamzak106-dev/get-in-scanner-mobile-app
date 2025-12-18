import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:g_e_t_i_n_scanner/flutter_flow/flutter_flow_icon_button.dart';
import 'package:provider/provider.dart';

import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/components/custom_button/custom_button_widget.dart';
import '/components/simple_text_field/simple_text_field_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '../../home_screens/dash_board_screen/dash_board_screen_widget.dart';
import 'passkey_login_screen_model.dart';

export 'passkey_login_screen_model.dart';

class PasskeyLoginScreenWidget extends StatefulWidget {
  const PasskeyLoginScreenWidget({super.key});

  static String routeName = 'PasskeyLoginScreen';
  static String routePath = '/passkeyLoginScreen';

  @override
  State<PasskeyLoginScreenWidget> createState() =>
      _PasskeyLoginScreenWidgetState();
}

class _PasskeyLoginScreenWidgetState extends State<PasskeyLoginScreenWidget> {
  late PasskeyLoginScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PasskeyLoginScreenModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'PasskeyLoginScreen'});
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
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          elevation: 0,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            buttonSize: 40.0,
            icon: Icon(
              FFIcons.kicArrowBack,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 24.0,
            ),
            onPressed: () {
              context.safePop();
            },
          ),
        ),
        body: SafeArea(
          top: true,
          child: Align(
            alignment: const AlignmentDirectional(0.0, 0.0),
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 54.0),
                      child: SvgPicture.asset(
                        'assets/images/img_name_logo.svg',
                        height: 72.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            wrapWithModel(
                              model: _model.simpleTextFieldModel,
                              updateCallback: () => safeSetState(() {}),
                              child: const SimpleTextFieldWidget(
                                hintText: 'Login with the Access Code',
                              ),
                            ),
                            if (_model.accessCodeError != null &&
                                _model.accessCodeError != '')
                              Text(
                                _model.accessCodeError!,
                                style: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .override(
                                      fontFamily: 'MonaSans',
                                      color: FlutterFlowTheme.of(context).error,
                                      letterSpacing: 0.0,
                                    ),
                              ),
                          ].divide(const SizedBox(height: 4.0)),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            custom_widgets.PasswordTextFieldWidget(
                              width: double.infinity,
                              height: 60.0,
                              hintText: 'Password',
                              onChange: (value) async {
                                logFirebaseEvent(
                                    'PASSKEY_LOGIN_SCREEN_Container_ovvyg8mv_');
                                _model.password = value;
                                safeSetState(() {});
                              },
                            ),
                            if (_model.passwordError != null &&
                                _model.passwordError != '')
                              Text(
                                _model.passwordError!,
                                style: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .override(
                                      fontFamily: 'MonaSans',
                                      color: FlutterFlowTheme.of(context).error,
                                      letterSpacing: 0.0,
                                    ),
                              ),
                          ].divide(const SizedBox(height: 4.0)),
                        ),
                      ].divide(const SizedBox(height: 16.0)),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 20.0, 0.0, 0.0),
                      child: wrapWithModel(
                        model: _model.customButtonModel,
                        updateCallback: () => safeSetState(() {}),
                        child: CustomButtonWidget(
                            title: 'Submit',
                            onTap: () async {
                              logFirebaseEvent(
                                  'PASSKEY_LOGIN_SCREEN_Container_p77oat6y_');
                              _model.accessCodeError = _model
                                          .simpleTextFieldModel
                                          .textController
                                          .text !=
                                      ''
                                  ? null
                                  : 'Please enter a access code.';
                              _model.passwordError = () {
                                if (_model.password != null &&
                                    _model.password != '') {
                                  return null;
                                } else if (!FFAppState().isOnline) {
                                  return 'No internet connection.';
                                } else {
                                  return 'Please enter a password.';
                                }
                              }();
                              safeSetState(() {});
                              if ((_model.passwordError == null ||
                                      _model.passwordError == '') &&
                                  (_model.accessCodeError == null ||
                                      _model.accessCodeError == '')) {
                                _model.pinResponse = await PinTable().queryRows(
                                  queryFn: (q) => q.eqOrNull(
                                    'access_code',
                                    _model.simpleTextFieldModel.textController
                                        .text
                                        .trim(),
                                  ),
                                );
                                if (!(_model.pinResponse != null &&
                                    (_model.pinResponse)!.isNotEmpty)) {
                                  _model.accessCodeError =
                                      'Access code is unavailable. Please enter a valid code.';
                                  safeSetState(() {});
                                } else if ((_model.pinResponse != null &&
                                    (_model.pinResponse)!.isNotEmpty)) {
                                  var pin = _model.pinResponse!
                                      .where((e) =>
                                          e.pin ==
                                          (int.tryParse(valueOrDefault<String>(
                                            _model.password,
                                            '0',
                                          ))))
                                      .firstOrNull;

                                  if (pin?.isEnable ?? false) {
                                    _model.version =
                                        await actions.getAppVersionName();
                                    _model.checkDeviceResponse =
                                        await DeviceTable().queryRows(
                                      queryFn: (q) => q
                                          .eqOrNull(
                                            'pin_id',
                                            pin?.uid,
                                          )
                                          .eqOrNull(
                                            'device_id',
                                            FFAppState().uuid,
                                          )
                                          .eqOrNull(
                                            'isAdmin',
                                            false,
                                          ),
                                    );
                                    if (_model.checkDeviceResponse != null &&
                                        (_model.checkDeviceResponse)!
                                            .isNotEmpty) {
                                      _model.deviceId = _model
                                          .checkDeviceResponse
                                          ?.firstOrNull
                                          ?.uid;
                                      await DeviceTable().update(
                                        data: {
                                          'version': _model.version,
                                          'isAdmin': false,
                                          'user_id': _model
                                              .pinResponse?.firstOrNull?.userId
                                        },
                                        matchingRows: (rows) => rows.eqOrNull(
                                          'uid',
                                          _model.checkDeviceResponse
                                              ?.firstOrNull?.uid,
                                        ),
                                      );
                                    } else {
                                      _model.newDeviceData =
                                          await DeviceTable().insert({
                                        'pin_id': pin?.uid,
                                        'version': _model.version,
                                        'name': FFAppState().deviceName,
                                        'device_id': FFAppState().uuid,
                                        'isAdmin': false,
                                        'user_id': _model
                                            .pinResponse?.firstOrNull?.userId
                                      });
                                      _model.deviceId =
                                          _model.newDeviceData?.uid;
                                      safeSetState(() {});
                                    }

                                    _model.pinAssignedEventIds =
                                        await actions.getPinEventIds(
                                      pin!.uid,
                                    );
                                    FFAppState().user = LoggedInModelStruct(
                                      userId: pin.userId,
                                      profile: Profile.scanner,
                                      type: pin.type,
                                      deviceId: _model.deviceId,
                                      pinId: pin.uid,
                                      permissions: valueOrDefault<int>(
                                          pin.permissions, 0),
                                      pinType: pin.type,
                                      eventIds: _model.pinAssignedEventIds,
                                    );
                                    safeSetState(() {});
                                    await actions.supabaseLogin();

                                    context.goNamed(
                                        DashBoardScreenWidget.routeName);
                                  } else {
                                    _model.passwordError =
                                        'Incorrect password! Please enter a valid password.';
                                    safeSetState(() {});
                                  }
                                }

                                safeSetState(() {});
                              }
                            }),
                      ),
                    ),
                  ]
                      .divide(const SizedBox(height: 20.0))
                      .addToStart(const SizedBox(height: 8.0))
                      .addToEnd(const SizedBox(height: 8.0)),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

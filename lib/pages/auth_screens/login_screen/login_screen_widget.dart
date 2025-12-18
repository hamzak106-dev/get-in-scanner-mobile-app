import 'package:g_e_t_i_n_scanner/flutter_flow/flutter_flow_icon_button.dart';

import '../../../config/flavor_helper.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/enums/enums.dart';
import '/components/custom_button/custom_button_widget.dart';
import '/components/simple_text_field/simple_text_field_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/backend/schema/structs/index.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'login_screen_model.dart';
export 'login_screen_model.dart';

class LoginScreenWidget extends StatefulWidget {
  const LoginScreenWidget({super.key});

  static String routeName = 'LoginScreen';
  static String routePath = '/loginScreen';

  @override
  State<LoginScreenWidget> createState() => _LoginScreenWidgetState();
}

class _LoginScreenWidgetState extends State<LoginScreenWidget> {
  late LoginScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoginScreenModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'LoginScreen'});
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
            onPressed: (){
              context.safePop();
            },
          ),
        ),
        body: SafeArea(
          top: true,
          child: Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Padding(
              padding: EdgeInsets.all(28.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding:  EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 54.0),
                      child: SvgPicture.asset(
                        'assets/images/img_name_logo.svg',
                        height: 72.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      'Enter your ${_model.loginWith == LoginWith.email ? 'email' : 'phone number'} and we\'ll send you a code.',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'MonaSans',
                            letterSpacing: 0.0,
                          ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Builder(
                          builder: (context) {
                            if (_model.loginWith == LoginWith.email) {
                              return wrapWithModel(
                                model: _model.simpleTextFieldModel,
                                updateCallback: () => safeSetState(() {}),
                                child: SimpleTextFieldWidget(
                                  hintText: 'Email',
                                ),
                              );
                            } else {
                              return custom_widgets.MobileNumberTextFieldWidget(
                                width: double.infinity,
                                height: 60.0,
                                hintText: 'Phone number',
                                phoneNumber: '',
                                onChange:
                                    (countryCode, phoneNumber, dialCode) async {
                                  logFirebaseEvent(
                                      'LOGIN_SCREEN_Container_ue6g0buq_CALLBACK');
                                  _model.phoneNumber = phoneNumber;
                                  _model.countryCode = countryCode;
                                  _model.dialCode = dialCode;
                                },
                              );
                            }
                          },
                        ),
                        if (_model.errorText != null && _model.errorText != '')
                          Text(
                            _model.errorText!,
                            style:
                                FlutterFlowTheme.of(context).bodySmall.override(
                                      fontFamily: 'MonaSans',
                                      color: FlutterFlowTheme.of(context).error,
                                      letterSpacing: 0.0,
                                    ),
                          ),
                      ].divide(SizedBox(height: 4.0)),
                    ),
                    wrapWithModel(
                      model: _model.customButtonModel,
                      updateCallback: () => safeSetState(() {}),
                      child: CustomButtonWidget(
                        title: 'Submit',
                        onTap: () async {
                          logFirebaseEvent(
                              'LOGIN_SCREEN_Container_o4nd3nzn_CALLBACK');
                          var _shouldSetState = false;
                          if (_model.loginWith == LoginWith.email) {
                            if (functions.emailValidation(_model
                                .simpleTextFieldModel.textController.text)) {
                              _model.errorText = null;
                              safeSetState(() {});
                            } else {
                              _model.errorText = _model
                                  .simpleTextFieldModel.textController.text.isEmpty? 'The email field is required' : 'Please enter valid email.';
                              safeSetState(() {});
                              if (_shouldSetState) safeSetState(() {});
                              return;
                            }
                          } else if (_model.phoneNumber == null ||
                              _model.phoneNumber == '') {
                            _model.errorText =
                                'The phone number field is required';
                            safeSetState(() {});
                            if (_shouldSetState) safeSetState(() {});
                            return;
                          } else if (!FFAppState().isOnline) {
                            _model.errorText = 'No internet connection.';
                            safeSetState(() {});
                            if (_shouldSetState) safeSetState(() {});
                            return;
                          } else {
                            _model.errorText = null;
                            safeSetState(() {});
                          }

                          _model.checkToken =
                              await actions.getFBAppCheckToken();
                          _shouldSetState = true;
                          _model.checkResponse =
                              await GetInAuthGroup.checkVFiveCall.call(
                            phoneEmail: _model.loginWith == LoginWith.email
                                ? _model
                                    .simpleTextFieldModel.textController.text
                                : '${_model.dialCode}${_model.phoneNumber}',
                            phoneCountryCode: _model.countryCode,
                            firebaseAuthToken: _model.checkToken,
                            apiBaseURL: FlavorHelper.appFlavor.getInAppBaseUrl,
                            scannerApiKey: FlavorHelper.appFlavor.scannerApiKey,
                            apiVersion: FlavorHelper.appFlavor.apiVersion,
                          );

                          await actions.printData(
                            (_model.checkResponse?.jsonBody ?? '').toString(),
                          );

                          _shouldSetState = true;
                          if ((_model.checkResponse?.succeeded ?? false) &&
                              ((CheckResponseModelStruct.maybeFromMap((_model
                                                      .checkResponse
                                                      ?.jsonBody ??
                                                  ''))
                                              ?.original
                                              .error ==
                                          null ||
                                      CheckResponseModelStruct.maybeFromMap(
                                                  (_model.checkResponse
                                                          ?.jsonBody ??
                                                      ''))
                                              ?.original
                                              .error ==
                                          '') ||
                                  (CheckResponseModelStruct.maybeFromMap(
                                              (_model.checkResponse?.jsonBody ??
                                                  ''))
                                          ?.original
                                          .error ==
                                      '0'))) {
                            context.pushNamed(
                              OtpScreenWidget.routeName,
                              queryParameters: {
                                'token': serializeParam(
                                  CheckResponseModelStruct.maybeFromMap(
                                          (_model.checkResponse?.jsonBody ??
                                              ''))
                                      ?.original
                                      .csrfToken,
                                  ParamType.String,
                                ),
                                'phoneEmail': serializeParam(
                                  _model.loginWith == LoginWith.email
                                      ? _model.simpleTextFieldModel
                                          .textController.text
                                      : '${_model.dialCode}${_model.phoneNumber}',
                                  ParamType.String,
                                ),
                                'otp': serializeParam(
                                  CheckResponseModelStruct.maybeFromMap(
                                          (_model.checkResponse?.jsonBody ??
                                              ''))
                                      ?.original
                                      .token,
                                  ParamType.String,
                                ),
                                'countryCode': serializeParam(
                                  _model.countryCode,
                                  ParamType.String,
                                ),
                                'firebaseToken': serializeParam(
                                  _model.checkToken,
                                  ParamType.String,
                                ),
                              }.withoutNulls,
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  () {
                                    if (CheckResponseModelStruct.maybeFromMap((_model.checkResponse?.jsonBody ?? ''))
                                            ?.original
                                            .error ==
                                        '3.1') {
                                      return 'Email / Phone not found';
                                    } else if (CheckResponseModelStruct.maybeFromMap((_model.checkResponse?.jsonBody ?? ''))
                                            ?.original
                                            .error ==
                                        '3.2') {
                                      return 'Email / Phone not found';
                                    } else if (CheckResponseModelStruct.maybeFromMap((_model.checkResponse?.jsonBody ?? ''))
                                            ?.original
                                            .error ==
                                        '36') {
                                      return 'Problem create OTP';
                                    } else if (CheckResponseModelStruct.maybeFromMap((_model.checkResponse?.jsonBody ?? ''))
                                            ?.original
                                            .error ==
                                        '37') {
                                      return 'OTP code wait. you can send 1 time at minute.';
                                    } else if (CheckResponseModelStruct.maybeFromMap((_model.checkResponse?.jsonBody ?? ''))
                                            ?.original
                                            .error ==
                                        '40') {
                                      return 'Problem with create auth token';
                                    } else if (CheckResponseModelStruct.maybeFromMap((_model.checkResponse?.jsonBody ?? ''))
                                            ?.original
                                            .error ==
                                        '41') {
                                      return 'Many requests. you can try again after 1 hour';
                                    } else if (CheckResponseModelStruct.maybeFromMap((_model.checkResponse?.jsonBody ?? ''))
                                            ?.original
                                            .error ==
                                        '42') {
                                      return 'Problem verify captcha';
                                    } else if (CheckResponseModelStruct.maybeFromMap((_model.checkResponse?.jsonBody ?? ''))
                                            ?.original
                                            .error ==
                                        '43') {
                                      return 'Email / Phone in black list';
                                    } else if (CheckResponseModelStruct.maybeFromMap(
                                                (_model.checkResponse?.jsonBody ?? ''))
                                            ?.original
                                            .error ==
                                        '44') {
                                      return 'Problem in sending email or sms';
                                    } else if (CheckResponseModelStruct.maybeFromMap((_model.checkResponse?.jsonBody ?? ''))?.original.error == '45') {
                                      return 'We are unable to send SMS or Email to this account';
                                    } else if (CheckResponseModelStruct.maybeFromMap((_model.checkResponse?.jsonBody ?? ''))?.original.error == '53') {
                                      return 'Captcha code low';
                                    } else if (CheckResponseModelStruct.maybeFromMap((_model.checkResponse?.jsonBody ?? ''))?.original.error == '59') {
                                      return 'Problem send SMS to Phone';
                                    } else if (CheckResponseModelStruct.maybeFromMap((_model.checkResponse?.jsonBody ?? ''))?.original.error == '60') {
                                      return 'You do not have access to this platform';
                                    } else {
                                      return 'Unknown error from our end';
                                    }
                                  }(),
                                  style: TextStyle(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                  ),
                                ),
                                duration: Duration(milliseconds: 4000),
                                backgroundColor:
                                    FlutterFlowTheme.of(context).primary,
                              ),
                            );
                          }

                          if (_shouldSetState) safeSetState(() {});
                        },
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Divider(
                                thickness: 2.0,
                                color: FlutterFlowTheme.of(context).accent2,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'or',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'MonaSans',
                                    letterSpacing: 0.0,
                                  ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Divider(
                                thickness: 2.0,
                                color: FlutterFlowTheme.of(context).accent2,
                              ),
                            ],
                          ),
                        ),
                      ]
                          .divide(SizedBox(width: 20.0))
                          .addToStart(SizedBox(width: 20.0))
                          .addToEnd(SizedBox(width: 20.0)),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        logFirebaseEvent(
                            'LOGIN_SCREEN_PAGE_Text_fz2r0fkz_ON_TAP');
                        _model.loginWith = _model.loginWith == LoginWith.email
                            ? LoginWith.phone
                            : LoginWith.email;
                        _model.errorText = null;
                        safeSetState(() {});
                      },
                      child: Text(
                        _model.loginWith == LoginWith.email
                            ? 'Continue with phone'
                            : 'Continue with email',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'MonaSans',
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ]
                      .divide(SizedBox(height: 20.0))
                      .addToStart(SizedBox(height: 8.0))
                      .addToEnd(SizedBox(height: 8.0)),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

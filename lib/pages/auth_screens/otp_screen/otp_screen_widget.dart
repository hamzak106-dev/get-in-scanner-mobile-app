import 'package:g_e_t_i_n_scanner/flutter_flow/flutter_flow_icon_button.dart';

import '../../../config/flavor_helper.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/components/custom_button/custom_button_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'otp_screen_model.dart';
export 'otp_screen_model.dart';

class OtpScreenWidget extends StatefulWidget {
  const OtpScreenWidget({
    super.key,
    required this.token,
    required this.phoneEmail,
    required this.otp,
    required this.countryCode,
    required this.firebaseToken,
  });

  final String? token;
  final String? phoneEmail;
  final String? otp;
  final String? countryCode;
  final String? firebaseToken;

  static String routeName = 'OtpScreen';
  static String routePath = '/otpScreen';

  @override
  State<OtpScreenWidget> createState() => _OtpScreenWidgetState();
}

class _OtpScreenWidgetState extends State<OtpScreenWidget> {
  late OtpScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OtpScreenModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'OtpScreen'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('OTP_SCREEN_PAGE_OtpScreen_ON_INIT_STATE');
      _model.timerController.onStartTimer();
      if (widget.phoneEmail == 'demo@get-in.com') {
        safeSetState(() {
          _model.pinCodeController?.text = widget.otp!;
        });
        await actions.unfocusFields(
          context,
        );
      }
    });

    _model.pinCodeFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
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
                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 54.0),
                      child: SvgPicture.asset(
                        'assets/images/img_name_logo.svg',
                        height: 72.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      'OTP Verification',
                      style: FlutterFlowTheme.of(context).titleLarge.override(
                            fontFamily: 'MonaSans',
                            letterSpacing: 0.0,
                          ),
                    ),
                    RichText(
                      textScaler: MediaQuery.of(context).textScaler,
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Enter the Code Sent to\n',
                            style: TextStyle(),
                          ),
                          TextSpan(
                            text: widget.phoneEmail!,
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'MonaSans',
                                  letterSpacing: 0.4,
                                  fontWeight: FontWeight.w600,
                                ),
                          )
                        ],
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'MonaSans',
                              letterSpacing: 0.4,
                            ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    if(FlavorHelper.devFlavor)
                    RichText(
                      textScaler: MediaQuery.of(context).textScaler,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'For Stage use Code: ${widget.otp!}',
                            style: TextStyle(
                              fontSize: 12
                            ),
                          ),
                        ],
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'MonaSans',
                          letterSpacing: 0.4,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    PinCodeTextField(
                      autoDisposeControllers: false,
                      appContext: context,
                      length: 6,
                      textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'MonaSans',
                            letterSpacing: 0.0,
                          ),
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      enableActiveFill: false,
                      autoFocus: true,
                      focusNode: _model.pinCodeFocusNode,
                      enablePinAutofill: false,
                      errorTextSpace: 16.0,
                      showCursor: true,
                      cursorColor: FlutterFlowTheme.of(context).secondary,
                      obscureText: false,
                      hintCharacter: '●',
                      keyboardType: TextInputType.number,
                      pinTheme: PinTheme(
                        fieldHeight: 60.0,
                        fieldWidth: 50.0,
                        borderWidth: 1.0,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0),
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                        shape: PinCodeFieldShape.box,
                        activeColor: FlutterFlowTheme.of(context).tertiary,
                        inactiveColor: FlutterFlowTheme.of(context).tertiary,
                        selectedColor: FlutterFlowTheme.of(context).secondary,
                      ),
                      onCompleted: (_){
                        _model.pinCodeFocusNode?.unfocus();
                      },
                      controller: _model.pinCodeController,
                      onChanged: (_) {},
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: _model.pinCodeControllerValidator.asValidator(context),
                    ),
                    if (_model.errorText != null && _model.errorText != '')
                      Text(
                        _model.errorText!,
                        style: FlutterFlowTheme.of(context).bodySmall.override(
                              fontFamily: 'MonaSans',
                              color: FlutterFlowTheme.of(context).error,
                              letterSpacing: 0.0,
                            ),
                      ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Didn’t Receive OTP Code?',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'MonaSans',
                                letterSpacing: 0.0,
                              ),
                        ),
                        Builder(
                          builder: (context) {
                            if (_model.showResent) {
                              return InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  logFirebaseEvent('OTP_SCREEN_PAGE_Text_6mfs72rp_ON_TAP');
                                  _model.timerController.onResetTimer();

                                  _model.showResent = false;
                                  safeSetState(() {});
                                  _model.timerController.onStartTimer();
                                  _model.checkResponse = await GetInAuthGroup.checkVFiveCall.call(
                                    phoneEmail: widget.phoneEmail,
                                    phoneCountryCode: widget.countryCode,
                                    firebaseAuthToken: widget.firebaseToken,
                                    apiBaseURL: FlavorHelper.appFlavor.getInAppBaseUrl,
                                    scannerApiKey: FlavorHelper.appFlavor.scannerApiKey,
                                    apiVersion: FlavorHelper.appFlavor.apiVersion,
                                  );

                                  safeSetState(() {});
                                },
                                child: Text(
                                  'Resend Code',
                                  style: FlutterFlowTheme.of(context).labelLarge.override(
                                        fontFamily: 'MonaSans',
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              );
                            } else {
                              return FlutterFlowTimer(
                                initialTime: _model.timerInitialTimeMs,
                                getDisplayTime: (value) => StopWatchTimer.getDisplayTime(
                                  value,
                                  hours: false,
                                  milliSecond: false,
                                ),
                                controller: _model.timerController,
                                updateStateInterval: const Duration(milliseconds: 1000),
                                onChanged: (value, displayTime, shouldUpdate) {
                                  _model.timerMilliseconds = value;
                                  _model.timerValue = displayTime;
                                  if (shouldUpdate) safeSetState(() {});
                                },
                                onEnded: () async {
                                  logFirebaseEvent('OTP_SCREEN_Timer_itbc7ttt_ON_TIMER_END');
                                  _model.showResent = true;
                                  safeSetState(() {});
                                },
                                textAlign: TextAlign.start,
                                style: FlutterFlowTheme.of(context).labelLarge.override(
                                      fontFamily: 'MonaSans',
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                    wrapWithModel(
                      model: _model.customButtonModel,
                      updateCallback: () => safeSetState(() {}),
                      child: CustomButtonWidget(
                        title: 'Submit',
                        onTap: () async {
                          logFirebaseEvent('OTP_SCREEN_Container_pnvmk5nb_CALLBACK');
                          var shouldSetState = false;
                          if (FFAppState().isOnline) {
                            _model.errorText = null;
                            safeSetState(() {});
                            _model.loginResponse = await GetInAuthGroup.loginVFiveCall.call(
                              phoneEmail: widget.phoneEmail,
                              otpCode: _model.pinCodeController!.text,
                              csrfToken: widget.token,
                              phoneCountryCode: widget.countryCode,
                              apiBaseURL: FlavorHelper.appFlavor.getInAppBaseUrl,
                              scannerApiKey: FlavorHelper.appFlavor.scannerApiKey,
                              apiVersion: FlavorHelper.appFlavor.apiVersion,
                            );

                            shouldSetState = true;
                            await actions.printData(
                              (_model.loginResponse?.jsonBody ?? '').toString(),
                            );
                            if ((_model.loginResponse?.succeeded ?? false) &&
                                ((LoginResponseModelStruct.maybeFromMap((_model.loginResponse?.jsonBody ?? ''))
                                                ?.original
                                                .error ==
                                            null ||
                                        LoginResponseModelStruct.maybeFromMap((_model.loginResponse?.jsonBody ?? ''))
                                                ?.original
                                                .error ==
                                            '') ||
                                    (LoginResponseModelStruct.maybeFromMap((_model.loginResponse?.jsonBody ?? ''))
                                            ?.original
                                            .error ==
                                        '0'))) {
                              FFAppState().user = LoggedInModelStruct(
                                userId: LoginResponseModelStruct.maybeFromMap((_model.loginResponse?.jsonBody ?? ''))
                                    ?.userData
                                    .userId,
                                profile: () {
                                  if (LoginResponseModelStruct.maybeFromMap((_model.loginResponse?.jsonBody ?? ''))
                                          ?.userData
                                          .type ==
                                      2) {
                                    return Profile.admin;
                                  } else if (((LoginResponseModelStruct.maybeFromMap(
                                                      (_model.loginResponse?.jsonBody ?? ''))
                                                  ?.userData
                                                  .isManager ==
                                              1) &&
                                          (LoginResponseModelStruct.maybeFromMap((_model.loginResponse?.jsonBody ?? ''))
                                                  ?.userData
                                                  .isProducer ==
                                              1)) ||
                                      (LoginResponseModelStruct.maybeFromMap((_model.loginResponse?.jsonBody ?? ''))
                                              ?.userData
                                              .isManager ==
                                          1)) {
                                    return Profile.manager;
                                  } else {
                                    return Profile.producer;
                                  }
                                }(),
                                user: LoginResponseModelStruct.maybeFromMap((_model.loginResponse?.jsonBody ?? ''))
                                    ?.userData,
                                auth:
                                    LoginResponseModelStruct.maybeFromMap((_model.loginResponse?.jsonBody ?? ''))?.auth,
                                isManager: valueOrDefault<int>(
                                  LoginResponseModelStruct.maybeFromMap((_model.loginResponse?.jsonBody ?? ''))
                                      ?.userData
                                      .isManager,
                                  0,
                                ),
                                isProducer: valueOrDefault<int>(
                                  LoginResponseModelStruct.maybeFromMap((_model.loginResponse?.jsonBody ?? ''))
                                      ?.userData
                                      .isProducer,
                                  0,
                                ),
                              );
                              safeSetState(() {});
                              // await actions.supabaseLogin();
                              await actions.generateAccessCodeIfNot((value) {
                                if(value) {
                                  FFAppState().tapToPayTutorialDone = false;
                                }
                              });
                              int i = 0;
                              while (_model.pinResponse?.firstOrNull == null) {
                                _model.pinResponse = await PinTable().queryRows(
                                  queryFn: (q) => q.eqOrNull(
                                    'user_id',
                                    FFAppState().user.userId,
                                  ),
                                );
                                debugPrint("PIN Attempt  ===>> ${i++}");
                              }

                              shouldSetState = true;
                              if (_model.pinResponse != null && (_model.pinResponse)!.isNotEmpty) {
                                _model.version = await actions.getAppVersionName();
                                shouldSetState = true;
                                _model.checkDeviceResponse = await DeviceTable().queryRows(
                                  queryFn: (q) => q
                                      .eqOrNull(
                                        'pin_id',
                                        _model.pinResponse?.firstOrNull?.uid,
                                      )
                                      .eqOrNull(
                                        'device_id',
                                        FFAppState().uuid,
                                      )
                                      .eqOrNull(
                                        'isAdmin',
                                        true,
                                      ),
                                );
                                shouldSetState = true;
                                if (_model.checkDeviceResponse != null && (_model.checkDeviceResponse)!.isNotEmpty) {
                                  _model.deviceId = _model.checkDeviceResponse?.firstOrNull?.uid;
                                  await DeviceTable().update(
                                    data: {
                                      'version': _model.version,
                                      'user_id': FFAppState().user.userId,
                                      if(isAndroid) 'tap_to_pay_enabled': true
                                    },
                                    matchingRows: (rows) => rows.eqOrNull(
                                      'uid',
                                      _model.checkDeviceResponse?.firstOrNull?.uid,
                                    ),
                                  );
                                  shouldSetState = true;
                                } else {
                                  _model.newDeviceData = await DeviceTable().insert({
                                    'pin_id': _model.pinResponse?.firstOrNull?.uid,
                                    'version': _model.version,
                                    'name': FFAppState().deviceName,
                                    'device_id': FFAppState().uuid,
                                    'isAdmin': true,
                                    'user_id': FFAppState().user.userId,
                                    if(isAndroid) 'tap_to_pay_enabled': true
                                  });
                                  shouldSetState = true;
                                  _model.deviceId = _model.newDeviceData?.uid;
                                }

                                FFAppState().updateUserStruct(
                                  (e) => e
                                    ..deviceId = _model.deviceId
                                    ..permissions = 0
                                    ..isManager = valueOrDefault<int>(
                                      LoginResponseModelStruct.maybeFromMap((_model.loginResponse?.jsonBody ?? ''))
                                          ?.userData
                                          .isManager,
                                      0,
                                    )
                                    ..isProducer = valueOrDefault<int>(
                                      LoginResponseModelStruct.maybeFromMap((_model.loginResponse?.jsonBody ?? ''))
                                          ?.userData
                                          .isProducer,
                                      0,
                                    )
                                    ..pinId =
                                        _model.pinResponse?.firstOrNull?.uid,
                                );
                                // if ((valueOrDefault<int>(
                                //           LoginResponseModelStruct.maybeFromMap(
                                //                   (_model.loginResponse
                                //                           ?.jsonBody ??
                                //                       ''))
                                //               ?.userData
                                //               .isManager,
                                //           0,
                                //         ) ==
                                //         1) &&
                                //     (valueOrDefault<int>(
                                //           LoginResponseModelStruct.maybeFromMap(
                                //                   (_model.loginResponse
                                //                           ?.jsonBody ??
                                //                       ''))
                                //               ?.userData
                                //               .isProducer,
                                //           0,
                                //         ) ==
                                //         1)) {
                                //   context.goNamed(
                                //       SelectProfileScreenWidget.routeName);
                                //
                                //   if (shouldSetState) safeSetState(() {});
                                //   return;
                                // } else {
                                await actions.supabaseLogin();
                                context.goNamed(DashBoardScreenWidget.routeName);
                                // }  );

                                if (shouldSetState) safeSetState(() {});
                                return;
                                // }
                              } else {
                                if (shouldSetState) safeSetState(() {});
                                return;
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    () {
                                      final error = LoginResponseModelStruct.maybeFromMap(
                                          _model.loginResponse?.jsonBody ?? ''
                                      )?.original.error;
                                      switch (error) {
                                        case '3.1':
                                          return 'Phone / Email is not valid';
                                        case '3.2':
                                        case '35':
                                          return 'OTP code is not valid';
                                        case '34':
                                          return 'OTP code is required';
                                        case '36':
                                          return 'Problem with creation OTP in DB. BE critical error. Please try again later';
                                        case '37':
                                          return 'You can send the request only once per minute';
                                        case '40':
                                          return 'Problem with creation CSRF token. BE critical error. Please try again later';
                                        case '41':
                                          return 'Too many attempts. Please try again later';
                                        case '42':
                                          return 'Problem with validating Firebase token';
                                        case '43':
                                          return 'Login not allowed. This user is blacklisted';
                                        case '44':
                                        case '45':
                                          return 'Problem with sending email. BE critical error. Please try again later';
                                        case '54':
                                          return 'CSRF token validation failed. Please login again from the start';
                                        case '59':
                                          return 'Problem with sending phone. BE critical error. Please try again later';
                                        case '60':
                                          return 'This email or phone is blocked for login';
                                        default:
                                          return 'Please enter a valid OTP';
                                      }
                                    }(),
                                    style: TextStyle(
                                      color: FlutterFlowTheme.of(context).primaryText,
                                    ),
                                  ),
                                  duration: const Duration(milliseconds: 4000),
                                  backgroundColor: FlutterFlowTheme.of(context).primary,
                                ),
                              );
                              if (shouldSetState) safeSetState(() {});
                              return;
                            }
                          } else {
                            _model.errorText = 'No internet connection.';
                            safeSetState(() {});
                            if (shouldSetState) safeSetState(() {});
                            return;
                          }

                          if (shouldSetState) safeSetState(() {});
                        },
                      ),
                    ),
                    // Text(
                    //   widget.otp!,
                    //   style: FlutterFlowTheme.of(context).bodyMedium.override(
                    //         fontFamily: 'MonaSans',
                    //         letterSpacing: 0.0,
                    //         useGoogleFonts: false,
                    //       ),
                    // ),
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

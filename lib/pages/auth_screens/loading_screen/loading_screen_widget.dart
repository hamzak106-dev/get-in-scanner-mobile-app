import 'package:g_e_t_i_n_scanner/components/custom_button/custom_button_widget.dart';
import 'package:g_e_t_i_n_scanner/custom_code/actions/updateDeviceAppVersion.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:rive/rive.dart' hide LinearGradient, Image;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'loading_screen_model.dart';
export 'loading_screen_model.dart';

class LoadingScreenWidget extends StatefulWidget {
  const LoadingScreenWidget({
    super.key,
    bool? avoidWaiting,
  }) : this.avoidWaiting = avoidWaiting ?? false;

  final bool avoidWaiting;

  static String routeName = 'LoadingScreen';
  static String routePath = '/loadingScreen';

  @override
  State<LoadingScreenWidget> createState() => _LoadingScreenWidgetState();
}

class _LoadingScreenWidgetState extends State<LoadingScreenWidget> {
  late LoadingScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  void _showSplashChoiceDialog() {
    // Mark as seen immediately
    FFAppState().hasSeenSplashPrompt = true;

    showDialog(
      context: context,
      barrierDismissible: false, // user must choose
      builder: (context) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 370, // fixed width for dialog
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [


                  Text("Show Splash Animation?",
                  style: FlutterFlowTheme.of(context).bodySmall.copyWith(
                    color: Colors.black,
                    fontFamily: 'MonaSans',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.4,

                  ),),

                   Padding(
                     padding: const EdgeInsets.only(top: 15,bottom: 25),
                     child: Text(
                      "Would you like to see the splash animation in future app launches?",
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).bodySmall.copyWith(
                        color: Colors.black,
                        fontFamily: 'MonaSans',
                        fontSize: 16
                      ),
                                       ),
                   ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 45,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(

                              padding: EdgeInsets.all(10),
                              side: const BorderSide(color: Colors.black),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: (){
                              FFAppState().splashScreenStatus = 'Disabled';
                              Navigator.pop(context);
                              _proceedAfterSplashChoice();
                            },
                            child: Text(
                              'No',
                              style: FlutterFlowTheme.of(context).bodySmall.override(
                                fontFamily: 'MonaSans',
                                color: Colors.black,
                                letterSpacing: 0.8,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 30),
                      Expanded(child:
                      SizedBox(
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            padding: const EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 0, // optional: flat look
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            _proceedAfterSplashChoice();
                          },
                          child: Text(
                            'Yes',
                            style: FlutterFlowTheme.of(context).bodySmall.override(
                              fontFamily: 'MonaSans',
                              color: Colors.white,
                              letterSpacing: 0.8,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )

                      ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _proceedAfterSplashChoice() async {
    // Show logo briefly if you want
    await Future.delayed(const Duration(seconds: 2));

    if (functions.checkJson(FFAppState().user.toMap()) &&
        (FFAppState().user.userId != 0)) {
      await updateDeviceAppVersion();
      context.goNamed(DashBoardScreenWidget.routeName);
    } else {
      context.goNamed(LoginScreenWidget.routeName);
    }
  }

  Future<void> _handleSplashAndNavigation() async {
    // Show splash animation if enabled
    if (!widget.avoidWaiting && FFAppState().splashScreenStatus == 'Enabled') {
      await Future.delayed(const Duration(milliseconds: 5500));
    }
    // Navigate to the correct page
    if (functions.checkJson(FFAppState().user.toMap()) &&
        (FFAppState().user.userId != 0)) {
      await updateDeviceAppVersion();
      context.goNamed(DashBoardScreenWidget.routeName);
    } else {
      context.goNamed(LoadingScreenWidget.routeName);
    }
  }



  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoadingScreenModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'LoadingScreen'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (!FFAppState().hasSeenSplashPrompt) {
        FFAppState().hasSeenSplashPrompt = true;
        _showSplashChoiceDialog();
      }
      await _handleSplashAndNavigation();
      await actions.getDeviceId();
      if (functions.checkJson(FFAppState().user.toMap()) && (FFAppState().user.userId != 0)) {
        await updateDeviceAppVersion();
        context.goNamed(DashBoardScreenWidget.routeName);
      } else {
        _model.showButtons = true;
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
    context.watch<FFAppState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: Stack(
        children: [
          // Only show Rive animation if splash is enabled
          if (FFAppState().splashScreenStatus == 'Enabled')
          Container(
            width: double.infinity,
            height: double.infinity,
            child: RiveAnimation.asset(
              'assets/rive_animations/loading_animation.riv',
              artboard: 'Loading Animation',
              fit: BoxFit.fill,
              controllers: _model.riveAnimationControllers,
            ),
          ),
          if (_model.showButtons)
            Align(
              alignment: AlignmentDirectional(0.0, 0.0),
              child: Padding(
                padding: EdgeInsets.all(28.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        logFirebaseEvent('LOADING_SCREEN_Container_c8altp6n_ON_TAP');

                        context.pushNamed(PasskeyLoginScreenWidget.routeName);
                      },
                      child: Container(
                        width: double.infinity,
                        height: 60.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondary,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Text(
                          'Login With the Access Code',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'MonaSans',
                                color: FlutterFlowTheme.of(context).alternate,
                                letterSpacing: 0.4,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        logFirebaseEvent('LOADING_SCREEN_Container_ymkyaxqs_ON_TAP');

                        context.pushNamed(LoginScreenWidget.routeName);
                      },
                      child: Container(
                        width: double.infinity,
                        height: 60.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondary,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              'assets/images/img_logo.svg',
                              width: 24.0,
                              height: 24.0,
                              fit: BoxFit.contain,
                            ),
                            Text(
                              'Sign In With Your GetIn Account',
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'MonaSans',
                                    color: FlutterFlowTheme.of(context).alternate,
                                    letterSpacing: 0.4,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ].divide(SizedBox(width: 10.0)),
                        ),
                      ),
                    ),
                  ].divide(SizedBox(height: 20.0)).addToStart(SizedBox(height: 160.0)),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

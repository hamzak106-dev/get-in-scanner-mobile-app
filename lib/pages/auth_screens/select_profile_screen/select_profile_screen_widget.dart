import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/components/dialogs/info_dialog/info_dialog_widget.dart';
import '/components/profile_role_card/profile_role_card_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'select_profile_screen_model.dart';
export 'select_profile_screen_model.dart';

class SelectProfileScreenWidget extends StatefulWidget {
  const SelectProfileScreenWidget({super.key});

  static String routeName = 'SelectProfileScreen';
  static String routePath = '/selectProfileScreen';

  @override
  State<SelectProfileScreenWidget> createState() =>
      _SelectProfileScreenWidgetState();
}

class _SelectProfileScreenWidgetState extends State<SelectProfileScreenWidget> {
  late SelectProfileScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SelectProfileScreenModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'SelectProfileScreen'});
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
          child: Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Padding(
              padding: EdgeInsets.all(28.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SvgPicture.asset(
                        'assets/images/img_name_logo.svg',
                        height: 44.0,
                        fit: BoxFit.contain,
                      ),
                      Text(
                        'Select Your Role',
                        style: FlutterFlowTheme.of(context).titleLarge.override(
                              fontFamily: 'MonaSans',
                              fontSize: 24.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w500,
                              lineHeight: 2.0,
                            ),
                      ),
                      RichText(
                        textScaler: MediaQuery.of(context).textScaler,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Before proceeding,\n',
                              style: TextStyle(
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                            ),
                            TextSpan(
                              text: 'We want to know who you are',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'MonaSans',
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                            )
                          ],
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'MonaSans',
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                    lineHeight: 1.5,
                                  ),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ].divide(SizedBox(height: 16.0)),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (FFAppState().user.profile == Profile.admin)
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            logFirebaseEvent(
                                'SELECT_PROFILE_SCREEN_Container_i7pz3tn6');
                            _model.selectedRole = Profile.admin;
                            safeSetState(() {});
                          },
                          child: custom_widgets.CardGradientWidget(
                            width: double.infinity,
                            height: 92.0,
                            isSelected: _model.selectedRole == Profile.admin,
                            child: () => ProfileRoleCardWidget(
                              role: Profile.admin,
                              isSelected: _model.selectedRole == Profile.admin,
                            ),
                          ),
                        ),
                      // if (FFAppState().user.user.isProducer == 1)
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            logFirebaseEvent(
                                'SELECT_PROFILE_SCREEN_Container_1n20v5k7');
                            _model.selectedRole = Profile.producer;
                            safeSetState(() {});
                          },
                          child: custom_widgets.CardGradientWidget(
                            width: double.infinity,
                            height: 92.0,
                            isSelected: _model.selectedRole == Profile.producer,
                            child: () => ProfileRoleCardWidget(
                              role: Profile.producer,
                              isSelected:
                                  _model.selectedRole == Profile.producer,
                            ),
                          ),
                        ),
                      // if (FFAppState().user.isManager == 1)
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            logFirebaseEvent(
                                'SELECT_PROFILE_SCREEN_Container_waee407m');
                            _model.selectedRole = Profile.manager;
                            safeSetState(() {});
                          },
                          child: custom_widgets.CardGradientWidget(
                            width: double.infinity,
                            height: 92.0,
                            isSelected: _model.selectedRole == Profile.manager,
                            child: () => ProfileRoleCardWidget(
                              role: Profile.manager,
                              isSelected:
                                  _model.selectedRole == Profile.manager,
                            ),
                          ),
                        )
                      ,
                    ].divide(SizedBox(height: 12.0)),
                  ),
                  Builder(
                    builder: (context) => FFButtonWidget(
                      onPressed: () async {
                        logFirebaseEvent(
                            'SELECT_PROFILE_SCREEN_CONTINUE_BTN_ON_TA');
                        if (_model.selectedRole != null) {
                          FFAppState().updateUserStruct(
                            (e) => e..profile = _model.selectedRole,
                          );
                          FFAppState().selectedProducer = UserModelStruct();
                          FFAppState().update(() {});
                          // context.replaceNamed(DashBoardScreenWidget.routeName);

                          while (context.canPop()) {
                            context.pop();
                          }
                          context.replaceNamed(DashBoardScreenWidget.routeName);

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
                                    title: 'Select Profile',
                                    subTitle: 'Select your profile.',
                                    firstBtnText: 'OK',
                                    firstBtnColor:
                                        FlutterFlowTheme.of(context).accent3,
                                    isLight: true,
                                    firstTap: () async {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                      text: 'CONTINUE',
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 60.0,
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).primaryText,
                        textStyle:
                            FlutterFlowTheme.of(context).titleSmall.override(
                                  fontFamily: 'MonaSans',
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                  lineHeight: 1.43,
                                ),
                        elevation: 0.0,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ]
                    .divide(SizedBox(height: 36.0))
                    .addToStart(SizedBox(height: 8.0))
                    .addToEnd(SizedBox(height: 8.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

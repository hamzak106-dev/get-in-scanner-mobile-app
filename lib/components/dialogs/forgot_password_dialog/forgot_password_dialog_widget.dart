import '/components/dialog_button/dialog_button_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'forgot_password_dialog_model.dart';
export 'forgot_password_dialog_model.dart';

class ForgotPasswordDialogWidget extends StatefulWidget {
  const ForgotPasswordDialogWidget({super.key});

  @override
  State<ForgotPasswordDialogWidget> createState() =>
      _ForgotPasswordDialogWidgetState();
}

class _ForgotPasswordDialogWidgetState
    extends State<ForgotPasswordDialogWidget> {
  late ForgotPasswordDialogModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ForgotPasswordDialogModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(0.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 4.0,
          sigmaY: 4.0,
        ),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Color(0x80000000),
          ),
          child: Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/images/img_name_logo.svg',
                  height: 72.0,
                  fit: BoxFit.contain,
                ),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: 270.0,
                  ),
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 20.0, 0.0, 16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Forgot Password?',
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'MonaSans',
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            Text(
                              'We have emailed you the login link. ',
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: 'MonaSans',
                                    color: FlutterFlowTheme.of(context).info,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ].divide(SizedBox(height: 4.0)),
                        ),
                      ),
                      wrapWithModel(
                        model: _model.dialogButtonModel1,
                        updateCallback: () => safeSetState(() {}),
                        child: DialogButtonWidget(
                          buttonLable: 'Open Mail App',
                          textColor: FlutterFlowTheme.of(context).accent3,
                          onTap: () async {
                            logFirebaseEvent(
                                'FORGOT_PASSWORD_DIALOG_Container_g9i5zgi');
                            await launchURL('mailto:');
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      wrapWithModel(
                        model: _model.dialogButtonModel2,
                        updateCallback: () => safeSetState(() {}),
                        child: DialogButtonWidget(
                          buttonLable: 'Go Back',
                          textColor: FlutterFlowTheme.of(context).info,
                          onTap: () async {
                            logFirebaseEvent(
                                'FORGOT_PASSWORD_DIALOG_Container_trf8ks6');
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ].divide(SizedBox(height: 50.0)),
            ),
          ),
        ),
      ),
    );
  }
}

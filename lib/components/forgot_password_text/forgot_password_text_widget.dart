import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'forgot_password_text_model.dart';
export 'forgot_password_text_model.dart';

class ForgotPasswordTextWidget extends StatefulWidget {
  const ForgotPasswordTextWidget({super.key});

  @override
  State<ForgotPasswordTextWidget> createState() =>
      _ForgotPasswordTextWidgetState();
}

class _ForgotPasswordTextWidgetState extends State<ForgotPasswordTextWidget> {
  late ForgotPasswordTextModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ForgotPasswordTextModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        logFirebaseEvent('FORGOT_PASSWORD_TEXT_Text_ycjcbag4_ON_TA');

        context.pushNamed(ForgotPasswordScreenWidget.routeName);
      },
      child: Text(
        'Forgot Password?',
        style: FlutterFlowTheme.of(context).bodyMedium.override(
              fontFamily: 'MonaSans',
              letterSpacing: 0.0,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

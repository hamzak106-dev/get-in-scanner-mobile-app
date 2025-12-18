import '/components/custom_button/custom_button_widget.dart';
import '/components/dialogs/forgot_password_dialog/forgot_password_dialog_widget.dart';
import '/components/simple_text_field/simple_text_field_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'forgot_password_screen_model.dart';
export 'forgot_password_screen_model.dart';

class ForgotPasswordScreenWidget extends StatefulWidget {
  const ForgotPasswordScreenWidget({super.key});

  static String routeName = 'ForgotPasswordScreen';
  static String routePath = '/forgotPasswordScreen';

  @override
  State<ForgotPasswordScreenWidget> createState() =>
      _ForgotPasswordScreenWidgetState();
}

class _ForgotPasswordScreenWidgetState
    extends State<ForgotPasswordScreenWidget> {
  late ForgotPasswordScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ForgotPasswordScreenModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'ForgotPasswordScreen'});
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 34.0),
                      child: SvgPicture.asset(
                        'assets/images/img_name_logo.svg',
                        height: 72.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    wrapWithModel(
                      model: _model.simpleTextFieldModel,
                      updateCallback: () => safeSetState(() {}),
                      child: SimpleTextFieldWidget(
                        hintText: 'Your GetIn Account',
                      ),
                    ),
                    Builder(
                      builder: (context) => wrapWithModel(
                        model: _model.customButtonModel,
                        updateCallback: () => safeSetState(() {}),
                        child: CustomButtonWidget(
                          title: 'Submit',
                          onTap: () async {
                            logFirebaseEvent(
                                'FORGOT_PASSWORD_SCREEN_Container_udyoy33');
                            await showDialog(
                              barrierColor: Colors.transparent,
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
                                    child: Container(
                                      height: double.infinity,
                                      width: double.infinity,
                                      child: ForgotPasswordDialogWidget(),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
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

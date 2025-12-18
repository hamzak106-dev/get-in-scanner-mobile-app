import '/components/dialog_button/dialog_button_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'logout_dialog_model.dart';
export 'logout_dialog_model.dart';

class LogoutDialogWidget extends StatefulWidget {
  const LogoutDialogWidget({
    super.key,
    this.title,
    this.subTitle,
    this.firstBtnText,
    this.secondBtnText,
    this.firstBtnColor,
    this.secondBtnColor,
    required this.firstTap,
    required this.secondTap,
    bool? showExport,
  }) : this.showExport = showExport ?? false;

  final String? title;
  final String? subTitle;
  final String? firstBtnText;
  final String? secondBtnText;
  final Color? firstBtnColor;
  final Color? secondBtnColor;
  final Future Function()? firstTap;
  final Future Function()? secondTap;
  final bool showExport;

  @override
  State<LogoutDialogWidget> createState() => _LogoutDialogWidgetState();
}

class _LogoutDialogWidgetState extends State<LogoutDialogWidget> {
  late LogoutDialogModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LogoutDialogModel());
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
                            16.0, 20.0, 16.0, 16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              widget.title!,
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'MonaSans',
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            Text(
                              widget.subTitle!,
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: 'MonaSans',
                                    color: Color(0x99FFFFFF),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ].divide(SizedBox(height: 6.0)),
                        ),
                      ),
                      wrapWithModel(
                        model: _model.dialogButtonModel1,
                        updateCallback: () => safeSetState(() {}),
                        child: DialogButtonWidget(
                          buttonLable: widget.firstBtnText!,
                          textColor: widget.firstBtnColor,
                          onTap: () async {
                            logFirebaseEvent(
                                'LOGOUT_DIALOG_Container_ya6fbpnd_CALLBAC');
                            await widget.firstTap?.call();
                          },
                        ),
                      ),
                      if (widget.showExport)
                        wrapWithModel(
                          model: _model.dialogButtonModel2,
                          updateCallback: () => safeSetState(() {}),
                          child: DialogButtonWidget(
                            buttonLable: 'Download Sample',
                            textColor: FlutterFlowTheme.of(context).accent3,
                            onTap: () async {
                              logFirebaseEvent(
                                  'LOGOUT_DIALOG_Container_3f1cmz36_CALLBAC');
                              _model.sampleResponse =
                                  await actions.exportCsvFile(
                                _model.attendees.toList(),
                                true,
                              );
                              if (_model.sampleResponse != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Sample CSV file downloaded successfully.',
                                      style: TextStyle(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 4000),
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).success,
                                  ),
                                );
                              }
                              Navigator.pop(context);

                              safeSetState(() {});
                            },
                          ),
                        ),
                      wrapWithModel(
                        model: _model.dialogButtonModel3,
                        updateCallback: () => safeSetState(() {}),
                        child: DialogButtonWidget(
                          buttonLable: widget.secondBtnText!,
                          textColor: widget.secondBtnColor,
                          onTap: () async {
                            logFirebaseEvent(
                                'LOGOUT_DIALOG_Container_tvttp5kr_CALLBAC');
                            await widget.secondTap?.call();
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

import '/components/dialog_button/dialog_button_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'delete_scanner_dialog_model.dart';
export 'delete_scanner_dialog_model.dart';

class DeleteScannerDialogWidget extends StatefulWidget {
  const DeleteScannerDialogWidget({
    super.key,
    this.title,
    this.subTitle,
    this.firstBtnText,
    this.secondBtnText,
    this.firstBtnColor,
    this.secondBtnColor,
  });

  final String? title;
  final String? subTitle;
  final String? firstBtnText;
  final String? secondBtnText;
  final Color? firstBtnColor;
  final Color? secondBtnColor;

  @override
  State<DeleteScannerDialogWidget> createState() =>
      _DeleteScannerDialogWidgetState();
}

class _DeleteScannerDialogWidgetState extends State<DeleteScannerDialogWidget> {
  late DeleteScannerDialogModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DeleteScannerDialogModel());
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
                                'DELETE_SCANNER_DIALOG_Container_lcup277c');
                            Navigator.pop(context, true);
                          },
                        ),
                      ),
                      if (widget.secondBtnText != null &&
                          widget.secondBtnText != '')
                        wrapWithModel(
                          model: _model.dialogButtonModel2,
                          updateCallback: () => safeSetState(() {}),
                          child: DialogButtonWidget(
                            buttonLable: widget.secondBtnText!,
                            textColor: widget.secondBtnColor,
                            onTap: () async {
                              logFirebaseEvent(
                                  'DELETE_SCANNER_DIALOG_Container_npl6pfvi');
                              Navigator.pop(context, false);
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

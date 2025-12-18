import '/components/dialog_button/dialog_button_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'info_dialog_model.dart';
export 'info_dialog_model.dart';

class InfoDialogWidget extends StatefulWidget {
  const InfoDialogWidget({
    super.key,
    this.title,
    this.subTitle,
    this.firstBtnText,
    this.firstBtnColor,
    this.firstTap,
    bool? isLight,
  }) : this.isLight = isLight ?? false;

  final String? title;
  final String? subTitle;
  final String? firstBtnText;
  final Color? firstBtnColor;
  final Future Function()? firstTap;
  final bool isLight;

  @override
  State<InfoDialogWidget> createState() => _InfoDialogWidgetState();
}

class _InfoDialogWidgetState extends State<InfoDialogWidget> {
  late InfoDialogModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => InfoDialogModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('INFO_DIALOG_InfoDialog_ON_INIT_STATE');
      if (widget.firstBtnText == null || widget.firstBtnText == '') {
        await Future.delayed(const Duration(milliseconds: 1905));
        Navigator.pop(context);
      }
    });
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
        child: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            logFirebaseEvent('INFO_DIALOG_Container_tvfajudd_ON_TAP');
            Navigator.pop(context);
          },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: widget.isLight ? Colors.transparent : Color(0x80000000),
            ),
            child: Align(
              alignment: AlignmentDirectional(0.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: double.infinity,
                    constraints: BoxConstraints(
                      maxWidth: 270.0,
                    ),
                    decoration: BoxDecoration(
                      color: widget.isLight
                          ? Color(0xFFDADBDD)
                          : FlutterFlowTheme.of(context).secondaryBackground,
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
                                      color: widget.isLight
                                          ? Color(0xFF1C1D21)
                                          : FlutterFlowTheme.of(context)
                                              .primaryText,
                                      letterSpacing: 0.0,
                                    ),
                              ),
                              if (widget.subTitle != null &&
                                  widget.subTitle != '')
                                Text(
                                  widget.subTitle!,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  style: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'MonaSans',
                                        color: widget.isLight
                                            ? Color(0xFF1C1D21)
                                            : FlutterFlowTheme.of(context).info,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                            ].divide(SizedBox(height: 6.0)),
                          ),
                        ),
                        if (widget.firstBtnText != null &&
                            widget.firstBtnText != '')
                          wrapWithModel(
                            model: _model.dialogButtonModel,
                            updateCallback: () => safeSetState(() {}),
                            child: DialogButtonWidget(
                              buttonLable: widget.firstBtnText!,
                              textColor: widget.firstBtnColor,
                              onTap: () async {
                                logFirebaseEvent(
                                    'INFO_DIALOG_Container_cj5gib06_CALLBACK');
                                await widget.firstTap?.call();
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
      ),
    );
  }
}

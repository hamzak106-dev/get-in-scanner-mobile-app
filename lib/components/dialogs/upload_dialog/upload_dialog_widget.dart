import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'upload_dialog_model.dart';
export 'upload_dialog_model.dart';

class UploadDialogWidget extends StatefulWidget {
  const UploadDialogWidget({super.key});

  @override
  State<UploadDialogWidget> createState() => _UploadDialogWidgetState();
}

class _UploadDialogWidgetState extends State<UploadDialogWidget> {
  late UploadDialogModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UploadDialogModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('UPLOAD_DIALOG_UploadDialog_ON_INIT_STATE');
      while (_model.progress < 99) {
        _model.progress = _model.progress + 9;
        _model.time = () {
          if (_model.progress < 33) {
            return 3;
          } else if (_model.progress < 66) {
            return 2;
          } else {
            return 1;
          }
        }();
        safeSetState(() {});
        await Future.delayed(const Duration(milliseconds: 400));
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
                  width: double.infinity,
                  constraints: BoxConstraints(
                    maxWidth: 270.0,
                  ),
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          '${_model.time.toString()} Second Left',
                          textAlign: TextAlign.center,
                          style:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'MonaSans',
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 4.0),
                          child: Text(
                            'Uploading',
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'MonaSans',
                                  color: FlutterFlowTheme.of(context).accent4,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                        Builder(
                          builder: (context) {
                            if (_model.progress < 99) {
                              return CircularPercentIndicator(
                                percent: _model.progress / 100,
                                radius: 30.0,
                                lineWidth: 4.0,
                                animation: true,
                                animateFromLastPercent: true,
                                progressColor:
                                    FlutterFlowTheme.of(context).primary,
                                backgroundColor:
                                    FlutterFlowTheme.of(context).secondaryText,
                                center: Text(
                                  '${valueOrDefault<String>(
                                    _model.progress.toString(),
                                    '0',
                                  )}%',
                                  style: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                        fontFamily: 'MonaSans',
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              );
                            } else {
                              return custom_widgets.Loader(
                                width: 60.0,
                                height: 60.0,
                                color: FlutterFlowTheme.of(context).primary,
                              );
                            }
                          },
                        ),
                      ].divide(SizedBox(height: 8.0)),
                    ),
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

import '/backend/schema/structs/index.dart';
import '/components/dialog_button/dialog_button_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'summary_dialog_model.dart';
export 'summary_dialog_model.dart';

class SummaryDialogWidget extends StatefulWidget {
  const SummaryDialogWidget({
    super.key,
    required this.summary,
  });

  final UploadDataModelStruct? summary;

  @override
  State<SummaryDialogWidget> createState() => _SummaryDialogWidgetState();
}

class _SummaryDialogWidgetState extends State<SummaryDialogWidget> {
  late SummaryDialogModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SummaryDialogModel());
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
        logFirebaseEvent('SUMMARY_DIALOG_COMP_Blur_u5jvj4bt_ON_TAP');
        Navigator.pop(context);
      },
      child: ClipRRect(
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
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: 270.0,
                ),
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          16.0, 20.0, 16.0, 16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 4.0),
                            child: Text(
                              'Summary',
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'MonaSans',
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ),
                          if (widget.summary?.newAttendeeCount != 0)
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  FFIcons.kicCheckCircle,
                                  color: FlutterFlowTheme.of(context).success,
                                  size: 16.0,
                                ),
                                Flexible(
                                  child: Text(
                                    '${valueOrDefault<String>(
                                      widget.summary?.newAttendeeCount
                                          .toString(),
                                      '0',
                                    )} of ${valueOrDefault<String>(
                                      widget.summary?.totalCount.toString(),
                                      '0',
                                    )} attendees successfully imported',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'MonaSans',
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ),
                              ].divide(SizedBox(width: 8.0)),
                            ),
                          if (widget.summary?.duplicateAttendeeCount != 0)
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  FFIcons.kicError,
                                  color: FlutterFlowTheme.of(context).warning,
                                  size: 16.0,
                                ),
                                Flexible(
                                  child: Text(
                                    '${valueOrDefault<String>(
                                      widget.summary?.duplicateAttendeeCount
                                          .toString(),
                                      '0',
                                    )} of ${valueOrDefault<String>(
                                      widget.summary?.totalCount.toString(),
                                      '0',
                                    )} attendees are already available',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'MonaSans',
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ),
                              ].divide(SizedBox(width: 8.0)),
                            ),
                          if (widget.summary?.errorCount != 0)
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  FFIcons.kicDanger,
                                  color: FlutterFlowTheme.of(context).error,
                                  size: 16.0,
                                ),
                                Flexible(
                                  child: Text(
                                    '${valueOrDefault<String>(
                                      widget.summary?.inCompleteCount
                                          .toString(),
                                      '0',
                                    )} of ${valueOrDefault<String>(
                                      widget.summary?.totalCount.toString(),
                                      '0',
                                    )} attendees were not imported due to incorrect data.',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'MonaSans',
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ),
                              ].divide(SizedBox(width: 8.0)),
                            ),
                        ].divide(SizedBox(height: 8.0)),
                      ),
                    ),
                    wrapWithModel(
                      model: _model.dialogButtonModel,
                      updateCallback: () => safeSetState(() {}),
                      child: DialogButtonWidget(
                        buttonLable: 'Close',
                        textColor: Color(0x99FFFFFF),
                        onTap: () async {
                          logFirebaseEvent(
                              'SUMMARY_DIALOG_Container_43o3qbe9_CALLBA');
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

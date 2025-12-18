import '/backend/schema/enums/enums.dart';
import '/components/dialog_button/dialog_button_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'choose_event_dialog_model.dart';
export 'choose_event_dialog_model.dart';

class ChooseEventDialogWidget extends StatefulWidget {
  const ChooseEventDialogWidget({
    super.key,
    bool? barrierDismissible,
  }) : this.barrierDismissible = barrierDismissible ?? true;

  final bool barrierDismissible;

  @override
  State<ChooseEventDialogWidget> createState() =>
      _ChooseEventDialogWidgetState();
}

class _ChooseEventDialogWidgetState extends State<ChooseEventDialogWidget> {
  late ChooseEventDialogModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChooseEventDialogModel());
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
        logFirebaseEvent('CHOOSE_EVENT_DIALOG_Blur_hehnrkmm_ON_TAP');
        if (widget.barrierDismissible) {
          Navigator.pop(context);
        }
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
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 20.0, 16.0, 16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Choose Event?',
                          textAlign: TextAlign.center,
                          style:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'MonaSans',
                                    letterSpacing: 0.0,
                                  ),
                        ),
                        Text(
                          'Display attendees for a specific event, or view all attendees',
                          textAlign: TextAlign.center,
                          style:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'MonaSans',
                                    color: FlutterFlowTheme.of(context).info,
                                    letterSpacing: 0.0,
                                  ),
                        ),
                      ].divide(SizedBox(height: 6.0)),
                    ),
                  ),
                  wrapWithModel(
                    model: _model.dialogButtonModel1,
                    updateCallback: () => safeSetState(() {}),
                    child: DialogButtonWidget(
                      buttonLable: 'Choose Event',
                      textColor: FlutterFlowTheme.of(context).accent3,
                      onTap: () async {
                        logFirebaseEvent(
                            'CHOOSE_EVENT_DIALOG_Container_meh6w975_C');
                        Navigator.pop(context, ShowEventFor.SingleEvent);
                      },
                    ),
                  ),
                  wrapWithModel(
                    model: _model.dialogButtonModel2,
                    updateCallback: () => safeSetState(() {}),
                    child: DialogButtonWidget(
                      buttonLable: 'View All Events',
                      textColor: FlutterFlowTheme.of(context).info,
                      onTap: () async {
                        logFirebaseEvent(
                            'CHOOSE_EVENT_DIALOG_Container_0bu780co_C');
                        Navigator.pop(context, ShowEventFor.All);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

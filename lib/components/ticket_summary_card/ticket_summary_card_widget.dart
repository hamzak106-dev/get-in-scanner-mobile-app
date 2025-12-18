import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/components/icon_text_chip/icon_text_chip_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'ticket_summary_card_model.dart';
export 'ticket_summary_card_model.dart';

class TicketSummaryCardWidget extends StatefulWidget {
  const TicketSummaryCardWidget({
    super.key,
    required this.title,
    required this.icon,
    this.attendees,
    this.logs,
  });

  final String? title;
  final Widget? icon;
  final List<AttendeeRow>? attendees;
  final List<CheckInLogsRow>? logs;

  @override
  State<TicketSummaryCardWidget> createState() =>
      _TicketSummaryCardWidgetState();
}

class _TicketSummaryCardWidgetState extends State<TicketSummaryCardWidget> {
  late TicketSummaryCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TicketSummaryCardModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: FlutterFlowTheme.of(context).tertiary,
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                widget.icon!,
                Flexible(
                  child: Text(
                    widget.title!,
                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                          fontFamily: 'MonaSans',
                          letterSpacing: 0.0,
                        ),
                  ),
                ),
              ].divide(SizedBox(width: 16.0)),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: wrapWithModel(
                    model: _model.iconTextChipModel1,
                    updateCallback: () => safeSetState(() {}),
                    child: IconTextChipWidget(
                      icon: Icon(
                        FFIcons.kicCheckFillCircle,
                        color: FlutterFlowTheme.of(context).success,
                        size: 16.0,
                      ),
                      lable: widget.attendees!
                          .where((e) => e.status == ScanResult.CHECK_IN.name)
                          .toList()
                          .length
                          .toString(),
                      spacing: 8,
                    ),
                  ),
                ),
                Expanded(
                  child: wrapWithModel(
                    model: _model.iconTextChipModel2,
                    updateCallback: () => safeSetState(() {}),
                    child: IconTextChipWidget(
                      icon: Icon(
                        FFIcons.kicFillQuestion,
                        color: FlutterFlowTheme.of(context).error,
                        size: 16.0,
                      ),
                      lable: widget.attendees!
                          .where((e) =>
                              (e.status == ScanResult.CHECK_OUT.name) ||
                              (e.status == null || e.status == ''))
                          .toList()
                          .length
                          .toString(),
                      spacing: 8,
                    ),
                  ),
                ),
                Expanded(
                  child: wrapWithModel(
                    model: _model.iconTextChipModel3,
                    updateCallback: () => safeSetState(() {}),
                    child: IconTextChipWidget(
                      icon: Icon(
                        FFIcons.kicFillUser,
                        color: FlutterFlowTheme.of(context).warning,
                        size: 16.0,
                      ),
                      lable: widget.attendees!.length.toString(),
                      spacing: 8,
                    ),
                  ),
                ),
                Expanded(
                  child: wrapWithModel(
                    model: _model.iconTextChipModel4,
                    updateCallback: () => safeSetState(() {}),
                    child: IconTextChipWidget(
                      icon: Icon(
                        FFIcons.kicCompare,
                        color: FlutterFlowTheme.of(context).secondary,
                        size: 16.0,
                      ),
                      lable: functions
                          .findTicketScanCount(
                              widget.attendees!.map((e) => e.uid).toList(),
                              widget.logs!
                                  .map((e) => e.attendeeId)
                                  .withoutNulls
                                  .toList())
                          .toString(),
                      spacing: 8,
                    ),
                  ),
                ),
              ].divide(SizedBox(width: 8.0)),
            ),
          ].divide(SizedBox(height: 20.0)),
        ),
      ),
    );
  }
}

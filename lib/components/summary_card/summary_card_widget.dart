import '/backend/schema/structs/index.dart';
import '/components/icon_text_chip/icon_text_chip_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'summary_card_model.dart';
export 'summary_card_model.dart';

class SummaryCardWidget extends StatefulWidget {
  const SummaryCardWidget({
    super.key,
    required this.icon,
    required this.summary,
    bool? byPin,
  }) : this.byPin = byPin ?? false;

  final Widget? icon;
  final SummaryStruct? summary;
  final bool byPin;

  @override
  State<SummaryCardWidget> createState() => _SummaryCardWidgetState();
}

class _SummaryCardWidgetState extends State<SummaryCardWidget> {
  late SummaryCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SummaryCardModel());
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
      child: Column(

        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                widget.icon!,
                Flexible(
                  child: Text(
                    widget.byPin
                        ? valueOrDefault<String>(
                            widget.summary?.value.toString(),
                            '-',
                          )
                        : valueOrDefault<String>(
                            widget.summary?.name,
                            '-',
                          ),
                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                          fontFamily: 'MonaSans',
                          letterSpacing: 0.0,
                        ),
                  ),
                ),
              ].divide(SizedBox(width: 16.0)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15,right: 15,bottom: 15),
            child: Row(
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
                      lable: valueOrDefault<String>(
                        widget.summary?.totalCheckins.toString(),
                        '-',
                      ),
                      spacing: 8,
                    ),
                  ),
                ),
                Expanded(
                  child: Builder(
                    builder: (context) {
                      if (widget.byPin) {
                        return wrapWithModel(
                          model: _model.iconTextChipModel2,
                          updateCallback: () => safeSetState(() {}),
                          child: IconTextChipWidget(
                            icon: Icon(
                              FFIcons.kicCheckOut,
                              color: FlutterFlowTheme.of(context).warning,
                              size: 16.0,
                            ),
                            lable: valueOrDefault<String>(
                              widget.summary?.totalCheckouts.toString(),
                              '-',
                            ),
                            spacing: 8,
                          ),
                        );
                      } else {
                        return wrapWithModel(
                          model: _model.iconTextChipModel3,
                          updateCallback: () => safeSetState(() {}),
                          child: IconTextChipWidget(
                            icon: Icon(
                              FFIcons.kicFillQuestion,
                              color: FlutterFlowTheme.of(context).error,
                              size: 16.0,
                            ),
                            lable: valueOrDefault<String>(
                              widget.summary?.totalAbsent.toString(),
                              '-',
                            ),
                            spacing: 8,
                          ),
                        );
                      }
                    },
                  ),
                ),
                Expanded(
                  child: wrapWithModel(
                    model: _model.iconTextChipModel4,
                    updateCallback: () => safeSetState(() {}),
                    child: IconTextChipWidget(
                      icon: Icon(
                        FFIcons.kicFillUser,
                        color: FlutterFlowTheme.of(context).warning,
                        size: 16.0,
                      ),
                      lable: valueOrDefault<String>(
                        widget.summary?.totalAttendees.toString(),
                        '-',
                      ),
                      spacing: 8,
                    ),
                  ),
                ),
                Expanded(
                  child: wrapWithModel(
                    model: _model.iconTextChipModel5,
                    updateCallback: () => safeSetState(() {}),
                    child: IconTextChipWidget(
                      icon: Icon(
                        FFIcons.kicCompare,
                        color: FlutterFlowTheme.of(context).secondary,
                        size: 16.0,
                      ),
                      lable: valueOrDefault<String>(
                        widget.summary?.totalLogs.toString(),
                        '-',
                      ),
                      spacing: 8,
                    ),
                  ),
                ),
              ].divide(SizedBox(width: 8.0)),
            ),
          ),
        ],
      ),
    );
  }
}

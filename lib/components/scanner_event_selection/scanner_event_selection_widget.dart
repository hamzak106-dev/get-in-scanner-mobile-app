import '/components/scanner_log_bottom_sheet/scanner_log_bottom_sheet_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'scanner_event_selection_model.dart';
export 'scanner_event_selection_model.dart';

class ScannerEventSelectionWidget extends StatefulWidget {
  const ScannerEventSelectionWidget({
    super.key,
    required this.initialIndex,
    required this.onTapChange,
  });

  final int? initialIndex;
  final Future Function(int value)? onTapChange;

  @override
  State<ScannerEventSelectionWidget> createState() =>
      _ScannerEventSelectionWidgetState();
}

class _ScannerEventSelectionWidgetState
    extends State<ScannerEventSelectionWidget> {
  late ScannerEventSelectionModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ScannerEventSelectionModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('SCANNER_EVENT_SELECTION_ScannerEventSele');
      _model.selectedIndex = widget.initialIndex!;
      safeSetState(() {});
    });
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Align(
            alignment: AlignmentDirectional(-1.0, 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                logFirebaseEvent('SCANNER_EVENT_SELECTION_Icon_xfj4ll8z_ON');
                await actions.enableLight();
              },
              child: Icon(
                FFIcons.kicBulb,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 30.0,
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).accent1,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(4.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    logFirebaseEvent(
                        'SCANNER_EVENT_SELECTION_Container_py3f90');
                    _model.selectedIndex = 0;
                    safeSetState(() {});
                  },
                  child: Container(
                    height: 30.0,
                    constraints: BoxConstraints(
                      minWidth: 56.0,
                    ),
                    decoration: BoxDecoration(
                      color: _model.selectedIndex == 0
                          ? FlutterFlowTheme.of(context).accent2
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Builder(
                      builder: (context) {
                        if (_model.selectedIndex == 0) {
                          return Text(
                            'In',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'MonaSans',
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                ),
                          );
                        } else {
                          return Text(
                            'In',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'MonaSans',
                                  letterSpacing: 0.0,
                                ),
                          );
                        }
                      },
                    ),
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    logFirebaseEvent(
                        'SCANNER_EVENT_SELECTION_Container_l8amoq');
                    _model.selectedIndex = 1;
                    safeSetState(() {});
                  },
                  child: Container(
                    height: 30.0,
                    constraints: BoxConstraints(
                      minWidth: 56.0,
                    ),
                    decoration: BoxDecoration(
                      color: _model.selectedIndex == 1
                          ? FlutterFlowTheme.of(context).accent2
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Builder(
                      builder: (context) {
                        if (_model.selectedIndex == 1) {
                          return Text(
                            'Verify',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'MonaSans',
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                ),
                          );
                        } else {
                          return Text(
                            'Verify',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'MonaSans',
                                  letterSpacing: 0.0,
                                ),
                          );
                        }
                      },
                    ),
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    logFirebaseEvent(
                        'SCANNER_EVENT_SELECTION_Container_6cr6xe');
                    _model.selectedIndex = 2;
                    safeSetState(() {});
                  },
                  child: Container(
                    height: 30.0,
                    constraints: BoxConstraints(
                      minWidth: 56.0,
                    ),
                    decoration: BoxDecoration(
                      color: _model.selectedIndex == 2
                          ? FlutterFlowTheme.of(context).accent2
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Builder(
                      builder: (context) {
                        if (_model.selectedIndex == 2) {
                          return Text(
                            'Out',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'MonaSans',
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                ),
                          );
                        } else {
                          return Text(
                            'Out',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'MonaSans',
                                  letterSpacing: 0.0,
                                ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Flexible(
          child: Align(
            alignment: AlignmentDirectional(1.0, 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                logFirebaseEvent('SCANNER_EVENT_SELECTION_Icon_hag2tma7_ON');
                await showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  useSafeArea: true,
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: MediaQuery.viewInsetsOf(context),
                      child: ScannerLogBottomSheetWidget(),
                    );
                  },
                ).then((value) => safeSetState(() {}));
              },
              child: Icon(
                FFIcons.kicAvgPace,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 30.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

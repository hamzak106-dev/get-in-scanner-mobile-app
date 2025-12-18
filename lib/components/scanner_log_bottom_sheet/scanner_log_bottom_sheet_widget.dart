import '../../custom_code/actions/init_power_sync.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/components/scanner_log_card/scanner_log_card_widget.dart';
import '/components/search_text_field/search_text_field_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'scanner_log_bottom_sheet_model.dart';
export 'scanner_log_bottom_sheet_model.dart';

class ScannerLogBottomSheetWidget extends StatefulWidget {
  const ScannerLogBottomSheetWidget({super.key});

  @override
  State<ScannerLogBottomSheetWidget> createState() =>
      _ScannerLogBottomSheetWidgetState();
}

class _ScannerLogBottomSheetWidgetState
    extends State<ScannerLogBottomSheetWidget> {
  late ScannerLogBottomSheetModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ScannerLogBottomSheetModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('SCANNER_LOG_BOTTOM_SHEET_ScannerLogBotto');
      await actions.watchAuthorisedCheckInLogs(
        (result) async {
          _model.logs = result!.toList().cast<CheckInLogsRow>();
          safeSetState(() {});
        },
        functions
            .parseEventRow(FFAppState().selectedEvent.toList())
            .map((e) => e.eventId)
            .toList()
            .toList()
      );
      await actions.watchAuthorisedAttendees(
        (result) async {
          _model.attendee = result!.toList().cast<AttendeeRow>();
          safeSetState(() {});
        },
        functions
            .parseEventRow(FFAppState().selectedEvent.toList())
            .map((e) => e.eventId)
            .toList()
            .toList(),
        false,
        AccessPermission.scan,
      );
    });
  }

  @override
  void dispose() {
    _model.maybeDispose();
    actions.cancelSubscription(attendeesSubscription);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Align(
              alignment: AlignmentDirectional(1.0, 0.0),
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  logFirebaseEvent('SCANNER_LOG_BOTTOM_SHEET_Text_6a3vo1kg_O');
                  Navigator.pop(context);
                },
                child: Text(
                  'Close',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'MonaSans',
                        letterSpacing: 0.0,
                      ),
                ),
              ),
            ),
            wrapWithModel(
              model: _model.searchTextFieldModel,
              updateCallback: () => safeSetState(() {}),
              child: SearchTextFieldWidget(
                onChange: () async {
                  logFirebaseEvent('SCANNER_LOG_BOTTOM_SHEET_Container_lbi8t');

                  safeSetState(() {});
                },
              ),
            ),
            Flexible(
              child: Builder(
                builder: (context) {
                  final history = functions
                      .filterCheckInList(
                          _model.logs.toList(),
                          _model.searchTextFieldModel.textController.text,
                          _model.attendee.toList())
                      .toList();

                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: history.length,
                    itemBuilder: (context, historyIndex) {
                      final historyItem = history[historyIndex];
                      return ScannerLogCardWidget(
                        key: Key('Key32i_${historyIndex}_of_${history.length}'),
                        checkInLog: historyItem,
                      );
                    },
                  );
                },
              ),
            ),
          ].divide(SizedBox(height: 20.0)),
        ),
      ),
    );
  }
}

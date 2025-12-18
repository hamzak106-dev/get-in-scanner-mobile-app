import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/components/count_details_card/count_details_card_widget.dart';
import '/components/event_card/event_card_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'admin_summary_model.dart';
export 'admin_summary_model.dart';

class AdminSummaryWidget extends StatefulWidget {
  const AdminSummaryWidget({super.key});

  @override
  State<AdminSummaryWidget> createState() => _AdminSummaryWidgetState();
}

class _AdminSummaryWidgetState extends State<AdminSummaryWidget> {
  late AdminSummaryModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AdminSummaryModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('ADMIN_SUMMARY_AdminSummary_ON_INIT_STATE');
      await actions.watchEventsLists(
        (result) async {
          _model.eventListResponse = await actions.getEventsList(
            result?.toList(),
          );
          _model.events = _model.eventListResponse!.toList().cast<EventsRow>();
          safeSetState(() {});
          await actions.watchAttendeeLists(
            (result) async {
              _model.attendeeResponse = await actions.getAttendeeList(
                result?.toList(),
              );
              _model.attendees =
                  _model.attendeeResponse!.toList().cast<AttendeeRow>();
              safeSetState(() {});
            },
            _model.events.map((e) => e.eventId).toList().toList(),
            true,
          );
          await actions.watchCheckInLogLists(
            (result) async {
              _model.logsResponse = await actions.getCheckInLogsList(
                result?.toList(),
              );
              _model.logs =
                  _model.logsResponse!.toList().cast<CheckInLogsRow>();
              safeSetState(() {});
            },
            _model.events.map((e) => e.eventId).toList().toList(),
          );
        },
      );
    });
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          GridView(
            padding: EdgeInsets.zero,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20.0,
              mainAxisSpacing: 20.0,
              childAspectRatio: 1.23,
            ),
            primary: false,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: [
              wrapWithModel(
                model: _model.countDetailsCardModel1,
                updateCallback: () => safeSetState(() {}),
                child: CountDetailsCardWidget(
                  icon: Icon(
                    FFIcons.kicCheckFillCircle,
                    color: FlutterFlowTheme.of(context).success,
                    size: 24.0,
                  ),
                  count: _model.attendees
                      .where((e) => e.status == ScanResult.CHECK_IN.name)
                      .toList()
                      .length,
                  lable: 'Checked In',
                ),
              ),
              wrapWithModel(
                model: _model.countDetailsCardModel2,
                updateCallback: () => safeSetState(() {}),
                child: CountDetailsCardWidget(
                  icon: Icon(
                    FFIcons.kicFillQuestion,
                    color: FlutterFlowTheme.of(context).error,
                    size: 24.0,
                  ),
                  count: _model.attendees
                      .where((e) =>
                          (e.status == ScanResult.CHECK_OUT.name) ||
                          (e.status == null || e.status == ''))
                      .toList()
                      .length,
                  lable: 'Absent',
                ),
              ),
              wrapWithModel(
                model: _model.countDetailsCardModel3,
                updateCallback: () => safeSetState(() {}),
                child: CountDetailsCardWidget(
                  icon: Icon(
                    FFIcons.kicFillUser,
                    color: FlutterFlowTheme.of(context).warning,
                    size: 24.0,
                  ),
                  count: _model.attendees.length,
                  lable: 'Total Attendees',
                ),
              ),
              wrapWithModel(
                model: _model.countDetailsCardModel4,
                updateCallback: () => safeSetState(() {}),
                child: CountDetailsCardWidget(
                  icon: Icon(
                    FFIcons.kicCompare,
                    color: FlutterFlowTheme.of(context).accent3,
                    size: 24.0,
                  ),
                  count: _model.logs.length,
                  lable: 'Device Scans',
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: 40.0,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              borderRadius: BorderRadius.circular(6.0),
            ),
            alignment: AlignmentDirectional(-1.0, 0.0),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
              child: Text(
                'Events',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'MonaSans',
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ),
          Builder(
            builder: (context) {
              final event = _model.events.toList();

              return ListView.builder(
                padding: EdgeInsets.zero,
                primary: false,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: event.length,
                itemBuilder: (context, eventIndex) {
                  final eventItem = event[eventIndex];
                  return EventCardWidget(
                    key: Key('Key2a0_${eventIndex}_of_${event.length}'),
                    event: eventItem,
                    onTap: () async {
                      logFirebaseEvent(
                          'ADMIN_SUMMARY_Container_2a0ztasb_CALLBAC');

                      context.pushNamed(
                        EventSummaryScreenWidget.routeName,
                        queryParameters: {
                          'event': serializeParam(
                            eventItem,
                            ParamType.SupabaseRow,
                          ),
                        }.withoutNulls,
                      );
                    },
                  );
                },
              );
            },
          ),
          SizedBox(height: 45,),
        ].divide(SizedBox(height: 30.0)),
      ),
    );
  }
}

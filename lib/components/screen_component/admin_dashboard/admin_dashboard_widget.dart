import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:g_e_t_i_n_scanner/components/card_scanning/card_scanning_widget.dart'
    show CardScanningWidget;
import 'package:g_e_t_i_n_scanner/custom_code/actions/index.dart';
import 'package:provider/provider.dart';

import '/backend/supabase/supabase.dart';
import '/components/event_card/event_card_widget.dart';
import '/components/sync/sync_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/random_data_util.dart' as random_data;
import '/index.dart';
import '/shimmer/shimmer_event_card/shimmer_event_card_widget.dart';
import '../../../custom_code/actions/init_power_sync.dart';
import '../../no_event_found/no_event_found_widget.dart';
import 'admin_dashboard_model.dart';

export 'admin_dashboard_model.dart';

class AdminDashboardWidget extends StatefulWidget {
  const AdminDashboardWidget({super.key});

  @override
  State<AdminDashboardWidget> createState() => _AdminDashboardWidgetState();
}

class _AdminDashboardWidgetState extends State<AdminDashboardWidget> {
  late AdminDashboardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AdminDashboardModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('ADMIN_DASHBOARD_AdminDashboard_ON_INIT_S');
      await actions.watchEventsLists(
        (result) async {
          _model.eventListResponse = await actions.getEventsList(
            result?.toList(),
          );
          _model.events = _model.eventListResponse!.toList().cast<EventsRow>();
          safeSetState(() {});
          FFAppState().selectedEvent = functions
              .parseRowToJson(_model.eventListResponse?.toList(), null)
              .toList()
              .cast<dynamic>();
          safeSetState(() {});
        },
      );
      if (isiOS && !FFAppState().tapToPayTutorialDone) {
        actions.getPosEventId().then((posEventId) async {
          if (posEventId == null) return;
          log(posEventId.toString());
          await context.pushNamed(TapToPayDocumentWidget.routeName);
          await showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) {
                return CardScanningWidget(eventId: posEventId);
              });
          FFAppState().tapToPayTutorialDone = true;
          FFAppState().update(() {});
        }).catchError((e) {
          log(e.toString());
        });
      }
    });
  }

  @override
  void dispose() {
    _model.maybeDispose();
    cancelSubscription(eventsSubscription);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello ${FFAppState().user.user.firstName}',
                      style:
                          FlutterFlowTheme.of(context).headlineSmall.override(
                                fontFamily: 'MonaSans',
                                fontSize: 22.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    Text(
                      'Here are the latest Updates',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'MonaSans',
                            letterSpacing: 0.0,
                          ),
                    ),
                  ].divide(SizedBox(height: 2.0)),
                ),
              ),
              wrapWithModel(
                model: _model.syncModel,
                updateCallback: () => safeSetState(() {}),
                child: SyncWidget(),
              ),
            ],
          ),
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: double.infinity,
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    alignment: AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
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
                      if (FFAppState().syncStatus.downloading &&
                          !(_model.events.isNotEmpty)) {
                        return Builder(
                          builder: (context) {
                            final evnt = List.generate(
                                random_data.randomInteger(6, 6),
                                (index) =>
                                    random_data.randomInteger(0, 100)).toList();

                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: evnt.length,
                              itemBuilder: (context, evntIndex) {
                                final evntItem = evnt[evntIndex];
                                return ShimmerEventCardWidget(
                                  key: Key(
                                      'Key5nd_${evntIndex}_of_${evnt.length}'),
                                );
                              },
                            );
                          },
                        );
                      } else {
                        return Builder(
                          builder: (context) {
                            final event = _model.events.toList();
                            if (event.isEmpty) {
                              return Center(
                                child: NoEventFoundWidget(),
                              );
                            }

                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              primary: false,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: event.length,
                              itemBuilder: (context, eventIndex) {
                                final eventItem = event[eventIndex];
                                return EventCardWidget(
                                  key: Key(
                                      'Keycca_${eventIndex}_of_${event.length}'),
                                  event: eventItem,
                                  onTap: () async {
                                    logFirebaseEvent(
                                        'ADMIN_DASHBOARD_Container_ccamfehr_CALLB');

                                    context.pushNamed(
                                      AttendeesScreenWidget.routeName,
                                      queryParameters: {
                                        'eventId': serializeParam(
                                          eventItem.eventId,
                                          ParamType.int,
                                        ),
                                      }.withoutNulls,
                                    );
                                  },
                                );
                              },
                            );
                          },
                        );
                      }
                    },
                  ),
                ].divide(SizedBox(height: 30.0)),
              ),
            ),
          ),
        ].divide(SizedBox(height: 30.0)),
      ),
    );
  }
}

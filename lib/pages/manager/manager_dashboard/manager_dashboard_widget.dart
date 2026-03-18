import 'dart:developer';

import 'package:g_e_t_i_n_scanner/components/card_scanning/card_scanning_widget.dart' show CardScanningWidget;

import '../../../components/sync/sync_widget.dart';
import '../../../custom_code/actions/init_power_sync.dart';
import '/backend/supabase/supabase.dart';
import '/components/choose_event_or_producer/choose_event_or_producer_widget.dart';
import '/components/event_card_for_scanner/event_card_for_scanner_widget.dart';
import '/components/no_event_found/no_event_found_widget.dart';
import '/components/search_text_field/search_text_field_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/shimmer/shimmer_event_card/shimmer_event_card_widget.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/random_data_util.dart' as random_data;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'manager_dashboard_model.dart';
export 'manager_dashboard_model.dart';

class ManagerDashboardWidget extends StatefulWidget {
  const ManagerDashboardWidget({super.key});

  @override
  State<ManagerDashboardWidget> createState() => _ManagerDashboardWidgetState();
}

class _ManagerDashboardWidgetState extends State<ManagerDashboardWidget> {
  late ManagerDashboardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ManagerDashboardModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('MANAGER_DASHBOARD_ManagerDashboard_ON_IN');
      if (FFAppState().selectedProducer.firstName == '') {
        await action_blocks.producerSelectionBlock(context);
        safeSetState(() {});
      }
      await actions.watchEventsForManager(
        FFAppState().selectedProducer.userId,
        (result) async {
          FFAppState().selectedEvent = functions.parseRowToJson(result?.toList(), null).toList().cast<dynamic>();
          FFAppState().update(() {});
          _model.events = result!.toList().cast<EventsRow>();
          _model.isLoading = false;
          safeSetState(() {});
        },
      );
      if (isiOS && !FFAppState().tapToPayTutorialDone) {
        actions.getPosEventId().then((posEventId) async {
          if(posEventId == null) return;
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
    actions.cancelSubscription(eventsSubscription);
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
          Builder(
            builder: (context) {
              if (FFAppState().selectedProducer.firstName != '') {
                return Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    FlutterFlowIconButton(
                      buttonSize: 40.0,
                      icon: Icon(
                        FFIcons.kicFindReplace,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        size: 24.0,
                      ),
                      onPressed: () async {
                        logFirebaseEvent('MANAGER_DASHBOARD_icFindReplace_ICN_ON_T');
                        await action_blocks.producerSelectionBlock(context);
                        _model.events = [];
                        safeSetState(() {});
                        await actions.watchEventsForManager(
                          FFAppState().selectedProducer.userId,
                          (result) async {
                            _model.events = result!.toList().cast<EventsRow>();
                            safeSetState(() {});
                            FFAppState().selectedEvent =
                                functions.parseRowToJson(result.toList(), null).toList().cast<dynamic>();
                            FFAppState().update(() {});
                          },
                        );
                      },
                    ),
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          custom_widgets.ProfilePicWidget(
                            width: 40.0,
                            height: 40.0,
                            profileImg: FFAppState().selectedProducer.profileImg,
                          ),
                          Text(
                            FFAppState().selectedProducer.firstName,
                            style: FlutterFlowTheme.of(context).headlineSmall.override(
                                  fontFamily: 'MonaSans',
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ].divide(SizedBox(width: 12.0)),
                      ),
                    ),
                    wrapWithModel(
                      model: _model.syncModel,
                      updateCallback: () => safeSetState(() {}),
                      child: SyncWidget(),
                    ),
                  ],
                );
              } else {
                return Text(
                  'Select Producer Account',
                  style: FlutterFlowTheme.of(context).headlineSmall.override(
                        fontFamily: 'MonaSans',
                        fontSize: 16.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w500,
                      ),
                );
              }
            },
          ),
          Flexible(
            child: Builder(
              builder: (context) {
                if (FFAppState().selectedProducer.firstName != '') {
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'The Events of \"${valueOrDefault<String>(
                          FFAppState().selectedProducer.firstName,
                          '-',
                        )}\"',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'MonaSans',
                              color: FlutterFlowTheme.of(context).primaryText,
                              fontSize: 16.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: wrapWithModel(
                              model: _model.searchTextFieldModel,
                              updateCallback: () => safeSetState(() {}),
                              child: SearchTextFieldWidget(
                                onChange: () async {
                                  logFirebaseEvent('MANAGER_DASHBOARD_SearchTextField_ON_CHANGE');

                                  final text = _model.searchTextFieldModel.textController.text;

                                  _model.searchTextFieldModel.updates = text;

                                  safeSetState(() {});
                                },
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0.0, 1.0),
                            child: custom_widgets.FilterPopUp(
                              width: 40.0,
                              height: 40.0,
                              onChange: (value) async {
                                logFirebaseEvent('MANAGER_DASHBOARD_FilterPopUp_ON_CHANGE');
                                _model.ascending = value == 0;
                                safeSetState(() {});
                              },
                            ),
                          ),
                        ].divide(const SizedBox(width: 16.0)),
                      ),
                      Expanded(
                        child: Builder(
                          builder: (context) {
                            if (_model.isLoading) {
                              return Builder(
                                builder: (context) {
                                  final evnt = List.generate(
                                          random_data.randomInteger(6, 6), (index) => random_data.randomInteger(0, 100))
                                      .toList();

                                  return ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: evnt.length,
                                    itemBuilder: (context, evntIndex) {
                                      final evntItem = evnt[evntIndex];
                                      return ShimmerEventCardWidget(
                                        key: Key('Keyuox_${evntIndex}_of_${evnt.length}'),
                                      );
                                    },
                                  );
                                },
                              );
                            } else {
                              return Builder(
                                builder: (context) {
                                  final event = (_model.ascending != null
                                          ? (_model.ascending!
                                              ? functions
                                                  .filterEventList(
                                                      _model.events.toList(), _model.searchTextFieldModel.updates)
                                                  .sortedList(keyOf: (e) => e.title, desc: false)
                                              : functions
                                                  .filterEventList(
                                                      _model.events.toList(), _model.searchTextFieldModel.updates)
                                                  .sortedList(keyOf: (e) => e.title, desc: true))
                                          : functions.filterEventList(
                                              _model.events.toList(), _model.searchTextFieldModel.updates))
                                      .toList();
                                  if (event.isEmpty) {
                                    return Center(
                                      child: NoEventFoundWidget(),
                                    );
                                  }

                                  return ListView.separated(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: event.length,
                                    separatorBuilder: (_, __) => SizedBox(height: 16.0),
                                    itemBuilder: (context, eventIndex) {
                                      final eventItem = event[eventIndex];
                                      return wrapWithModel(
                                        model: _model.eventCardForScannerModels.getModel(
                                          eventItem.eventId.toString(),
                                          eventIndex,
                                        ),
                                        updateCallback: () => safeSetState(() {}),
                                        child: EventCardForScannerWidget(
                                          key: Key(
                                            'Key6ss_${eventItem.eventId.toString()}',
                                          ),
                                          event: eventItem,
                                          onTap: () async {
                                            logFirebaseEvent('MANAGER_DASHBOARD_Container_6ssx6ysp_CAL');

                                            context.pushNamed(
                                              AttendeesScreenWidget.routeName,
                                              queryParameters: {
                                                'eventId': serializeParam(
                                                  eventItem.eventId,
                                                  ParamType.int,
                                                ),
                                              }.withoutNulls,
                                            );

                                            // context.pushNamed(
                                            //   PinByManagerWidget.routeName,
                                            //   queryParameters: {
                                            //     'eventId': serializeParam(
                                            //       eventItem.eventId,
                                            //       ParamType.int,
                                            //     ),
                                            //     'producerId': serializeParam(
                                            //       FFAppState()
                                            //           .selectedProducer
                                            //           .userId,
                                            //       ParamType.int,
                                            //     ),
                                            //   }.withoutNulls,
                                            // );
                                          },
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ].divide(SizedBox(height: 24.0)),
                  );
                } else {
                  return wrapWithModel(
                    model: _model.chooseEventOrProducerModel,
                    updateCallback: () => safeSetState(() {}),
                    child: ChooseEventOrProducerWidget(
                      isProducer: true,
                      onSelect: () async {
                        logFirebaseEvent('MANAGER_DASHBOARD_Container_mtm79jov_CAL');
                        await action_blocks.producerSelectionBlock(context);
                        safeSetState(() {});
                        await actions.watchEventsForManager(
                          FFAppState().selectedProducer.userId,
                          (result) async {
                            _model.events = result!.toList().cast<EventsRow>();
                            safeSetState(() {});
                            FFAppState().selectedEvent =
                                functions.parseRowToJson(result.toList(), null).toList().cast<dynamic>();
                            FFAppState().update(() {});
                          },
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ),
        ].divide(SizedBox(height: 30.0)),
      ),
    );
  }
}

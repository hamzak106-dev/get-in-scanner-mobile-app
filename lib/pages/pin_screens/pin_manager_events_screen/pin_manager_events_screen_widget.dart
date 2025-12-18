import '../../../custom_code/actions/init_power_sync.dart';
import '/backend/supabase/supabase.dart';
import '/components/choose_event_or_producer/choose_event_or_producer_widget.dart';
import '/components/event_card_for_scanner/event_card_for_scanner_widget.dart';
import '/components/no_event_found/no_event_found_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/shimmer/shimmer_event_card/shimmer_event_card_widget.dart';
import 'dart:ui';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/random_data_util.dart' as random_data;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'pin_manager_events_screen_model.dart';
export 'pin_manager_events_screen_model.dart';

class PinManagerEventsScreenWidget extends StatefulWidget {
  const PinManagerEventsScreenWidget({super.key});

  static String routeName = 'PinManagerEventsScreen';
  static String routePath = '/pinManagerEventsScreen';

  @override
  State<PinManagerEventsScreenWidget> createState() => _PinManagerEventsScreenWidgetState();
}

class _PinManagerEventsScreenWidgetState extends State<PinManagerEventsScreenWidget> {
  late PinManagerEventsScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PinManagerEventsScreenModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'PinManagerEventsScreen'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('PIN_MANAGER_EVENTS_SCREEN_PinManagerEven');
      await actions.watchEventsForManager(
        FFAppState().selectedProducer.userId,
        (result) async {
          FFAppState().selectedEvent = functions.parseRowToJson(result?.toList(), null).toList().cast<dynamic>();
          FFAppState().update(() {});
          _model.events = result!.toList().cast<EventsRow>();
          safeSetState(() {});
        },
      );
    });
  }

  @override
  void dispose() {
    _model.dispose();
    actions.cancelSubscription(eventsSubscription);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        top: true,
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 30.0,
                    buttonSize: 40.0,
                    icon: Icon(
                      FFIcons.kicArrowBack,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 24.0,
                    ),
                    onPressed: () async {
                      logFirebaseEvent('PIN_MANAGER_EVENTS_SCREEN_icArrowBack_IC');
                      context.safePop();
                    },
                  ),
                  Expanded(
                    child: Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Text(
                        'Select Event',
                        style: FlutterFlowTheme.of(context).titleSmall.override(
                              fontFamily: 'MonaSans',
                              letterSpacing: 0.0,
                            ),
                      ),
                    ),
                  ),
                ].addToEnd(SizedBox(width: 40.0)),
              ),
              Flexible(
                child: Builder(
                  builder: (context) {
                    if (FFAppState().selectedProducer.firstName != null &&
                        FFAppState().selectedProducer.firstName != '') {
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
                          Expanded(
                            child: Builder(
                              builder: (context) {
                                if (!(_model.events.isNotEmpty)) {
                                  return Builder(
                                    builder: (context) {
                                      final evnt = List.generate(random_data.randomInteger(6, 6),
                                          (index) => random_data.randomInteger(0, 100)).toList();

                                      return ListView.builder(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: evnt.length,
                                        itemBuilder: (context, evntIndex) {
                                          final evntItem = evnt[evntIndex];
                                          return ShimmerEventCardWidget(
                                            key: Key('Keyn7f_${evntIndex}_of_${evnt.length}'),
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
                                                'Key2f1_${eventItem.eventId.toString()}',
                                              ),
                                              event: eventItem,
                                              onTap: () async {
                                                logFirebaseEvent('PIN_MANAGER_EVENTS_SCREEN_Container_2f1m');

                                                context.pushNamed(
                                                  PinByManagerWidget.routeName,
                                                  queryParameters: {
                                                    'eventId': serializeParam(
                                                      eventItem.eventId,
                                                      ParamType.int,
                                                    ),
                                                    'producerId': serializeParam(
                                                      FFAppState().selectedProducer.userId,
                                                      ParamType.int,
                                                    ),
                                                  }.withoutNulls,
                                                );
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
                            logFirebaseEvent('PIN_MANAGER_EVENTS_SCREEN_Container_7uir');
                            await action_blocks.producerSelectionBlock(context);
                            safeSetState(() {});
                            await actions.watchEventsForManager(
                              FFAppState().selectedProducer.userId,
                              (result) async {
                                _model.events = result!.toList().cast<EventsRow>();
                                safeSetState(() {});
                                FFAppState().selectedEvent =
                                    functions.parseRowToJson(result?.toList(), null).toList().cast<dynamic>();
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
        ),
      ),
    );
  }
}

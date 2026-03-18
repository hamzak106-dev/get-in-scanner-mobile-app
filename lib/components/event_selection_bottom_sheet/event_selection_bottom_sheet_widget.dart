import '../../custom_code/actions/init_power_sync.dart';
import '../no_event_found/no_event_found_widget.dart';
import '/components/loading_with_message/loading_with_message_widget.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/components/event_card_for_scanner/event_card_for_scanner_widget.dart';
import '/components/rive_animation_view/rive_animation_view_widget.dart';
import '/components/search_text_field/search_text_field_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'event_selection_bottom_sheet_model.dart';
export 'event_selection_bottom_sheet_model.dart';

class EventSelectionBottomSheetWidget extends StatefulWidget {
  const EventSelectionBottomSheetWidget({super.key});

  @override
  State<EventSelectionBottomSheetWidget> createState() =>
      _EventSelectionBottomSheetWidgetState();
}

class _EventSelectionBottomSheetWidgetState
    extends State<EventSelectionBottomSheetWidget> {
  late EventSelectionBottomSheetModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EventSelectionBottomSheetModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('EVENT_SELECTION_BOTTOM_SHEET_EventSelect');
      await actions.watchAuthorisedEvents(
        (results) async {
          _model.eventResponse = await actions.getEventsList(
            results?.toList(),
          );
          _model.events = _model.eventResponse!.toList().cast<EventsRow>();
          safeSetState(() {});
        },
      );
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 50.0,
          sigmaY: 50.0,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xE50E0F11),
            boxShadow: [
              BoxShadow(
                blurRadius: 50.0,
                color: Color(0x33000000),
              )
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                logFirebaseEvent('EVENT_SELECTION_BOTTOM_SHEET_Column_6qmj');
                await actions.unfocusFields(
                  context,
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Container(
                      width: 110.0,
                      height: 6.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).tertiary,
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (false)
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            logFirebaseEvent(
                                'EVENT_SELECTION_BOTTOM_SHEET_Icon_kwgo5x');
                            context.safePop();
                          },
                          child: Icon(
                            FFIcons.kicArrowBack,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 30.0,
                          ),
                        ),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          height: 52.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).tertiary,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4.0,
                                color: Color(0x26000000),
                                offset: Offset(
                                  1.0,
                                  1.0,
                                ),
                                spreadRadius: 0.0,
                              )
                            ],
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      logFirebaseEvent(
                                          'EVENT_SELECTION_BOTTOM_SHEET_Container_v');
                                      _model.upcoming = true;
                                      safeSetState(() {});
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: _model.upcoming
                                            ? FlutterFlowTheme.of(context)
                                                .secondary
                                            : Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        shape: BoxShape.rectangle,
                                      ),
                                      alignment:
                                           AlignmentDirectional(0.0, 0.0),
                                      child: Text(
                                        'Upcoming',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'MonaSans',
                                              color: _model.upcoming
                                                  ? FlutterFlowTheme.of(context)
                                                      .primaryBackground
                                                  : Color(0xFF6B6D75),
                                              fontSize: 16.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      logFirebaseEvent(
                                          'EVENT_SELECTION_BOTTOM_SHEET_Container_c');
                                      _model.upcoming = false;
                                      safeSetState(() {});
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: !_model.upcoming
                                            ? FlutterFlowTheme.of(context)
                                                .secondary
                                            : Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        shape: BoxShape.rectangle,
                                      ),
                                      alignment:
                                           AlignmentDirectional(0.0, 0.0),
                                      child: Text(
                                        'Past',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'MonaSans',
                                              color: !_model.upcoming
                                                  ? FlutterFlowTheme.of(context)
                                                      .primaryBackground
                                                  : Color(0xFF6B6D75),
                                              fontSize: 16.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ].divide(SizedBox(width: 6.0)),
                            ),
                          ),
                        ),
                      ),
                      if (false)
                        FlutterFlowDropDown<String>(
                          controller: _model.dropDownValueController ??=
                              FormFieldController<String>(
                            _model.dropDownValue ??= 'All',
                          ),
                          options: ['All', 'Events', 'Sessions'],
                          onChanged: (val) =>
                              safeSetState(() => _model.dropDownValue = val),
                          width: 116.0,
                          height: 40.0,
                          textStyle:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'MonaSans',
                                    letterSpacing: 0.0,
                                  ),
                          icon: Icon(
                            FFIcons.kicDown,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 24.0,
                          ),
                          fillColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          elevation: 4.0,
                          borderColor: Colors.transparent,
                          borderWidth: 0.0,
                          borderRadius: 5.0,
                          margin: EdgeInsetsDirectional.fromSTEB(
                              16.0, 12.0, 6.0, 12.0),
                          hidesUnderline: true,
                          isOverButton: false,
                          isSearchable: false,
                          isMultiSelect: false,
                        ),
                    ],
                  ),
                  wrapWithModel(
                    model: _model.searchTextFieldModel,
                    updateCallback: () => safeSetState(() {}),
                    child: SearchTextFieldWidget(
                      onChange: () async {
                        logFirebaseEvent(
                            'EVENT_SELECTION_BOTTOM_SHEET_Container_i');

                        safeSetState(() {});
                      },
                    ),
                  ),
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        if (_model.events.isNotEmpty) {
                        var utcDate = DateTime.fromMillisecondsSinceEpoch(
                                getCurrentTimestamp.secondsSinceEpoch * 1000)
                            .toUtc();
                        return Builder(
                          builder: (context) {

                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Builder(
                                      builder: (context) {
                                        final event = functions
                                            .filterEventList(
                                            _model.events
                                                    .where((e) => _model.upcoming
                                                        ? (e.endDate.secondsSinceEpoch >
                                                            utcDate
                                                                .secondsSinceEpoch) // For upcoming events: end date must be in the future
                                                        : (e.endDate.secondsSinceEpoch <=
                                                            utcDate
                                                                .secondsSinceEpoch)) // For past events: end date must be in the past or present
                                                    .toList(),
                                                _model.searchTextFieldModel.textController.text)
                                            .toList();

                                        if (event.isEmpty) {
                                          return const Center(
                                            child: NoEventFoundWidget(),
                                          );
                                        }
                                        return ListView.separated(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount: event.length,
                                          separatorBuilder: (_, __) =>
                                              const SizedBox(height: 16.0),
                                          itemBuilder: (context, eventIndex) {
                                            final EventsRow eventItem =
                                                event[eventIndex];
                                            return EventCardForScannerWidget(
                                              key: Key(
                                                  'Key7om_${eventIndex}_of_${event.length}'),
                                              event: eventItem,
                                              onTap: () async {
                                                logFirebaseEvent(
                                                    'EVENT_SELECTION_BOTTOM_SHEET_Container_7');
                                                FFAppState().selectedEvent =
                                                    functions
                                                        .parseRowToJson(
                                                            _model.emptyList
                                                                .toList(),
                                                            eventItem)
                                                        .toList()
                                                        .cast<dynamic>();
                                                FFAppState().update(() {});
                                                Navigator.pop(
                                                    context, eventItem);
                                              },
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  FFButtonWidget(
                                    onPressed: () async {
                                      logFirebaseEvent(
                                          'EVENT_SELECTION_BOTTOM_SHEET_UNSET_EVENT');
                                      FFAppState().selectedEvent = [];
                                      FFAppState().update(() {});
                                      Navigator.pop(context);
                                    },
                                    text: 'Unset Event',
                                    icon: const Icon(
                                      FFIcons.kicCloseCircle,
                                      size: 15.0,
                                      color: Colors.white,
                                    ),
                                    options: FFButtonOptions(
                                      width: double.infinity,
                                      height: 52.0,
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              16.0, 0.0, 16.0, 0.0),
                                      iconPadding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily: 'MonaSans',
                                            color: Colors.white,
                                            fontSize: 14.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.normal,
                                            shadows: [
                                              const Shadow(
                                                color: Color(0x0D000000),
                                                offset: Offset(0.0, -5.0),
                                                blurRadius: 10.0,
                                              )
                                            ],

                                          ),
                                      elevation: 0.0,
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                  ),
                                ],
                              );

                          },
                        );
                        } else {
                          return const Center(
                            child: NoEventFoundWidget(),
                          );
                        }
                      },
                    ),
                  ),
                ].divide(SizedBox(height: 16.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

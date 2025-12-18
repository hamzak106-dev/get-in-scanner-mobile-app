import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/components/event_card_for_pin/event_card_for_pin_widget.dart';
import '/components/rive_animation_view/rive_animation_view_widget.dart';
import '/components/search_text_field/search_text_field_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'pin_event_selection_bottom_sheet_model.dart';
export 'pin_event_selection_bottom_sheet_model.dart';

class PinEventSelectionBottomSheetWidget extends StatefulWidget {
  const PinEventSelectionBottomSheetWidget({super.key});

  @override
  State<PinEventSelectionBottomSheetWidget> createState() => _PinEventSelectionBottomSheetWidgetState();
}

class _PinEventSelectionBottomSheetWidgetState extends State<PinEventSelectionBottomSheetWidget> {
  late PinEventSelectionBottomSheetModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PinEventSelectionBottomSheetModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('PIN_EVENT_SELECTION_BOTTOM_SHEET_PinEven');
      _model.userEvents = await EventsTable().queryRows(
        queryFn: (q) => q
            .eqOrNull(
              'creator_user',
              FFAppState().user.userId,
            )
            .gt('end_date', DateTime.now()),
      );
      _model.events = _model.userEvents!.toList().cast<EventsRow>();
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
    context.watch<FFAppState>();

    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 50.0,
          sigmaY: 50.0,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFF7F7F7),
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
                logFirebaseEvent('PIN_EVENT_SELECTION_BOTTOM_SHEET_Column_');
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
                        color: Color(0xFFDADBDD),
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                    ),
                  ),
                  wrapWithModel(
                    model: _model.searchTextFieldModel,
                    updateCallback: () => safeSetState(() {}),
                    child: SearchTextFieldWidget(
                      isLight: true,
                      onChange: () async {
                        logFirebaseEvent('PIN_EVENT_SELECTION_BOTTOM_SHEET_Contain');

                        safeSetState(() {});
                      },
                    ),
                  ),
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        if (_model.events.isNotEmpty) {
                          return Builder(
                            builder: (context) {
                              final event = functions
                                  .filterEventList(
                                      _model.events.toList(), _model.searchTextFieldModel.textController.text)
                                  .toList();

                              return ListView.separated(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: event.length,
                                separatorBuilder: (_, __) => SizedBox(height: 16.0),
                                itemBuilder: (context, eventIndex) {
                                  final eventItem = event[eventIndex];
                                  return wrapWithModel(
                                    model: _model.eventCardForPinModels.getModel(
                                      eventItem.eventId.toString(),
                                      eventIndex,
                                    ),
                                    updateCallback: () => safeSetState(() {}),
                                    child: EventCardForPinWidget(
                                      key: Key(
                                        'Key4px_${eventItem.eventId.toString()}',
                                      ),
                                      event: eventItem,
                                      onTap: () async {
                                        logFirebaseEvent('PIN_EVENT_SELECTION_BOTTOM_SHEET_Contain');
                                        Navigator.pop(context, eventItem);
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        } else {
                          return wrapWithModel(
                            model: _model.riveAnimationViewModel,
                            updateCallback: () => safeSetState(() {}),
                            child: RiveAnimationViewWidget(
                              fillColor: Colors.transparent,
                              type: RiveAnimType.EventSyncing,
                            ),
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

import '../../../custom_code/actions/init_power_sync.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/components/choose_event_or_producer/choose_event_or_producer_widget.dart';
import '/components/rive_animation_view/rive_animation_view_widget.dart';
import '/components/screen_component/scanner_summary/scanner_summary_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'manager_summary_model.dart';
export 'manager_summary_model.dart';

class ManagerSummaryWidget extends StatefulWidget {
  const ManagerSummaryWidget({super.key});

  @override
  State<ManagerSummaryWidget> createState() => _ManagerSummaryWidgetState();
}

class _ManagerSummaryWidgetState extends State<ManagerSummaryWidget> {
  late ManagerSummaryModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ManagerSummaryModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('MANAGER_SUMMARY_ManagerSummary_ON_INIT_S');
      await actions.watchEventsForManager(
        FFAppState().selectedProducer.userId,
        (result) async {
          _model.events = result!.toList().cast<EventsRow>();
          safeSetState(() {});
          FFAppState().selectedEvent = functions
              .parseRowToJson(result.toList(), null)
              .toList()
              .cast<dynamic>();
          FFAppState().update(() {});
        },
      );
    });
  }

  @override
  void dispose() {
    _model.maybeDispose();
    actions.cancelSubscription(eventsSubscription);
    actions.cancelSubscription(attendeesSubscription);
    actions.cancelSubscription(byPinSubscription);
    actions.cancelSubscription(byTicketSubscription);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Builder(
      builder: (context) {
        if (FFAppState().selectedProducer.firstName != '') {
          return Builder(
            builder: (context) {
              if (_model.events.isNotEmpty) {
                return wrapWithModel(
                  model: _model.scannerSummaryModel,
                  updateCallback: () => safeSetState(() {}),
                  child: ScannerSummaryWidget(
                    event: _model.events,
                  ),
                );
              } else {
                return wrapWithModel(
                  model: _model.riveAnimationViewModel,
                  updateCallback: () => safeSetState(() {}),
                  child: RiveAnimationViewWidget(
                    type: RiveAnimType.AvatarSyncing,
                    fillColor: Colors.transparent,
                  ),
                );
              }
            },
          );
        } else {
          return wrapWithModel(
            model: _model.chooseEventOrProducerModel,
            updateCallback: () => safeSetState(() {}),
            child: ChooseEventOrProducerWidget(
              isProducer: true,
              onSelect: () async {
                logFirebaseEvent('MANAGER_SUMMARY_Container_0gscgpa4_CALLB');
                await action_blocks.producerSelectionBlock(context);
                safeSetState(() {});
              },
            ),
          );
        }
      },
    );
  }
}

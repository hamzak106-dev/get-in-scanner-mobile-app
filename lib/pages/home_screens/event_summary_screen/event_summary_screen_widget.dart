import '../../../custom_code/actions/cancel_subscription.dart' as actions;
import '../../../custom_code/actions/init_power_sync.dart';
import '/backend/supabase/supabase.dart';
import '/components/screen_component/scanner_summary/scanner_summary_widget.dart';
import '/components/sync/sync_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'event_summary_screen_model.dart';
export 'event_summary_screen_model.dart';

class EventSummaryScreenWidget extends StatefulWidget {
  const EventSummaryScreenWidget({
    super.key,
    required this.event,
  });

  final EventsRow? event;

  static String routeName = 'EventSummaryScreen';
  static String routePath = '/eventSummaryScreen';

  @override
  State<EventSummaryScreenWidget> createState() =>
      _EventSummaryScreenWidgetState();
}

class _EventSummaryScreenWidgetState extends State<EventSummaryScreenWidget> {
  late EventSummaryScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EventSummaryScreenModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'EventSummaryScreen'});
  }

  @override
  void dispose() {
    _model.dispose();
    actions.cancelSubscription(attendeesSubscription);
    actions.cancelSubscription(byPinSubscription);
    actions.cancelSubscription(byTicketSubscription);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      logFirebaseEvent(
                          'EVENT_SUMMARY_SCREEN_Icon_qr5e0bsi_ON_TA');
                      context.safePop();
                    },
                    child: Icon(
                      FFIcons.kicArrowBack,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      size: 30.0,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      widget.event!.title,
                      style: FlutterFlowTheme.of(context).titleLarge.override(
                            fontFamily: 'MonaSans',
                            fontSize: 22.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  wrapWithModel(
                    model: _model.syncModel,
                    updateCallback: () => safeSetState(() {}),
                    child: SyncWidget(),
                  ),
                ].divide(SizedBox(width: 6.0)),
              ),
              Flexible(
                child: wrapWithModel(
                  model: _model.scannerSummaryModel,
                  updateCallback: () => safeSetState(() {}),
                  child: ScannerSummaryWidget(
                    event: functions.convertObjectList(widget.event!),
                  ),
                ),
              ),
            ].divide(SizedBox(height: 20.0)),
          ),
        ),
      ),
    );
  }
}

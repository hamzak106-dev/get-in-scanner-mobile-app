import 'package:g_e_t_i_n_scanner/components/sync/sync__widget_2.dart';
import 'package:g_e_t_i_n_scanner/custom_code/actions/index.dart';

import '../../../custom_code/actions/init_power_sync.dart';
import '/backend/schema/enums/enums.dart';
import '/components/screen_component/admin_summary/admin_summary_widget.dart';
import '/components/screen_component/manager_summary/manager_summary_widget.dart';
import '/components/screen_component/scanner_summary/scanner_summary_widget.dart';
import '/components/sync/sync_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'summary_screen_model.dart';
export 'summary_screen_model.dart';

class SummaryScreenWidget extends StatefulWidget {
  const SummaryScreenWidget({super.key});

  static String routeName = 'SummaryScreen';
  static String routePath = '/summaryScreen';

  @override
  State<SummaryScreenWidget> createState() => _SummaryScreenWidgetState();
}

class _SummaryScreenWidgetState extends State<SummaryScreenWidget> {
  late SummaryScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SummaryScreenModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'SummaryScreen'});
  }

  @override
  void dispose() {
    _model.dispose();
    debugPrint("Disposing Summary");
    cancelSubscription(eventsSubscription);
    cancelSubscription(checkInLogsSubscription);
    cancelSubscription(attendeesSubscription);
    cancelSubscription(byPinSubscription);
    cancelSubscription(byTicketSubscription);
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
          padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'SUMMARY',
                    style: FlutterFlowTheme.of(context).titleLarge.override(
                      fontFamily: 'Mona Sans',
                      fontSize: 22.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  wrapWithModel(
                    model: _model.syncModel,
                    updateCallback: () => safeSetState(() {}),
                    child: SyncWidget2(),
                  ),
                ].divide(SizedBox(width: 10.0)),
              ),
              Flexible(
                child: Builder(
                  builder: (context) {
                    if ((FFAppState().user.profile == Profile.admin) ||
                        (FFAppState().user.profile == Profile.producer)) {
                      return wrapWithModel(
                        model: _model.adminSummaryModel,
                        updateCallback: () => safeSetState(() {}),
                        child: AdminSummaryWidget(),
                      );
                    } else if (FFAppState().user.profile == Profile.manager) {
                      return wrapWithModel(
                        model: _model.managerSummaryModel,
                        updateCallback: () => safeSetState(() {}),
                        child: ManagerSummaryWidget(),
                      );
                    } else if (FFAppState().selectedEvent.length == 1) {
                      return wrapWithModel(
                        model: _model.scannerSummaryModel,
                        updateCallback: () => safeSetState(() {}),
                        child: ScannerSummaryWidget(
                          event: functions.parseEventRow(
                              FFAppState().selectedEvent.toList()),
                        ),
                      );
                    } else {
                      return Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              40.0, 0.0, 40.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                FFAppState().user.profile == Profile.manager
                                    ? 'Choose Producer'
                                    : 'Choose an Event',
                                style: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'MonaSans',
                                      letterSpacing: 0.0,
                                    ),
                              ),
                              Text(
                                FFAppState().user.profile == Profile.manager
                                    ? 'Please go to the Lookup tab and select a producer to see the stats.'
                                    : 'Please go to the Lookup tab and select an event to see the stats.',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'MonaSans',
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ].divide(SizedBox(height: 12.0)),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
              SizedBox(height: 15,),
            ].divide(SizedBox(height: 20.0)),
          ),
        ),
      ),
    );
  }
}

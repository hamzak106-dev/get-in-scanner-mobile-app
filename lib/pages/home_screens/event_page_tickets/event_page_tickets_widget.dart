import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:g_e_t_i_n_scanner/components/event_page_components/event_title/event_title_widget.dart'
    show EventTitleWidget;
import 'package:g_e_t_i_n_scanner/components/event_page_components/quantity/quantity_widget.dart'
    show QuantityWidget;
import 'package:g_e_t_i_n_scanner/components/ticket_category/ticket_category_widget.dart'
    show TicketCategoryWidget;

import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'event_page_tickets_model.dart';

export 'event_page_tickets_model.dart';

class EventPageTicketsWidget extends StatefulWidget {
  final int eventId;

  const EventPageTicketsWidget({super.key, required this.eventId});

  static String routeName = 'eventPageTickets';
  static String routePath = '/eventPageTickets/:event_id';

  @override
  State<EventPageTicketsWidget> createState() => _EventPageTicketsWidgetState();
}

class _EventPageTicketsWidgetState extends State<EventPageTicketsWidget> {
  late EventPageTicketsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EventPageTicketsModel());
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      // await actions.QuickPay().initTerminal( widget.eventId);
    });

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'eventPageTickets'});
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 20.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      wrapWithModel(
                        model: _model.eventTitleModel,
                        updateCallback: () => safeSetState(() {}),
                        child: EventTitleWidget(),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-1.0, 0.0),
                        child: wrapWithModel(
                          model: _model.ticketCategoryModel1,
                          updateCallback: () => safeSetState(() {}),
                          child: TicketCategoryWidget(),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-1.0, 0.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 16.0, 0.0, 0.0),
                          child: wrapWithModel(
                            model: _model.ticketCategoryModel2,
                            updateCallback: () => safeSetState(() {}),
                            child: TicketCategoryWidget(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 24.0, 0.0, 24.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            logFirebaseEvent(
                                'EVENT_PAGE_TICKETS_PAGE_NEXT_BTN_ON_TAP');
                            await showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              enableDrag: false,
                              context: context,
                              builder: (context) {
                                return GestureDetector(
                                  onTap: () {
                                    FocusScope.of(context).unfocus();
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  },
                                  child: SingleChildScrollView(child: QuantityWidget()),
                                );
                              },
                            ).then((value) => safeSetState(() {}));
                          },
                          text: 'NEXT',
                          options: FFButtonOptions(
                            height: 48.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: Color(0xFF0E0F11),
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: 'Mona Sans',
                                  color: Colors.white,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                ),
                            elevation: 0.0,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.85, -0.98),
                child: FlutterFlowIconButton(
                  borderRadius: 50.0,
                  buttonSize: 40.0,
                  fillColor: Color(0x66FFFFFF),
                  icon: Icon(
                    FFIcons.kicArrowLeftRound,
                    color: FlutterFlowTheme.of(context).secondary,
                    size: 20.0,
                  ),
                  onPressed: () {
                    print('IconButton pressed ...');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

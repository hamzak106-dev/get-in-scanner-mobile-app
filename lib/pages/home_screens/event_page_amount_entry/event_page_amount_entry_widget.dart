import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:g_e_t_i_n_scanner/components/amount_entry/amount_entry_widget.dart';
import 'package:g_e_t_i_n_scanner/components/event_page_components/event_title/event_title_widget.dart'
    show EventTitleWidget;

import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'event_page_amount_entry_model.dart';

export 'event_page_amount_entry_model.dart';

class EventPageAmountEntryWidget extends StatefulWidget {
  final int eventId;

  const EventPageAmountEntryWidget({super.key, required this.eventId});

  static String routeName = 'EventPageAmountEntry';
  static String routePath = '/EventPageAmountEntry/:event_id';

  @override
  State<EventPageAmountEntryWidget> createState() =>
      _EventPageAmountEntryWidgetState();
}

class _EventPageAmountEntryWidgetState
    extends State<EventPageAmountEntryWidget> {
  late EventPageAmountEntryModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EventPageAmountEntryModel());
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.event = await actions.getEventByEventId(widget.eventId);
      safeSetState(() {});
      // await actions.QuickPay().initTerminal(widget.eventId, );
    });

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'EventPageAmountEntry'});
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
        body: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                wrapWithModel(
                  model: _model.eventTitleModel,
                  updateCallback: () => safeSetState(() {}),
                  child: EventTitleWidget(
                    eventImg: _model.event?.event_image,
                    eventTitle: _model.event?.title,
                  ),
                ),
                Expanded(
                    child:
                        AmountEntryWidget(eventId: widget.eventId.toString())),
              ],
            ),
            // Align(
            //   alignment: AlignmentDirectional(-0.85, -0.98),
            //   child: FlutterFlowIconButton(
            //     borderRadius: 50.0,
            //     buttonSize: 40.0,
            //     fillColor: Color(0x66FFFFFF),
            //     icon: Icon(
            //       FFIcons.kicArrowLeftRound,
            //       color: FlutterFlowTheme.of(context).secondary,
            //       size: 20.0,
            //     ),
            //     onPressed: () {
            //       print('IconButton pressed ...');
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

import '/components/ticket_summary_card/ticket_summary_card_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'device_summary_card_model.dart';
export 'device_summary_card_model.dart';

class DeviceSummaryCardWidget extends StatefulWidget {
  const DeviceSummaryCardWidget({super.key});

  @override
  State<DeviceSummaryCardWidget> createState() =>
      _DeviceSummaryCardWidgetState();
}

class _DeviceSummaryCardWidgetState extends State<DeviceSummaryCardWidget> {
  late DeviceSummaryCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DeviceSummaryCardModel());

    _model.expandableExpandableController =
        ExpandableController(initialExpanded: false);
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.transparent,
      child: ExpandableNotifier(
        controller: _model.expandableExpandableController,
        child: ExpandablePanel(
          header: Text(
            'IOS 13 ID 124568',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'MonaSans',
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                ),
          ),
          collapsed: Container(),
          expanded: ListView(
            padding: EdgeInsets.zero,
            primary: false,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: [
              wrapWithModel(
                model: _model.ticketSummaryCardModel1,
                updateCallback: () => safeSetState(() {}),
                child: TicketSummaryCardWidget(
                  title: 'Backstage',
                  icon: Icon(
                    FFIcons.kicDeck,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 20.0,
                  ),
                ),
              ),
              wrapWithModel(
                model: _model.ticketSummaryCardModel2,
                updateCallback: () => safeSetState(() {}),
                child: TicketSummaryCardWidget(
                  title: 'General Admission',
                  icon: Icon(
                    FFIcons.kicCurtains,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 20.0,
                  ),
                ),
              ),
              wrapWithModel(
                model: _model.ticketSummaryCardModel3,
                updateCallback: () => safeSetState(() {}),
                child: TicketSummaryCardWidget(
                  title: 'Parking Pass',
                  icon: Icon(
                    FFIcons.kicCar,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 20.0,
                  ),
                ),
              ),
              wrapWithModel(
                model: _model.ticketSummaryCardModel4,
                updateCallback: () => safeSetState(() {}),
                child: TicketSummaryCardWidget(
                  title: 'General  Admission  -  Sold Out  -  Waiting List',
                  icon: Icon(
                    FFIcons.kicError,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 20.0,
                  ),
                ),
              ),
              wrapWithModel(
                model: _model.ticketSummaryCardModel5,
                updateCallback: () => safeSetState(() {}),
                child: TicketSummaryCardWidget(
                  title: 'Guests',
                  icon: Icon(
                    FFIcons.kicStar,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 20.0,
                  ),
                ),
              ),
            ].divide(SizedBox(height: 20.0)),
          ),
          theme: ExpandableThemeData(
            tapHeaderToExpand: true,
            tapBodyToExpand: true,
            tapBodyToCollapse: false,
            headerAlignment: ExpandablePanelHeaderAlignment.center,
            hasIcon: true,
            expandIcon: FFIcons.kicArrowDown,
            collapseIcon: FFIcons.kicArrowUp,
            iconSize: 30.0,
            iconColor: FlutterFlowTheme.of(context).secondaryText,
          ),
        ),
      ),
    );
  }
}

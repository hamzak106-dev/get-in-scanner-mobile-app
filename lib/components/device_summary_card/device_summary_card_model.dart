import '/components/ticket_summary_card/ticket_summary_card_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'device_summary_card_widget.dart' show DeviceSummaryCardWidget;
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class DeviceSummaryCardModel extends FlutterFlowModel<DeviceSummaryCardWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController;

  // Model for TicketSummaryCard component.
  late TicketSummaryCardModel ticketSummaryCardModel1;
  // Model for TicketSummaryCard component.
  late TicketSummaryCardModel ticketSummaryCardModel2;
  // Model for TicketSummaryCard component.
  late TicketSummaryCardModel ticketSummaryCardModel3;
  // Model for TicketSummaryCard component.
  late TicketSummaryCardModel ticketSummaryCardModel4;
  // Model for TicketSummaryCard component.
  late TicketSummaryCardModel ticketSummaryCardModel5;

  @override
  void initState(BuildContext context) {
    ticketSummaryCardModel1 =
        createModel(context, () => TicketSummaryCardModel());
    ticketSummaryCardModel2 =
        createModel(context, () => TicketSummaryCardModel());
    ticketSummaryCardModel3 =
        createModel(context, () => TicketSummaryCardModel());
    ticketSummaryCardModel4 =
        createModel(context, () => TicketSummaryCardModel());
    ticketSummaryCardModel5 =
        createModel(context, () => TicketSummaryCardModel());
  }

  @override
  void dispose() {
    expandableExpandableController.dispose();
    ticketSummaryCardModel1.dispose();
    ticketSummaryCardModel2.dispose();
    ticketSummaryCardModel3.dispose();
    ticketSummaryCardModel4.dispose();
    ticketSummaryCardModel5.dispose();
  }
}

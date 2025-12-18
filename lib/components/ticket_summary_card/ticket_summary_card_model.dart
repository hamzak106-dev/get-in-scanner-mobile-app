import '/components/icon_text_chip/icon_text_chip_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'ticket_summary_card_widget.dart' show TicketSummaryCardWidget;
import 'package:flutter/material.dart';

class TicketSummaryCardModel extends FlutterFlowModel<TicketSummaryCardWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for IconTextChip component.
  late IconTextChipModel iconTextChipModel1;
  // Model for IconTextChip component.
  late IconTextChipModel iconTextChipModel2;
  // Model for IconTextChip component.
  late IconTextChipModel iconTextChipModel3;
  // Model for IconTextChip component.
  late IconTextChipModel iconTextChipModel4;

  @override
  void initState(BuildContext context) {
    iconTextChipModel1 = createModel(context, () => IconTextChipModel());
    iconTextChipModel2 = createModel(context, () => IconTextChipModel());
    iconTextChipModel3 = createModel(context, () => IconTextChipModel());
    iconTextChipModel4 = createModel(context, () => IconTextChipModel());
  }

  @override
  void dispose() {
    iconTextChipModel1.dispose();
    iconTextChipModel2.dispose();
    iconTextChipModel3.dispose();
    iconTextChipModel4.dispose();
  }
}

import '/components/icon_text_chip/icon_text_chip_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'attendee_card_widget.dart' show AttendeeCardWidget;
import 'package:flutter/material.dart';

class AttendeeCardModel extends FlutterFlowModel<AttendeeCardWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for IconTextChip component.
  late IconTextChipModel iconTextChipModel1;
  // Model for IconTextChip component.
  late IconTextChipModel iconTextChipModel2;
  // Model for IconTextChip component.
  late IconTextChipModel iconTextChipModel3;

  @override
  void initState(BuildContext context) {
    iconTextChipModel1 = createModel(context, () => IconTextChipModel());
    iconTextChipModel2 = createModel(context, () => IconTextChipModel());
    iconTextChipModel3 = createModel(context, () => IconTextChipModel());
  }

  @override
  void dispose() {
    iconTextChipModel1.dispose();
    iconTextChipModel2.dispose();
    iconTextChipModel3.dispose();
  }
}

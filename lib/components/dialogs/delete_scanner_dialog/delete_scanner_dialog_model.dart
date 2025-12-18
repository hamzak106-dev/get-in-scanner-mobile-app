import '/backend/supabase/supabase.dart';
import '/components/dialog_button/dialog_button_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'delete_scanner_dialog_widget.dart' show DeleteScannerDialogWidget;
import 'package:flutter/material.dart';

class DeleteScannerDialogModel
    extends FlutterFlowModel<DeleteScannerDialogWidget> {
  ///  Local state fields for this component.

  List<AttendeeRow> attendees = [];
  void addToAttendees(AttendeeRow item) => attendees.add(item);
  void removeFromAttendees(AttendeeRow item) => attendees.remove(item);
  void removeAtIndexFromAttendees(int index) => attendees.removeAt(index);
  void insertAtIndexInAttendees(int index, AttendeeRow item) =>
      attendees.insert(index, item);
  void updateAttendeesAtIndex(int index, Function(AttendeeRow) updateFn) =>
      attendees[index] = updateFn(attendees[index]);

  ///  State fields for stateful widgets in this component.

  // Model for DialogButton component.
  late DialogButtonModel dialogButtonModel1;
  // Model for DialogButton component.
  late DialogButtonModel dialogButtonModel2;

  @override
  void initState(BuildContext context) {
    dialogButtonModel1 = createModel(context, () => DialogButtonModel());
    dialogButtonModel2 = createModel(context, () => DialogButtonModel());
  }

  @override
  void dispose() {
    dialogButtonModel1.dispose();
    dialogButtonModel2.dispose();
  }
}

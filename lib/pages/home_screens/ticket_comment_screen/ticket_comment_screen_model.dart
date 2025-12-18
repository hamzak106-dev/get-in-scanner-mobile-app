import '/backend/supabase/supabase.dart';
import '/components/attendee_detail_tile/attendee_detail_tile_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'ticket_comment_screen_widget.dart' show TicketCommentScreenWidget;
import 'package:flutter/material.dart';

class TicketCommentScreenModel
    extends FlutterFlowModel<TicketCommentScreenWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for AttendeeDetailTile component.
  late AttendeeDetailTileModel attendeeDetailTileModel1;
  // State field(s) for CommentTextField widget.
  FocusNode? commentTextFieldFocusNode;
  TextEditingController? commentTextFieldTextController;
  String? Function(BuildContext, String?)?
      commentTextFieldTextControllerValidator;
  // Model for AttendeeDetailTile component.
  late AttendeeDetailTileModel attendeeDetailTileModel2;
  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<AttendeeRow>? updatedRemarks;
  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<AttendeeRow>? deletedRemarks;

  @override
  void initState(BuildContext context) {
    attendeeDetailTileModel1 =
        createModel(context, () => AttendeeDetailTileModel());
    attendeeDetailTileModel2 =
        createModel(context, () => AttendeeDetailTileModel());
  }

  @override
  void dispose() {
    attendeeDetailTileModel1.dispose();
    commentTextFieldFocusNode?.dispose();
    commentTextFieldTextController?.dispose();

    attendeeDetailTileModel2.dispose();
  }
}

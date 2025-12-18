import 'package:flutter/material.dart';

import '/backend/supabase/supabase.dart';
import '/components/attendee_detail_tile/attendee_detail_tile_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'attendees_detail_screen_widget.dart' show AttendeesDetailScreenWidget;

class AttendeesDetailScreenModel
    extends FlutterFlowModel<AttendeesDetailScreenWidget> {
  ///  Local state fields for this page.

  bool checkedIn = false;

  AttendeeRow? attendee;

  int logId = 0;

  PinRow? pin;

  bool hasManualEntry = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in AttendeesDetailScreen widget.
  List<PinRow>? pins;

  // Model for AttendeeDetailTile component.
  late AttendeeDetailTileModel attendeeDetailTileModel1;

  // Model for AttendeeDetailTile component.
  late AttendeeDetailTileModel attendeeDetailTileModel2;

  // Model for AttendeeDetailTile component.
  late AttendeeDetailTileModel attendeeDetailTileModel3;

  // Model for AttendeeDetailTile component.
  late AttendeeDetailTileModel attendeeDetailTileModel4;

  // Model for AttendeeDetailTile component.
  late AttendeeDetailTileModel attendeeDetailTileModel5;

  // Model for AttendeeDetailTile component.
  late AttendeeDetailTileModel attendeeDetailTileModel6;

  // Model for AttendeeDetailTile component.
  late AttendeeDetailTileModel attendeeDetailTileModel7;

  // Model for AttendeeDetailTile component.
  late AttendeeDetailTileModel attendeeDetailTileModel8;

  // Model for AttendeeDetailTile component.
  late AttendeeDetailTileModel attendeeDetailTileModel9;

  // Model for AttendeeDetailTile component.
  late AttendeeDetailTileModel attendeeDetailTileModel10;

  // Model for AttendeeDetailTile component.
  late AttendeeDetailTileModel attendeeDetailTileModel11;
  late AttendeeDetailTileModel attendeeDetailTileModel12;

  @override
  void initState(BuildContext context) {
    attendeeDetailTileModel1 =
        createModel(context, () => AttendeeDetailTileModel());
    attendeeDetailTileModel2 =
        createModel(context, () => AttendeeDetailTileModel());
    attendeeDetailTileModel3 =
        createModel(context, () => AttendeeDetailTileModel());
    attendeeDetailTileModel4 =
        createModel(context, () => AttendeeDetailTileModel());
    attendeeDetailTileModel5 =
        createModel(context, () => AttendeeDetailTileModel());
    attendeeDetailTileModel6 =
        createModel(context, () => AttendeeDetailTileModel());
    attendeeDetailTileModel7 =
        createModel(context, () => AttendeeDetailTileModel());
    attendeeDetailTileModel8 =
        createModel(context, () => AttendeeDetailTileModel());
    attendeeDetailTileModel9 =
        createModel(context, () => AttendeeDetailTileModel());
    attendeeDetailTileModel10 =
        createModel(context, () => AttendeeDetailTileModel());
    attendeeDetailTileModel11 =
        createModel(context, () => AttendeeDetailTileModel());
    attendeeDetailTileModel12 =
        createModel(context, () => AttendeeDetailTileModel());
  }

  @override
  void dispose() {
    attendeeDetailTileModel1.dispose();
    attendeeDetailTileModel2.dispose();
    attendeeDetailTileModel3.dispose();
    attendeeDetailTileModel4.dispose();
    attendeeDetailTileModel5.dispose();
    attendeeDetailTileModel6.dispose();
    attendeeDetailTileModel7.dispose();
    attendeeDetailTileModel8.dispose();
    attendeeDetailTileModel9.dispose();
    attendeeDetailTileModel10.dispose();
    attendeeDetailTileModel11.dispose();
    attendeeDetailTileModel12.dispose();
  }
}

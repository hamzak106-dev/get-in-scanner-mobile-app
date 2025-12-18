// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '../../components/ticket_summary_card/ticket_summary_card_widget.dart';

class PinExpandedCard extends StatefulWidget {
  const PinExpandedCard({
    super.key,
    this.width,
    this.height,
    required this.pin,
    required this.child,
  });

  final double? width;
  final double? height;
  final PinRow pin;
  final Widget Function() child;

  @override
  State<PinExpandedCard> createState() => _PinExpandedCardState();
}

class _PinExpandedCardState extends State<PinExpandedCard> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        '${widget.pin.name ?? widget.pin.type} (${widget.pin.pin})',
        style: FlutterFlowTheme.of(context).bodyMedium.override(
              fontFamily: 'Neue Haas Grotesk Display Pro',
              letterSpacing: 0.0,
              fontWeight: FontWeight.w500,
              useGoogleFonts: false,
            ),
      ),
      tilePadding: EdgeInsets.symmetric(horizontal: 20),
      collapsedBackgroundColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      iconColor: FlutterFlowTheme.of(context).primaryText,
      childrenPadding: EdgeInsets.all(16),
      collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: FlutterFlowTheme.of(context).tertiary)),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: FlutterFlowTheme.of(context).tertiary)),
      children: <Widget>[widget.child.call()].divide(SizedBox(height: 20)),
    );
  }
}

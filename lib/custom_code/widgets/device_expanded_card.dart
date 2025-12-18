// Automatic FlutterFlow imports
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
// Imports other custom widgets
// Imports custom actions
// Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!


class DeviceExpandedCard extends StatefulWidget {
  const DeviceExpandedCard({
    super.key,
    this.width,
    this.height,
    required this.device,
    required this.child,
  });

  final double? width;
  final double? height;
  final DeviceRow device;
  final Widget Function() child;

  @override
  State<DeviceExpandedCard> createState() => _DeviceExpandedCardState();
}

class _DeviceExpandedCardState extends State<DeviceExpandedCard> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        widget.device.name,
        style: FlutterFlowTheme.of(context).bodyMedium.override(
              fontFamily: 'MonaSans',
              letterSpacing: 0.0,
              fontWeight: FontWeight.w500,
              useGoogleFonts: false,
            ),
      ),
      tilePadding: EdgeInsets.symmetric(horizontal: 20),
      collapsedBackgroundColor:
          FlutterFlowTheme.of(context).secondaryBackground,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      iconColor: FlutterFlowTheme.of(context).primaryText,
      childrenPadding: EdgeInsets.all(16),
      collapsedShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      children: <Widget>[widget.child.call()].divide(SizedBox(height: 20)),
    );
  }
}

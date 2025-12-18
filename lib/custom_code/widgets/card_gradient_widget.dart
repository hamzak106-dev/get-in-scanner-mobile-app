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

import 'dart:ui';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class CardGradientWidget extends StatefulWidget {
  const CardGradientWidget({
    super.key,
    this.width,
    this.height,
    this.child,
    this.isSelected = false,
  });

  final double? width;
  final double? height;
  final Widget Function()? child;
  final bool isSelected;

  @override
  State<CardGradientWidget> createState() => _CardGradientWidgetState();
}

class _CardGradientWidgetState extends State<CardGradientWidget> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 50.0,
          sigmaY: 50.0,
        ),
        child: Container(
          width: double.infinity,
          // height: 92.0,
          decoration: BoxDecoration(
            color: widget.isSelected
                ? FlutterFlowTheme.of(context).primaryText
                : FlutterFlowTheme.of(context)
                    .secondaryBackground
                    .withAlpha(50),
            gradient: widget.isSelected
                ? null
                : LinearGradient(
                    colors: [
                      FlutterFlowTheme.of(context).secondaryBackground,
                      FlutterFlowTheme.of(context).tertiary
                    ],
                    stops: [0.0, 1.0],
                    begin: AlignmentDirectional(0.0, -1.0),
                    end: AlignmentDirectional(0, 1.0),
                  ),
            borderRadius: BorderRadius.circular(12.0),
            border: GradientBoxBorder(
              gradient: LinearGradient(
                  colors: [Colors.transparent, Color(0xff2A2C32)]),
              width: 1,
            ),
          ),
          child: widget.child?.call(),
        ),
      ),
    );
  }
}

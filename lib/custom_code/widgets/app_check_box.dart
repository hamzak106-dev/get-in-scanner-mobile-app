// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
// Imports other custom widgets
// Imports custom actions
// Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:msh_checkbox/msh_checkbox.dart';

// Set your widget name, define your parameter, and then add the
// boilerplate code using the green button on the right!
class AppCheckBox extends StatelessWidget {
  const AppCheckBox({
    super.key,
    this.width,
    this.height,
    this.size,
    this.initialValue,
    this.fillColor,
    this.checkColor,
    this.borderColor,
    this.onChange,
  });

  final double? width;
  final double? height;
  final double? size;
  final bool? initialValue;
  final Color? fillColor;
  final Color? checkColor;
  final Color? borderColor;
  final Future Function(bool value)? onChange;

  @override
  Widget build(BuildContext context) {
    return MSHCheckbox(
      size: size ?? 24,
      value: initialValue ?? false,
      colorConfig: MSHColorConfig(
        fillColor: (state) =>
            fillColor ??
            (state.isDisabled
                ? FlutterFlowTheme.of(context).secondaryBackground
                : FlutterFlowTheme.of(context).primaryBackground),
        borderColor: (state) =>
            borderColor ??
            (state.isDisabled
                ? FlutterFlowTheme.of(context).tertiary
                : FlutterFlowTheme.of(context).primaryText),
        checkColor: (state) =>
            checkColor ?? FlutterFlowTheme.of(context).primaryText,
      ),
      style: MSHCheckboxStyle.fillScaleCheck,
      onChanged: (selected) {
        if (onChange != null) {
          onChange!(selected);
        }
      },
    );
  }
}

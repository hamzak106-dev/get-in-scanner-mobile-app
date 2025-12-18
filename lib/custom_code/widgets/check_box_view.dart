import 'package:flutter/material.dart';
import 'package:msh_checkbox/msh_checkbox.dart';

import '../../flutter_flow/flutter_flow_theme.dart';

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

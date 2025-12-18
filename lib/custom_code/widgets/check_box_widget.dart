// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
// Imports other custom widgets
// Imports custom actions
// Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class CheckBoxWidget extends StatefulWidget {
  const CheckBoxWidget({
    super.key,
    this.width,
    this.height,
    this.initialValue,
    this.onChange,
  });

  final double? width;
  final double? height;
  final bool? initialValue;
  final Future Function(bool value)? onChange;

  @override
  State<CheckBoxWidget> createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  bool checkValue = false;

  @override
  void initState() {
    checkValue = widget.initialValue ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: widget.initialValue ?? false,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
        side: BorderSide(color: FlutterFlowTheme.of(context).secondary),
      ),
      activeColor: FlutterFlowTheme.of(context).secondary,
      fillColor: WidgetStatePropertyAll(Colors.transparent),
      checkColor: FlutterFlowTheme.of(context).secondary,
      side: WidgetStateBorderSide.resolveWith(
        (states) => const BorderSide(color: Colors.white),
      ),
      onChanged: (value) {
        checkValue = value ?? false;
        widget.onChange?.call(checkValue);
      },
    );
  }
}

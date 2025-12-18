// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
// Imports other custom widgets
// Imports custom actions
// Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter/services.dart';

class PasswordTextFieldWidget extends StatefulWidget {
  const PasswordTextFieldWidget({
    super.key,
    this.width,
    this.height,
    this.hintText,
    required this.onChange,
  });

  final double? width;
  final double? height;
  final String? hintText;
  final Future Function(String? value) onChange;

  @override
  State<PasswordTextFieldWidget> createState() =>
      _PasswordTextFieldWidgetState();
}

class _PasswordTextFieldWidgetState extends State<PasswordTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      obscureText: true,
      autovalidateMode: AutovalidateMode.disabled,
      onChanged: widget.onChange,
      inputFormatters: [
        LengthLimitingTextInputFormatter(4),
        FilteringTextInputFormatter.digitsOnly,
      ],
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        isDense: true,
        labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
              fontFamily: 'MonaSans',
              letterSpacing: 0.4,
              useGoogleFonts: false,
            ),
        hintText: widget.hintText,
        hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
              fontFamily: 'MonaSans',
              letterSpacing: 0.4,
              useGoogleFonts: false,
            ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: FlutterFlowTheme.of(context).tertiary,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: FlutterFlowTheme.of(context).tertiary,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: FlutterFlowTheme.of(context).error,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: FlutterFlowTheme.of(context).error,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: FlutterFlowTheme.of(context).secondaryBackground,
        contentPadding: EdgeInsets.all(22.5),
      ),
      style: FlutterFlowTheme.of(context).bodyMedium.override(
            fontFamily: 'MonaSans',
            letterSpacing: 0.4,
            useGoogleFonts: false,
          ),
      textAlign: TextAlign.center,
      cursorColor: FlutterFlowTheme.of(context).primaryText,
    );
  }
}

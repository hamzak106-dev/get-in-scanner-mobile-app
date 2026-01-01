// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
// Imports other custom widgets
// Imports custom actions
// Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:intl_phone_field/intl_phone_field.dart';

class MobileNumberTextFieldWidget2 extends StatefulWidget {
  const MobileNumberTextFieldWidget2({
    super.key,
    this.width,
    this.height,
    this.hintText,
    this.countryCode,
    this.phoneNumber,
    required this.onChange,
    this.padding = const EdgeInsets.all(22.5),
    this.fillColor,
  });

  final double? width;
  final double? height;
  final String? hintText;
  final String? countryCode;
  final String? phoneNumber;
  final Future Function(
      String countryCode, String? phoneNumber, String? dialCode) onChange;
  final EdgeInsets padding;
  final Color? fillColor;

  @override
  State<MobileNumberTextFieldWidget2> createState() =>
      _MobileNumberTextFieldWidget2State();
}

class _MobileNumberTextFieldWidget2State
    extends State<MobileNumberTextFieldWidget2> {
  String initialCountryCode = "UA";
  String dialCode = "+1";
  String number = "";
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: IntlPhoneField(
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
            color: FlutterFlowTheme.of(context).secondary200,
            useGoogleFonts: false,
          ),

          // Rounded border
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10), // <-- change corner radius here
            borderSide: BorderSide.none,            // remove border line
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
               filled: true,
          fillColor: widget.fillColor ?? FlutterFlowTheme.of(context).secondaryBackground,
          contentPadding: widget.padding,
          counter: SizedBox.shrink(),
          // counterStyle: TextStyle(height: 0, fontSize: 0),
          // counterText: "",
        ),
        flagsButtonMargin: EdgeInsets.all(12),
        flagsButtonPadding: EdgeInsets.only(left: 4, right: 4),
        dropdownIconPosition: IconPosition.trailing,
        dropdownDecoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        showCountryFlag: true,
        dropdownIcon: Icon(
          FFIcons.kicDown,
          size: 12,
          color: Colors.black,
        ),
        invalidNumberMessage: "Please enter valid phone number",
        keyboardType: TextInputType.phone,
        dropdownTextStyle: FlutterFlowTheme.of(context).bodyMedium.override(
          fontFamily: 'MonaSans',
          letterSpacing: 0.4,
          color: Colors.black,
          useGoogleFonts: false,
        ),
        onChanged: (value) {
          number = value.number;
          if (formKey.currentState?.validate() ?? false) {
            widget.onChange.call(initialCountryCode, number, dialCode);
          } else {
            widget.onChange.call(initialCountryCode, null, dialCode);
          }
        },
        onCountryChanged: (value) {
          initialCountryCode = value.code;
          dialCode = "+${value.dialCode}";
          print(value.code);
          if (formKey.currentState?.validate() ?? false) {
            widget.onChange.call(initialCountryCode, number, dialCode);
          } else {
            widget.onChange.call(initialCountryCode, null, dialCode);
          }
        },
        initialCountryCode: widget.countryCode,
        initialValue: widget.phoneNumber,
        style: FlutterFlowTheme.of(context).bodyMedium.override(
          fontFamily: 'MonaSans',
          letterSpacing: 0.4,
          color: Colors.black,
          useGoogleFonts: false,
        ),
      ),
    );
  }
}

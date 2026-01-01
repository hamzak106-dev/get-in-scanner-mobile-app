import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'simple_text_field_model.dart';
export 'simple_text_field_model.dart';

class SimpleTextFieldWidget2 extends StatefulWidget {
  const SimpleTextFieldWidget2({
    super.key,
    this.hintText,
    this.initialValue,
  });

  final String? hintText;
  final String? initialValue;

  @override
  State<SimpleTextFieldWidget2> createState() => _SimpleTextFieldWidget2State();
}

class _SimpleTextFieldWidget2State extends State<SimpleTextFieldWidget2> {
  late SimpleTextFieldModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SimpleTextFieldModel());

    _model.textController ??= TextEditingController(text: widget.initialValue);
    _model.textFieldFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _model.textController,
      focusNode: _model.textFieldFocusNode,
      autofocus: false,
      obscureText: false,
      decoration: InputDecoration(
        isDense: true,
        labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
          fontFamily: 'MonaSans',
          letterSpacing: 0.4,
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
        fillColor: FlutterFlowTheme.of(context).overlayLight,
        contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 21),
      ),
      style: FlutterFlowTheme.of(context).bodyMedium.override(
        fontFamily: 'MonaSans',
        letterSpacing: 0.4,
        color: Colors.black
      ),
      textAlign: TextAlign.start,
      cursorColor:Colors.black,
      validator: _model.textControllerValidator.asValidator(context),
    );
  }
}

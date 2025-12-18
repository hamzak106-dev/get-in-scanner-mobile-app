import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'simple_text_field_model.dart';
export 'simple_text_field_model.dart';

class SimpleTextFieldWidget extends StatefulWidget {
  const SimpleTextFieldWidget({
    super.key,
    this.hintText,
    this.initialValue,
  });

  final String? hintText;
  final String? initialValue;

  @override
  State<SimpleTextFieldWidget> createState() => _SimpleTextFieldWidgetState();
}

class _SimpleTextFieldWidgetState extends State<SimpleTextFieldWidget> {
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
          ),
      textAlign: TextAlign.center,
      cursorColor: FlutterFlowTheme.of(context).primaryText,
      validator: _model.textControllerValidator.asValidator(context),
    );
  }
}

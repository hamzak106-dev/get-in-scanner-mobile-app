import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'label_text_field_model.dart';
export 'label_text_field_model.dart';

class LabelTextFieldWidget extends StatefulWidget {
  const LabelTextFieldWidget({
    super.key,
    this.hintText,
    this.initialValue,
    required this.title,
    required this.icon,
    bool? readOnly,
  }) : this.readOnly = readOnly ?? false;

  final String? hintText;
  final String? initialValue;
  final String? title;
  final Widget? icon;
  final bool readOnly;

  @override
  State<LabelTextFieldWidget> createState() => _LabelTextFieldWidgetState();
}

class _LabelTextFieldWidgetState extends State<LabelTextFieldWidget> {
  late LabelTextFieldModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LabelTextFieldModel());

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
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            widget.icon!,
            Text(
              widget.title!,
              style: FlutterFlowTheme.of(context).titleSmall.override(
                    fontFamily: 'MonaSans',
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ].divide(SizedBox(width: 8.0)),
        ),
        TextFormField(
          controller: _model.textController,
          focusNode: _model.textFieldFocusNode,
          autofocus: false,
          readOnly: widget.readOnly,
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
                color: Colors.transparent,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
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
                fontWeight: FontWeight.w500,
              ),
          textAlign: TextAlign.start,
          cursorColor: FlutterFlowTheme.of(context).primaryText,
          validator: _model.textControllerValidator.asValidator(context),
        ),
      ].divide(SizedBox(height: 10.0)),
    );
  }
}

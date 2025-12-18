import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'value_generate_text_field_model.dart';
export 'value_generate_text_field_model.dart';

class ValueGenerateTextFieldWidget extends StatefulWidget {
  const ValueGenerateTextFieldWidget({
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
  State<ValueGenerateTextFieldWidget> createState() =>
      _ValueGenerateTextFieldWidgetState();
}

class _ValueGenerateTextFieldWidgetState
    extends State<ValueGenerateTextFieldWidget> {
  late ValueGenerateTextFieldModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ValueGenerateTextFieldModel());

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
        Stack(
          alignment: AlignmentDirectional(1.0, 0.0),
          children: [
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
              maxLength: 4,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              buildCounter: (context,
                      {required currentLength,
                      required isFocused,
                      maxLength}) =>
                  null,
              keyboardType: TextInputType.number,
              cursorColor: FlutterFlowTheme.of(context).primaryText,
              validator: _model.textControllerValidator.asValidator(context),
              inputFormatters: [_model.textFieldMask],
            ),
            if (!widget.readOnly)
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 16.0, 0.0),
                child: FFButtonWidget(
                  onPressed: () async {
                    logFirebaseEvent(
                        'VALUE_GENERATE_TEXT_FIELD_GENERATE_BTN_O');
                    _model.code = await actions.generateCode();
                    safeSetState(() {
                      _model.textController?.text = _model.code!;
                      _model.textFieldMask.updateMask(
                        newValue: TextEditingValue(
                          text: _model.textController!.text,
                        ),
                      );
                    });

                    safeSetState(() {});
                  },
                  text: 'Generate',
                  options: FFButtonOptions(
                    height: 32.0,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FlutterFlowTheme.of(context).secondary,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'MonaSans',
                          color: FlutterFlowTheme.of(context).primaryBackground,
                          fontSize: 14.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                        ),
                    elevation: 0.0,
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                ),
              ),
          ],
        ),
      ].divide(SizedBox(height: 10.0)),
    );
  }
}

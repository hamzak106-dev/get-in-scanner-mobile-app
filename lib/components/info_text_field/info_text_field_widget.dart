import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'info_text_field_model.dart';
export 'info_text_field_model.dart';

class InfoTextFieldWidget extends StatefulWidget {
  const InfoTextFieldWidget({
    super.key,
    this.hintText,
    this.initialValue,
    required this.info,
    required this.icon,
    bool? readOnly,
    bool? hasGenerator,
  })  : this.readOnly = readOnly ?? false,
        this.hasGenerator = hasGenerator ?? false;

  final String? hintText;
  final String? initialValue;
  final String? info;
  final Widget? icon;
  final bool readOnly;
  final bool hasGenerator;

  @override
  State<InfoTextFieldWidget> createState() => _InfoTextFieldWidgetState();
}

class _InfoTextFieldWidgetState extends State<InfoTextFieldWidget> {
  late InfoTextFieldModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => InfoTextFieldModel());

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
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                isDense: false,
                labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                      fontFamily: 'MonaSans',
                      letterSpacing: 0.0,
                    ),
                hintText: widget.hintText,
                hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                      fontFamily: 'MonaSans',
                      letterSpacing: 0.0,
                    ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).tertiary,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).error,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).error,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                filled: true,
                fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                contentPadding: EdgeInsets.all(8.0),
                prefixIcon: widget.icon,
              ),
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'MonaSans',
                    letterSpacing: 0.0,
                  ),
              cursorColor: FlutterFlowTheme.of(context).primaryText,
              validator: _model.textControllerValidator.asValidator(context),
            ),
            if (widget.hasGenerator)
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 16.0, 0.0),
                child: FFButtonWidget(
                  onPressed: () async {
                    logFirebaseEvent(
                        'INFO_TEXT_FIELD_COMP_GENERATE_BTN_ON_TAP');
                    _model.code = await actions.generateCode();
                    safeSetState(() {
                      _model.textController?.text = _model.code!;
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
        Text(
          widget.info!,
          style: FlutterFlowTheme.of(context).titleSmall.override(
                fontFamily: 'MonaSans',
                color: Color(0xFFB5B6BA),
                fontSize: 12.0,
                letterSpacing: 0.0,
                fontWeight: FontWeight.normal,
              ),
        ),
      ].divide(SizedBox(height: 8.0)),
    );
  }
}

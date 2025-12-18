import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'search_text_field_model.dart';
export 'search_text_field_model.dart';

class SearchTextFieldWidget extends StatefulWidget {
  const SearchTextFieldWidget({
    super.key,
    required this.onChange,
    bool? isLight,
  }) : this.isLight = isLight ?? false;

  final Future Function()? onChange;
  final bool isLight;

  @override
  State<SearchTextFieldWidget> createState() => _SearchTextFieldWidgetState();
}

class _SearchTextFieldWidgetState extends State<SearchTextFieldWidget> {
  late SearchTextFieldModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SearchTextFieldModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52.0,
      decoration: BoxDecoration(
        color: widget.isLight
            ? FlutterFlowTheme.of(context).secondary
            : FlutterFlowTheme.of(context).tertiary,
        boxShadow: [
          BoxShadow(
            blurRadius: 4.0,
            color: Color(0x26000000),
            offset: Offset(
              1.0,
              1.0,
            ),
            spreadRadius: 0.0,
          )
        ],
        borderRadius: BorderRadius.circular(50.0),
        border: Border.all(
          color: widget.isLight ? Color(0xFFF7F7F7) : Color(0xFF2A2C32),
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: TextFormField(
                controller: _model.textController,
                focusNode: _model.textFieldFocusNode,
                onChanged: (_) => EasyDebounce.debounce(
                  '_model.textController',
                  Duration(milliseconds: 0),
                  () async {
                    logFirebaseEvent(
                        'SEARCH_TEXT_FIELD_TextField_g0c0e693_ON_');
                    await widget.onChange?.call();

                    safeSetState(() {});
                  },
                ),
                autofocus: false,
                obscureText: false,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: 'Search',
                  hintStyle: FlutterFlowTheme.of(context).labelLarge.override(
                        fontFamily: 'MonaSans',
                        color: Color(0xFF6B6D75),
                        fontSize: 14.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.normal,
                      ),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                ),
                style: FlutterFlowTheme.of(context).bodyLarge.override(
                      fontFamily: 'MonaSans',
                      fontSize: 14.0,
                      letterSpacing: 0.4,
                      fontWeight: FontWeight.w500,
                    ),
                textAlign: TextAlign.start,
                cursorColor: FlutterFlowTheme.of(context).primaryText,
                validator: _model.textControllerValidator.asValidator(context),
              ),
            ),
            Builder(
              builder: (context) {
                if (_model.textController.text != '') {
                  return InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      logFirebaseEvent(
                          'SEARCH_TEXT_FIELD_Icon_796u1s9y_ON_TAP');
                      safeSetState(() {
                        _model.textController?.clear();
                      });
                      await actions.unfocusFields(
                        context,
                      );
                      await widget.onChange?.call();
                    },
                    child: Icon(
                      FFIcons.kicCancel,
                      color: widget.isLight
                          ? FlutterFlowTheme.of(context).accent1
                          : FlutterFlowTheme.of(context).secondaryText,
                      size: 20.0,
                    ),
                  );
                } else {
                  return Icon(
                    FFIcons.kicSearchNormal,
                    color: Color(0xFF6B6D75),
                    size: 16.0,
                  );
                }
              },
            ),
          ].divide(SizedBox(width: 20.0)),
        ),
      ),
    );
  }
}

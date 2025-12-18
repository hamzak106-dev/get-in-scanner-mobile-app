import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'dialog_button_model.dart';
export 'dialog_button_model.dart';

class DialogButtonWidget extends StatefulWidget {
  const DialogButtonWidget({
    super.key,
    required this.buttonLable,
    required this.onTap,
    this.textColor,
  });

  final String? buttonLable;
  final Future Function()? onTap;
  final Color? textColor;

  @override
  State<DialogButtonWidget> createState() => _DialogButtonWidgetState();
}

class _DialogButtonWidgetState extends State<DialogButtonWidget> {
  late DialogButtonModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DialogButtonModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        logFirebaseEvent('DIALOG_BUTTON_Column_w9xri77l_ON_TAP');
        await widget.onTap?.call();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(
            height: 1.0,
            thickness: 0.33,
            color: FlutterFlowTheme.of(context).info,
          ),
          Text(
            widget.buttonLable!,
            textAlign: TextAlign.center,
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'MonaSans',
                  color: valueOrDefault<Color>(
                    widget.textColor,
                    FlutterFlowTheme.of(context).accent3,
                  ),
                  fontSize: 16.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ].divide(SizedBox(height: 16.0)).addToEnd(SizedBox(height: 16.0)),
      ),
    );
  }
}

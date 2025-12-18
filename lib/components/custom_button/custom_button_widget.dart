import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'custom_button_model.dart';
export 'custom_button_model.dart';

class CustomButtonWidget extends StatefulWidget {
  const CustomButtonWidget({
    super.key,
    required this.title,
    this.icon,
    required this.onTap,
    Color? buttonColor,
    Color? textColor,
  })  : this.buttonColor = buttonColor ?? Colors.white,
        this.textColor = textColor ?? Colors.black;

  final String? title;
  final Widget? icon;
  final Future Function()? onTap;
  final Color buttonColor;
  final Color textColor;

  @override
  State<CustomButtonWidget> createState() => _CustomButtonWidgetState();
}

class _CustomButtonWidgetState extends State<CustomButtonWidget> {
  late CustomButtonModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CustomButtonModel());
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
        logFirebaseEvent('CUSTOM_BUTTON_Container_1d0pussv_ON_TAP');
        if (!_model.isLoading) {
          _model.isLoading = true;
          safeSetState(() {});
          await widget.onTap?.call();
          _model.isLoading = false;
          safeSetState(() {});
        }
      },
      child: Container(
        width: double.infinity,
        height: 60.0,
        decoration: BoxDecoration(
          color: widget.buttonColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        alignment: AlignmentDirectional(0.0, 0.0),
        child: Builder(
          builder: (context) {
            if (!_model.isLoading) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.icon != null) widget.icon!,
                  Text(
                    widget.title!,
                    style: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'MonaSans',
                          color: widget.textColor,
                          letterSpacing: 0.4,
                        ),
                  ),
                ].divide(SizedBox(width: 10.0)),
              );
            } else {
              return custom_widgets.Loader(
                width: 30.0,
                height: 30.0,
              );
            }
          },
        ),
      ),
    );
  }
}

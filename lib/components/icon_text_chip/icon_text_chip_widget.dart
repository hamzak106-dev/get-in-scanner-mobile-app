import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'icon_text_chip_model.dart';
export 'icon_text_chip_model.dart';

class IconTextChipWidget extends StatefulWidget {
  const IconTextChipWidget({
    super.key,
    required this.icon,
    required this.lable,
    this.textColor,
    int? spacing,
  }) : this.spacing = spacing ?? 12;

  final Widget? icon;
  final String? lable;
  final Color? textColor;
  final int spacing;

  @override
  State<IconTextChipWidget> createState() => _IconTextChipWidgetState();
}

class _IconTextChipWidgetState extends State<IconTextChipWidget> {
  late IconTextChipModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => IconTextChipModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        widget.icon!,
        Flexible(
          child: Text(
            widget.lable!,
            style: FlutterFlowTheme.of(context).labelMedium.override(
                  fontFamily: 'MonaSans',
                  color: valueOrDefault<Color>(
                    widget.textColor,
                    FlutterFlowTheme.of(context).secondaryText,
                  ),
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      ].divide(SizedBox(width: widget.spacing.toDouble())),
    );
  }
}

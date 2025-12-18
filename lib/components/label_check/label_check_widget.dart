import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'label_check_model.dart';
export 'label_check_model.dart';

/// Text lable and Checkbox
class LabelCheckWidget extends StatefulWidget {
  const LabelCheckWidget({
    super.key,
    this.title,
    bool? isCheck,
    this.onCheckChange,
    this.bgColor,
  }) : this.isCheck = isCheck ?? false;

  final String? title;
  final bool isCheck;
  final Future Function(bool check)? onCheckChange;
  final Color? bgColor;

  @override
  State<LabelCheckWidget> createState() => _LabelCheckWidgetState();
}

class _LabelCheckWidgetState extends State<LabelCheckWidget> {
  late LabelCheckModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LabelCheckModel());
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
        logFirebaseEvent('LABEL_CHECK_Container_5bxfwxvq_ON_TAP');
        await widget.onCheckChange?.call(
          !widget.isCheck,
        );
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: widget.bgColor,
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  widget.title!,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'MonaSans',
                        color: widget.isCheck
                            ? FlutterFlowTheme.of(context).primaryBackground
                            : FlutterFlowTheme.of(context).primaryText,
                        letterSpacing: 0.0,
                      ),
                ),
              ),
              Container(
                width: 24.0,
                height: 24.0,
                child: custom_widgets.AppCheckBox(
                  width: 24.0,
                  height: 24.0,
                  size: 24.0,
                  initialValue: widget.isCheck,
                  onChange: (value) async {
                    logFirebaseEvent('LABEL_CHECK_Container_iv8u87jj_CALLBACK');
                    await widget.onCheckChange?.call(
                      !widget.isCheck,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'combine_text_view_model.dart';
export 'combine_text_view_model.dart';

class CombineTextViewWidget extends StatefulWidget {
  const CombineTextViewWidget({
    super.key,
    required this.lable1,
    required this.lable2,
  });

  final String? lable1;
  final String? lable2;

  @override
  State<CombineTextViewWidget> createState() => _CombineTextViewWidgetState();
}

class _CombineTextViewWidgetState extends State<CombineTextViewWidget> {
  late CombineTextViewModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CombineTextViewModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.lable1!,
          style: FlutterFlowTheme.of(context).bodyLarge.override(
                fontFamily: 'MonaSans',
                letterSpacing: 0.0,
              ),
        ),
        Flexible(
          child: Text(
            widget.lable2!,
            textAlign: TextAlign.end,
            style: FlutterFlowTheme.of(context).bodyLarge.override(
                  fontFamily: 'MonaSans',
                  letterSpacing: 0.0,
                ),
          ),
        ),
      ].divide(SizedBox(width: 20.0)),
    );
  }
}

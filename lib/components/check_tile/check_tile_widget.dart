import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'check_tile_model.dart';
export 'check_tile_model.dart';

class CheckTileWidget extends StatefulWidget {
  const CheckTileWidget({
    super.key,
    bool? initialValue,
    required this.titleText,
    this.hintText,
    this.onCheckChange,
  }) : this.initialValue = initialValue ?? false;

  final bool initialValue;
  final String? titleText;
  final String? hintText;
  final Future Function(bool check)? onCheckChange;

  @override
  State<CheckTileWidget> createState() => _CheckTileWidgetState();
}

class _CheckTileWidgetState extends State<CheckTileWidget> {
  late CheckTileModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CheckTileModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('CHECK_TILE_COMP_CheckTile_ON_INIT_STATE');
      _model.checkValue = widget.initialValue;
      _model.updatePage(() {});
    });
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
        logFirebaseEvent('CHECK_TILE_COMP_Row_t47xd4o6_ON_TAP');
        _model.checkValue = !_model.checkValue;
        safeSetState(() {});
        await widget.onCheckChange?.call(
          _model.checkValue,
        );
      },
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 18.0,
            height: 18.0,
            child: custom_widgets.CheckBoxWidget(
              width: 18.0,
              height: 18.0,
              initialValue: widget.initialValue,
              onChange: (value) async {},
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.titleText!,
                  style: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'MonaSans',
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.normal,
                      ),
                ),
                if (widget.hintText != null && widget.hintText != '')
                  Flexible(
                    child: Text(
                      widget.hintText!,
                      style: FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: 'MonaSans',
                            color: Color(0xFF909298),
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                  ),
              ].divide(SizedBox(height: 10.0)),
            ),
          ),
        ].divide(SizedBox(width: 8.0)),
      ),
    );
  }
}

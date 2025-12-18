
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'permission_tile_model.dart';
export 'permission_tile_model.dart';

/// Permission Item Tile.
class PermissionTileWidget extends StatefulWidget {
  const PermissionTileWidget({
    super.key,
    this.title,
    this.description,
    this.onCheck,
    bool? isCheck,
  }) : this.isCheck = isCheck ?? false;

  final String? title;
  final String? description;
  final Future Function(bool check)? onCheck;
  final bool isCheck;

  @override
  State<PermissionTileWidget> createState() => _PermissionTileWidgetState();
}

class _PermissionTileWidgetState extends State<PermissionTileWidget> {
  late PermissionTileModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PermissionTileModel());
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
        logFirebaseEvent('PERMISSION_TILE_Container_1a6zf4zx_ON_TA');
        await widget.onCheck?.call(
          !widget.isCheck,
        );
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: widget.isCheck ? Color(0xCC1C1D21) : Colors.transparent,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 24.0,
                height: 24.0,
                child: custom_widgets.AppCheckBox(
                  width: 24.0,
                  height: 24.0,
                  size: 24.0,
                  initialValue: widget.isCheck,
                  fillColor: widget.isCheck
                      ? FlutterFlowTheme.of(context).primaryText
                      : FlutterFlowTheme.of(context).tertiary,
                  checkColor: FlutterFlowTheme.of(context).primaryBackground,
                  borderColor: widget.isCheck
                      ? Color(0xFFF7F7F7)
                      : FlutterFlowTheme.of(context).tertiary,
                  onChange: (value) async {
                    logFirebaseEvent(
                        'PERMISSION_TILE_Container_0174nlcu_CALLB');
                    await widget.onCheck?.call(
                      !widget.isCheck,
                    );
                  },
                ),
              ),
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title!,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'MonaSans',
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                          ),
                    ),
                    Text(
                      widget.description!,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'MonaSans',
                            color: Color(0xFF909298),
                            fontSize: 12.0,
                            letterSpacing: 0.0,
                          ),
                    ),
                  ].divide(SizedBox(height: 4.0)),
                ),
              ),
            ].divide(SizedBox(width: 16.0)),
          ),
        ),
      ),
    );
  }
}

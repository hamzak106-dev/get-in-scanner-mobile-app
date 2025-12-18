import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'setting_tile_model.dart';
export 'setting_tile_model.dart';

class SettingTileWidget extends StatefulWidget {
  const SettingTileWidget({
    super.key,
    required this.icon,
    required this.title,
    this.endLable,
    required this.onTap,
    bool? showTrailingIcon,
  }) : this.showTrailingIcon = showTrailingIcon ?? false;

  final Widget? icon;
  final String? title;
  final String? endLable;
  final Future Function()? onTap;
  final bool showTrailingIcon;

  @override
  State<SettingTileWidget> createState() => _SettingTileWidgetState();
}

class _SettingTileWidgetState extends State<SettingTileWidget> {
  late SettingTileModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SettingTileModel());
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
        logFirebaseEvent('SETTING_TILE_COMP_Column_mz02sqca_ON_TAP');
        await widget.onTap?.call();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12.0, 16.0, 12.0, 16.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                widget.icon!,
                Text(
                  widget.title!,
                  style: FlutterFlowTheme.of(context).bodyLarge.override(
                        fontFamily: 'MonaSans',
                        letterSpacing: 0.0,
                      ),
                ),
                Flexible(
                  child: Align(
                    alignment: AlignmentDirectional(1.0, 0.0),
                    child: Text(
                      widget.endLable!,
                      textAlign: TextAlign.end,
                      style: FlutterFlowTheme.of(context).bodyLarge.override(
                            fontFamily: 'MonaSans',
                            letterSpacing: 0.0,
                          ),
                    ),
                  ),
                ),
                if (widget.showTrailingIcon)
                  Align(
                    alignment: AlignmentDirectional(1.0, 0.0),
                    child: Icon(
                      FFIcons.kicArrowNext,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      size: 24.0,
                    ),
                  ),
              ].divide(SizedBox(width: 20.0)),
            ),
          ),
          Divider(
            height: 1.0,
            thickness: 1.0,
            color: FlutterFlowTheme.of(context).secondaryBackground,
          ),
        ],
      ),
    );
  }
}

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:rive/rive.dart' hide LinearGradient;
import 'package:flutter/material.dart';
import 'sync_tile_model.dart';
export 'sync_tile_model.dart';

class SyncTileWidget extends StatefulWidget {
  const SyncTileWidget({
    super.key,
    required this.icon,
    required this.title,
    this.endLable,
    this.onTap,
    bool? showStatus,
    String? status,
  })  : this.showStatus = showStatus ?? true,
        this.status = status ?? 'Completed';

  final Widget? icon;
  final String? title;
  final String? endLable;
  final Future Function()? onTap;
  final bool showStatus;
  final String status;

  @override
  State<SyncTileWidget> createState() => _SyncTileWidgetState();
}

class _SyncTileWidgetState extends State<SyncTileWidget> {
  late SyncTileModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SyncTileModel());
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
        logFirebaseEvent('SYNC_TILE_COMP_Column_1x0zef6p_ON_TAP');
        await widget.onTap?.call();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.all(12.0),
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
                      widget.endLable??"",
                      textAlign: TextAlign.end,
                      style: FlutterFlowTheme.of(context).bodyLarge.override(
                            fontFamily: 'MonaSans',
                            letterSpacing: 0.0,
                          ),
                    ),
                  ),
                ),
                if (widget.showStatus)
                  Align(
                    alignment: AlignmentDirectional(1.0, 0.0),
                    child: Builder(
                      builder: (context) {
                        if (widget.status == 'Inprogress') {
                          return Container(
                            width: 24.0,
                            height: 22.0,
                            child: RiveAnimation.asset(
                              'assets/rive_animations/syncing.riv',
                              artboard: 'Inprogress',
                              fit: BoxFit.cover,
                              controllers: _model.riveAnimationControllers,
                            ),
                          );
                        } else if (widget.status == 'Error') {
                          return Icon(
                            FFIcons.kicWarning,
                            color: FlutterFlowTheme.of(context).warning,
                            size: 24.0,
                          );
                        } else {
                          return Icon(
                            FFIcons.kicCheckCircle,
                            color: FlutterFlowTheme.of(context).success,
                            size: 24.0,
                          );
                        }
                      },
                    ),
                  ),
              ].divide(SizedBox(width: 12.0)),
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

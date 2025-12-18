import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'package:rive/rive.dart' hide LinearGradient;
import 'package:flutter/material.dart';
import 'rive_animation_view_model.dart';
export 'rive_animation_view_model.dart';

class RiveAnimationViewWidget extends StatefulWidget {
  const RiveAnimationViewWidget({
    super.key,
    required this.type,
    Color? fillColor,
    this.title,
    this.subTitle,
    this.caption,
  }) : this.fillColor = fillColor ?? const Color(0x80000000);

  final RiveAnimType? type;
  final Color fillColor;
  final String? title;
  final String? subTitle;
  final String? caption;

  @override
  State<RiveAnimationViewWidget> createState() =>
      _RiveAnimationViewWidgetState();
}

class _RiveAnimationViewWidgetState extends State<RiveAnimationViewWidget> {
  late RiveAnimationViewModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RiveAnimationViewModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(0.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 4.0,
            sigmaY: 4.0,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: widget.fillColor,
            ),
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Builder(
                    builder: (context) {
                      if (widget.type == RiveAnimType.BarcodeLoading) {
                        return Container(
                          width: 150.0,
                          height: 130.0,
                          child: RiveAnimation.asset(
                            'assets/rive_animations/barcode_loading2.riv',
                            artboard: 'Artboard',
                            fit: BoxFit.contain,
                            controllers: _model.riveAnimationControllers1,
                          ),
                        );
                      } else if (widget.type == RiveAnimType.EventSyncing) {
                        return Container(
                          width: 150.0,
                          height: 130.0,
                          child: RiveAnimation.asset(
                            'assets/rive_animations/events_syncing.riv',
                            artboard: 'Events Syncing',
                            fit: BoxFit.contain,
                            controllers: _model.riveAnimationControllers2,
                          ),
                        );
                      } else if (widget.type == RiveAnimType.LoadingLogo) {
                        return Container(
                          width: 150.0,
                          height: 130.0,
                          child: RiveAnimation.asset(
                            'assets/rive_animations/loading_logo.riv',
                            artboard: 'Artboard',
                            fit: BoxFit.contain,
                            controllers: _model.riveAnimationControllers3,
                          ),
                        );
                      } else if (widget.type == RiveAnimType.AvatarSyncing) {
                        return Container(
                          width: 150.0,
                          height: 130.0,
                          child: RiveAnimation.asset(
                            'assets/rive_animations/syncing_avatar.riv',
                            artboard: 'Avatar',
                            fit: BoxFit.contain,
                            controllers: _model.riveAnimationControllers4,
                          ),
                        );
                      } else {
                        return Container(
                          width: 150.0,
                          height: 130.0,
                          child: RiveAnimation.asset(
                            'assets/rive_animations/syncing.riv',
                            artboard: 'Inprogress',
                            fit: BoxFit.contain,
                            controllers: _model.riveAnimationControllers5,
                          ),
                        );
                      }
                    },
                  ),
                ),
                if (widget.title != null && widget.title != '')
                  Text(
                    widget.title!,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'MonaSans',
                          fontSize: 16.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                if (widget.subTitle != null && widget.subTitle != '')
                  Text(
                    widget.subTitle!,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'MonaSans',
                          fontSize: 16.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                if (widget.caption != null && widget.caption != '')
                  Text(
                    widget.caption!,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'MonaSans',
                          color: FlutterFlowTheme.of(context).accent4,
                          letterSpacing: 0.0,
                        ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/components/rive_animation_view/rive_animation_view_widget.dart';
import 'package:flutter/material.dart';

class LoadingWithMessageWidget extends StatefulWidget {
  const LoadingWithMessageWidget({
    super.key,
    this.message,
    this.subMessage,
  });

  final String? message;
  final String? subMessage;

  @override
  State<LoadingWithMessageWidget> createState() =>
      _LoadingWithMessageWidgetState();
}

class _LoadingWithMessageWidgetState extends State<LoadingWithMessageWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: RiveAnimationViewWidget(
            type: RiveAnimType.LoadingLogo,
          ),
        ),
        Text(
          widget.message ?? 'Loading... Please wait',
          textAlign: TextAlign.center,
          style: FlutterFlowTheme.of(context).titleSmall.override(
                fontFamily: 'MonaSans',
                letterSpacing: 0.0,
              ),
        ),
        if (widget.subMessage != null)
          Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: Text(
              widget.subMessage!,
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).labelMedium.override(
                    fontFamily: 'MonaSans',
                    letterSpacing: 0.0,
                  ),
            ),
          ),
      ].divide(const SizedBox(height: 12.0)),
    );
  }
}

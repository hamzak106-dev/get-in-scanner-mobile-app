import 'dart:ui';

import 'package:flutter/material.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'event_bg_model.dart';

export 'event_bg_model.dart';

class EventBgWidget extends StatefulWidget {
  final String? image;

  const EventBgWidget({super.key, this.image});

  @override
  State<EventBgWidget> createState() => _EventBgWidgetState();
}

class _EventBgWidgetState extends State<EventBgWidget> {
  late EventBgModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EventBgModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.sizeOf(context).width * 1.0,
          height: 330,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: valueOrDefault(widget.image, '').isNotEmpty
                  ? NetworkImage(
                      widget.image!,
                    )
                  : AssetImage(
                      'assets/images/event_banner.png',
                    ) as ImageProvider,
            ),
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 8.0, // horizontal blur intensity
            sigmaY: 8.0, // vertical blur intensity
          ),
          child: Container(
            color: Colors.black.withOpacity(0), // keep fully transparent
          ),
        ),
      ],
    );
  }
}

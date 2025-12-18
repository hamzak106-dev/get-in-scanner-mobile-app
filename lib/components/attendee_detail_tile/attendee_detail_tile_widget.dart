import 'package:flutter/material.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'attendee_detail_tile_model.dart';

export 'attendee_detail_tile_model.dart';

class AttendeeDetailTileWidget extends StatefulWidget {
  const AttendeeDetailTileWidget({
    super.key,
    required this.icon,
    required this.title,
    this.endLable,
    required this.onTap,
    bool? isEndBold,
    this.showArrowIcon = false,
  }) : this.isEndBold = isEndBold ?? false;

  final bool showArrowIcon;
  final Widget? icon;
  final String? title;
  final String? endLable;
  final Future Function()? onTap;
  final bool isEndBold;

  @override
  State<AttendeeDetailTileWidget> createState() =>
      _AttendeeDetailTileWidgetState();
}

class _AttendeeDetailTileWidgetState extends State<AttendeeDetailTileWidget> {
  late AttendeeDetailTileModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AttendeeDetailTileModel());
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
        logFirebaseEvent('ATTENDEE_DETAIL_TILE_Row_726oxdhx_ON_TAP');
        await widget.onTap?.call();
      },
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              widget.icon!,
              Text(
                widget.title ?? "",
                textAlign: TextAlign.start,
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'MonaSans',
                      letterSpacing: 0.0,
                    ),
              ),
            ].divide(SizedBox(width: 10.0)),
          ),
          Expanded(
            child: Builder(
              builder: (context) {
                if (widget.isEndBold) {
                  return Align(
                    alignment: AlignmentDirectional(1.0, 0.0),
                    child: Text(
                      widget.endLable ?? "",
                      textAlign: TextAlign.end,
                      style: FlutterFlowTheme.of(context).bodySmall.override(
                            fontFamily: 'MonaSans',
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  );
                } else {
                  return Align(
                    alignment: AlignmentDirectional(1.0, 0.0),
                    child: Text(
                      widget.endLable ?? "",
                      textAlign: TextAlign.end,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'MonaSans',
                            letterSpacing: 0.0,
                          ),
                    ),
                  );
                }
              },
            ),
          ),
          if (widget.showArrowIcon)
            Icon(
              FFIcons.kicArrowNext,
              color: FlutterFlowTheme.of(context).secondaryText,
              size: 24.0,
            ),
        ].divide(SizedBox(width: 10.0)),
      ),
    );
  }
}

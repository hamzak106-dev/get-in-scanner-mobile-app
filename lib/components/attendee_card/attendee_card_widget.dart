import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/components/icon_text_chip/icon_text_chip_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'attendee_card_model.dart';

export 'attendee_card_model.dart';

class AttendeeCardWidget extends StatefulWidget {
  const AttendeeCardWidget({
    super.key,
    required this.onTap,
    required this.attendee,
  });

  final Future Function()? onTap;
  final AttendeeRow? attendee;

  @override
  State<AttendeeCardWidget> createState() => _AttendeeCardWidgetState();
}

class _AttendeeCardWidgetState extends State<AttendeeCardWidget> {
  late AttendeeCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AttendeeCardModel());
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
        logFirebaseEvent('ATTENDEE_CARD_Column_mzlqzwhj_ON_TAP');
        await widget.onTap?.call();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10.0, 16.0, 10.0, 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.attendee!.name ?? "",
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'MonaSans',
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            lineHeight: 1.5,
                          ),
                    ),
                    Builder(
                      builder: (context) {
                        if (widget.attendee?.status ==
                            ScanResult.CHECK_IN.name) {
                          return Icon(
                            FFIcons.kicCheckFillCircle,
                            color: FlutterFlowTheme.of(context).success,
                            size: 20.0,
                          );
                        } else if (widget.attendee?.status ==
                            ScanResult.CHECK_OUT.name) {
                          return Icon(
                            FFIcons.kicCheckOut,
                            color: FlutterFlowTheme.of(context).warning,
                            size: 20.0,
                          );
                        } else {
                          return Container(
                            width: 20.0,
                            height: 20.0,
                            decoration: BoxDecoration(),
                          );
                        }
                      },
                    ),
                    Flexible(
                      child: Align(
                        alignment: AlignmentDirectional(1.0, 0.0),
                        child: Icon(
                          FFIcons.kicArrowNext,
                          color: FlutterFlowTheme.of(context).secondaryText,
                          size: 20.0,
                        ),
                      ),
                    ),
                  ].divide(SizedBox(width: 8.0)),
                ),
                Text(
                  widget.attendee!.ticketName,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'MonaSans',
                        fontSize: 16.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w500,
                        lineHeight: 1.5,
                      ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).tertiary,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: EdgeInsetsDirectional.fromSTEB(10.0, 5.0, 10.0, 5.0),
                  child: Text(
                    'Purchase Id    ${widget.attendee?.purchaseId.toString()}',
                    textAlign: TextAlign.start,
                    style: FlutterFlowTheme.of(context).labelMedium.override(
                          fontFamily: 'MonaSans',
                          fontSize: 14.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                          lineHeight: 1.43,
                        ),
                  ),
                ),
                // if(widget.attendee?.addOns.isNotEmpty == true)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/add_on_icon.svg',
                      width: 16.0,
                      height: 16.0,
                      fit: BoxFit.cover,
                    ),
                    Flexible(
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              valueOrDefault<String>(
                                '${widget.attendee!.addOns.firstOrNull?.name ?? ''}',
                                'N/A',
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              textAlign: TextAlign.end,
                              style: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: 'MonaSans',
                                    color: valueOrDefault<Color>(
                                      FlutterFlowTheme.of(context).primaryText,
                                      FlutterFlowTheme.of(context)
                                          .secondaryText,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                          Text(
                                valueOrDefault<String>(
                                    '${widget.attendee!.addOns.length > 1 ? ' + ${widget.attendee!.addOns.length - 1} more' : ''}',
                                    '',
                                  ),
                            style: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'MonaSans',
                                  color: valueOrDefault<Color>(
                                    FlutterFlowTheme.of(context).primaryText,
                                    FlutterFlowTheme.of(context).secondaryText,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ].divide(SizedBox(width: 12)),
                ),
                wrapWithModel(
                  model: _model.iconTextChipModel1,
                  updateCallback: () => safeSetState(() {}),
                  child: IconTextChipWidget(
                    icon: Icon(
                      FFIcons.kicChat,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      size: 16.0,
                    ),
                    lable: valueOrDefault<String>(
                      widget.attendee?.ticketComment,
                      'N/A',
                    ),
                    textColor: FlutterFlowTheme.of(context).secondaryText,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: wrapWithModel(
                        model: _model.iconTextChipModel2,
                        updateCallback: () => safeSetState(() {}),
                        child: IconTextChipWidget(
                          icon: Icon(
                            FFIcons.kicMail,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 16.0,
                          ),
                          lable: valueOrDefault<String>(
                            widget.attendee?.email,
                            'N/A',
                          ),
                          textColor: FlutterFlowTheme.of(context).secondaryText,
                        ),
                      ),
                    ),
                    wrapWithModel(
                      model: _model.iconTextChipModel3,
                      updateCallback: () => safeSetState(() {}),
                      child: IconTextChipWidget(
                        icon: Icon(
                          FFIcons.kicCall,
                          color: FlutterFlowTheme.of(context).secondaryText,
                          size: 16.0,
                        ),
                        lable: valueOrDefault<String>(
                          widget.attendee?.phone,
                          'N/A',
                        ),
                        textColor: FlutterFlowTheme.of(context).primaryText,
                      ),
                    ),
                  ].divide(SizedBox(width: 20.0)),
                ),
              ].divide(SizedBox(height: 8.0)),
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

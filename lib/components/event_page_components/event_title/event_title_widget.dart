import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:g_e_t_i_n_scanner/components/event_page_components/event_bg/event_bg_widget.dart';
import 'package:g_e_t_i_n_scanner/flutter_flow/flutter_flow_icon_button.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'event_title_model.dart';

export 'event_title_model.dart';

class EventTitleWidget extends StatefulWidget {
  const EventTitleWidget({
    super.key,
    this.eventImg,
    this.eventDate,
    this.eventAddress,
    this.eventTitle,
    this.onBack,
    // String? eventTitle,
    // String? eventAddress,
    // DateTime? eventDate,
  });

  // : this.eventTitle =
  //       eventTitle ?? 'Teksupport: Peggy Gou Teksupport: Peggy Gou ',
  //   this.eventAddress = eventAddress ?? 'Brooklyn Army Terminal, New York',
  //   this.eventDate = eventDate;

  final String? eventImg;
  final String? eventTitle;
  final String? eventAddress;
  final DateTime? eventDate;
  final Function()? onBack;

  @override
  State<EventTitleWidget> createState() => _EventTitleWidgetState();
}

class _EventTitleWidgetState extends State<EventTitleWidget> {
  late EventTitleModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EventTitleModel());
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
        // if (widget.eventImg != null)
        EventBgWidget(
          image: widget.eventImg,
        ),
        Container(
          width: 400.0,
          padding: EdgeInsetsDirectional.fromSTEB(10.0, 40.0, 10.0, 0.0),
          decoration: BoxDecoration(),
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(0.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: valueOrDefault(widget.eventImg, '').isNotEmpty
                          ? CachedNetworkImage(
                              imageUrl: widget.eventImg!,
                              errorWidget: (
                                context,
                                String url,
                                Object error,
                              ) {
                                return Image.asset(
                                  'assets/images/event_banner.png',
                                  width: MediaQuery.sizeOf(context).width * 1.0,
                                  height: 300.0,
                                );
                              },
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              height: 300.0,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/images/event_banner.png',
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              height: 300.0,
                              fit: BoxFit.cover,
                            ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(1.0, 12.0, 10.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (widget.eventDate != null)
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  valueOrDefault<String>(
                                    dateTimeFormat("yMMMd", widget.eventDate),
                                    'Sep 3, 2025',
                                  ),
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Mona Sans',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                                if (widget.eventDate != null)
                                  Text(
                                    valueOrDefault<String>(
                                      dateTimeFormat("jm", widget.eventDate),
                                      '3:00PM',
                                    ),
                                    textAlign: TextAlign.start,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Mona Sans',
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                              ].divide(SizedBox(width: 8.0)),
                            ),
                          if (widget.eventTitle != null)
                            Text(
                              valueOrDefault<String>(
                                widget.eventTitle,
                                'Teksupport: Peggy Gou  Teksupport: Peggy Gou ',
                              ),
                              maxLines: 2,
                              textAlign: TextAlign.start,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Mona Sans',
                                    fontSize: 20.0,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          if (widget.eventAddress != null)
                            Text(
                              valueOrDefault<String>(
                                widget.eventAddress,
                                'Brooklyn Army Terminal, New York',
                              ),
                              maxLines: 2,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Mona Sans',
                                    letterSpacing: 0.0,
                                  ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 50,
          left: 20,
          child: FlutterFlowIconButton(
            showLoadingIndicator: true,
            borderRadius: 50.0,
            // buttonSize: 30.0,
            fillColor: Color(0x66FFFFFF),
            icon: Icon(
              FFIcons.kicArrowLeftRound,
              color: FlutterFlowTheme.of(context).secondary,
              size: 18.0,
            ),
            onPressed: () {
              widget.onBack?.call();
              context.safePop();
            },
          ),
        ),
      ],
    );
  }
}

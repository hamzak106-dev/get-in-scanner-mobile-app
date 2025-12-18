import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'event_wise_card_model.dart';

export 'event_wise_card_model.dart';

class EventWiseCardWidget extends StatefulWidget {
  const EventWiseCardWidget({
    super.key,
    required this.onTap,
    required this.event,
  });

  final Function()? onTap;
  final EventsRow event;

  @override
  State<EventWiseCardWidget> createState() => _EventWiseCardWidgetState();
}

class _EventWiseCardWidgetState extends State<EventWiseCardWidget> {
  late EventWiseCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EventWiseCardModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF1C1D21),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child:  Image(
                          image: valueOrDefault(widget.event.event_image, '').isNotEmpty?
                          NetworkImage(
                            widget.event.event_image!,
                          ): AssetImage(
                            'assets/images/event_banner.png',
                          ) as ImageProvider,
                          width: 70.0,
                          height: 70.0,
                          fit: BoxFit.cover,
                        ) ,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.event.title,
                              style: FlutterFlowTheme.of(context)
                                  .bodyLarge
                                  .override(
                                    fontFamily: 'Mona Sans',
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                            Builder(builder: (context) {
                              final now = DateTime.now();
                              final today = DateTime(now.year, now.month, now.day);

                              final start = DateTime(widget.event.startDate.year,
                                  widget.event.startDate.month, widget.event.startDate.day);
                              final end = DateTime(widget.event.endDate.year,
                                  widget.event.endDate.month, widget.event.endDate.day);

                              final isToday = !start.isAfter(today) && !end.isBefore(today);

                              return RichText(text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: isToday
                                        ?
                                    'TODAY'
                                        : dateTimeFormat(
                                            'MMMEd', widget.event.startDate),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Mona Sans',
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                  TextSpan(
                                    text: ' ' + dateTimeFormat(
                                        'hh:mm a ', widget.event.startDate),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Mona Sans',
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                  if (valueOrDefault<String>(
                                    widget.event.city,
                                    '',
                                  ).isNotEmpty)
                                    WidgetSpan(
                                      baseline: TextBaseline.alphabetic,
                                      alignment: PlaceholderAlignment.middle,
                                      child: FaIcon(
                                        FontAwesomeIcons.solidCircle,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 4.0,

                                      ),
                                    ),
                                  if (valueOrDefault<String>(
                                    widget.event.city,
                                    '',
                                  ).isNotEmpty)
                                    TextSpan(
                                      text: ' ' + valueOrDefault<String>(
                                        widget.event.city,
                                        'No venue',
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                            fontFamily: 'Mona Sans',
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                ]
                              )
                              );

                            }),
                          ],
                        ),
                      ),
                    ].divide(SizedBox(width: 10.0)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

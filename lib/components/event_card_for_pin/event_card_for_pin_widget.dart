import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'event_card_for_pin_model.dart';
export 'event_card_for_pin_model.dart';

class EventCardForPinWidget extends StatefulWidget {
  const EventCardForPinWidget({
    super.key,
    required this.onTap,
    required this.event,
  });

  final Future Function()? onTap;
  final EventsRow? event;

  @override
  State<EventCardForPinWidget> createState() => _EventCardForPinWidgetState();
}

class _EventCardForPinWidgetState extends State<EventCardForPinWidget> {
  late EventCardForPinModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EventCardForPinModel());
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
        logFirebaseEvent('EVENT_CARD_FOR_PIN_Container_fxvyckvs_ON');
        await widget.onTap?.call();
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondary,
          boxShadow: [
            BoxShadow(
              blurRadius: 5.0,
              color: Color(0x1A000000),
              offset: Offset(
                0.0,
                2.0,
              ),
            )
          ],
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                valueOrDefault<String>(
                  widget.event?.title,
                  'N/A',
                ),
                maxLines: 2,
                style: FlutterFlowTheme.of(context).bodyLarge.override(
                      fontFamily: 'MonaSans',
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                  child: Text(
                    valueOrDefault<String>(
                      dateTimeFormat(
                          "dd MMM yyyy at HH:mm", widget.event?.startDate),
                      ' -',
                    ),
                    style: FlutterFlowTheme.of(context).labelMedium.override(
                          fontFamily: 'MonaSans',
                          color: Color(0xFF383A42),
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

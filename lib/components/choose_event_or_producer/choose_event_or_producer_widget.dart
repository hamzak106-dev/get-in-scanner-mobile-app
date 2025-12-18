import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'choose_event_or_producer_model.dart';
export 'choose_event_or_producer_model.dart';

class ChooseEventOrProducerWidget extends StatefulWidget {
  const ChooseEventOrProducerWidget({
    super.key,
    bool? isProducer,
    required this.onSelect,
  }) : this.isProducer = isProducer ?? false;

  final bool isProducer;
  final Future Function()? onSelect;

  @override
  State<ChooseEventOrProducerWidget> createState() =>
      _ChooseEventOrProducerWidgetState();
}

class _ChooseEventOrProducerWidgetState
    extends State<ChooseEventOrProducerWidget> {
  late ChooseEventOrProducerModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChooseEventOrProducerModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Padding(
        padding: EdgeInsets.all(32.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  'assets/images/img_select_event.png',
                  width: 148.0,
                  height: 144.0,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 32.0, 0.0, 0.0),
                child: Text(
                  'No ${widget.isProducer ? 'producer' : 'event'} chosen yet',
                  style: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'MonaSans',
                        fontSize: 24.0,
                        letterSpacing: 0.0,
                      ),
                ),
              ),
              Text(
                'Select one to reveal the ${widget.isProducer ? 'events!' : 'attendees!'}',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).labelMedium.override(
                      fontFamily: 'MonaSans',
                      letterSpacing: 0.0,
                    ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 32.0, 0.0, 0.0),
                child: FFButtonWidget(
                  onPressed: () async {
                    logFirebaseEvent(
                        'CHOOSE_EVENT_OR_PRODUCER_Button_icf6k8ji');
                    await widget.onSelect?.call();
                  },
                  text:
                      'Select ${widget.isProducer ? 'Producer' : 'an Event'}',
                  icon: Icon(
                    Icons.add_circle_outlined,
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    size: 16.0,
                  ),
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 52.0,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FlutterFlowTheme.of(context).secondary,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'MonaSans',
                          color: FlutterFlowTheme.of(context).primaryBackground,
                          fontSize: 14.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.normal,
                          lineHeight: 1.43,
                        ),
                    elevation: 0.0,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
            ].divide(SizedBox(height: 12.0)),
          ),
        ),
      ),
    );
  }
}

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'no_attendees_view_model.dart';
export 'no_attendees_view_model.dart';

class NoAttendeesViewWidget extends StatefulWidget {
  const NoAttendeesViewWidget({super.key});

  @override
  State<NoAttendeesViewWidget> createState() => _NoAttendeesViewWidgetState();
}

class _NoAttendeesViewWidgetState extends State<NoAttendeesViewWidget> {
  late NoAttendeesViewModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NoAttendeesViewModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
          child: Image.asset(
            'assets/images/img_user.png',
            width: 70.0,
            height: 70.0,
            fit: BoxFit.contain,
          ),
        ),
        Text(
          'No attendees for this event',
          textAlign: TextAlign.center,
          style: FlutterFlowTheme.of(context).titleSmall.override(
                fontFamily: 'MonaSans',
                letterSpacing: 0.0,
              ),
        ),
        Text(
          'No one has registered for this event at this time. As of now, there are no attendees signed up.',
          textAlign: TextAlign.center,
          style: FlutterFlowTheme.of(context).labelMedium.override(
                fontFamily: 'MonaSans',
                letterSpacing: 0.0,
              ),
        ),
      ].divide(SizedBox(height: 12.0)),
    );
  }
}

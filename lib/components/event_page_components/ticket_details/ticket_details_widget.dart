import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'ticket_details_model.dart';
export 'ticket_details_model.dart';

class TicketDetailsWidget extends StatefulWidget {
  const TicketDetailsWidget({super.key});

  @override
  State<TicketDetailsWidget> createState() => _TicketDetailsWidgetState();
}

class _TicketDetailsWidgetState extends State<TicketDetailsWidget> {
  late TicketDetailsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TicketDetailsModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondary,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(10.0, 15.0, 10.0, 15.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(
              FFIcons.kicTicketNew,
              color: FlutterFlowTheme.of(context).primaryBackground,
              size: 24.0,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Early Entry Before 11PM',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Mona Sans',
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            fontSize: 12.0,
                            letterSpacing: 0.0,
                          ),
                    ),
                    Text(
                      'US\$100',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Mona Sans',
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            Icon(
              FFIcons.kicArrowRightRound,
              color: FlutterFlowTheme.of(context).primaryBackground,
              size: 24.0,
            ),
          ].divide(SizedBox(width: 10.0)),
        ),
      ),
    );
  }
}

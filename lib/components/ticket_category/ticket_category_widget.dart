import 'package:flutter/material.dart';
import 'package:g_e_t_i_n_scanner/components/event_page_components/ticket_details/ticket_details_widget.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'ticket_category_model.dart';

export 'ticket_category_model.dart';

class TicketCategoryWidget extends StatefulWidget {
  const TicketCategoryWidget({super.key});

  @override
  State<TicketCategoryWidget> createState() => _TicketCategoryWidgetState();
}

class _TicketCategoryWidgetState extends State<TicketCategoryWidget> {
  late TicketCategoryModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TicketCategoryModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(-1.0, 0.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0x31D9D9D9),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '3 DAYS PASS',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Mona Sans',
                      fontSize: 16.0,
                      letterSpacing: 0.0,
                    ),
              ),
              wrapWithModel(
                model: _model.ticketDetailsModel1,
                updateCallback: () => safeSetState(() {}),
                child: TicketDetailsWidget(),
              ),
              wrapWithModel(
                model: _model.ticketDetailsModel2,
                updateCallback: () => safeSetState(() {}),
                child: TicketDetailsWidget(),
              ),
            ].divide(SizedBox(height: 15.0)),
          ),
        ),
      ),
    );
  }
}

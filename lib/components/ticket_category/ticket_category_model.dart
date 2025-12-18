import 'package:g_e_t_i_n_scanner/components/event_page_components/ticket_details/ticket_details_model.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'ticket_category_widget.dart' show TicketCategoryWidget;
import 'package:flutter/material.dart';

class TicketCategoryModel extends FlutterFlowModel<TicketCategoryWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for ticketDetails component.
  late TicketDetailsModel ticketDetailsModel1;
  // Model for ticketDetails component.
  late TicketDetailsModel ticketDetailsModel2;

  @override
  void initState(BuildContext context) {
    ticketDetailsModel1 = createModel(context, () => TicketDetailsModel());
    ticketDetailsModel2 = createModel(context, () => TicketDetailsModel());
  }

  @override
  void dispose() {
    ticketDetailsModel1.dispose();
    ticketDetailsModel2.dispose();
  }
}

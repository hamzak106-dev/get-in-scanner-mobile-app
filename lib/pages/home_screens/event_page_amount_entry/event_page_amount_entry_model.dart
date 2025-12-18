import 'package:flutter/material.dart';
import 'package:g_e_t_i_n_scanner/backend/supabase/database/database.dart';
import 'package:g_e_t_i_n_scanner/components/event_page_components/event_title/event_title_model.dart'
    show EventTitleModel;
import 'package:g_e_t_i_n_scanner/components/ticket_category/ticket_category_model.dart'
    show TicketCategoryModel;

import '/flutter_flow/flutter_flow_util.dart';
import 'event_page_amount_entry_widget.dart' show EventPageAmountEntryWidget;

class EventPageAmountEntryModel extends FlutterFlowModel<EventPageAmountEntryWidget> {
  ///  State fields for stateful widgets in this page.

  EventsRow? event;

  // Model for EventTitle component.
  late EventTitleModel eventTitleModel;

  // Model for ticketCategory component.
  late TicketCategoryModel ticketCategoryModel1;

  // Model for ticketCategory component.
  late TicketCategoryModel ticketCategoryModel2;

  @override
  void initState(BuildContext context) {
    eventTitleModel = createModel(context, () => EventTitleModel());
    ticketCategoryModel1 = createModel(context, () => TicketCategoryModel());
    ticketCategoryModel2 = createModel(context, () => TicketCategoryModel());
  }

  @override
  void dispose() {
    eventTitleModel.dispose();
    ticketCategoryModel1.dispose();
    ticketCategoryModel2.dispose();
  }
}

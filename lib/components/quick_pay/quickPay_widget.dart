import 'package:flutter/material.dart';
import 'package:g_e_t_i_n_scanner/backend/supabase/database/database.dart';
import 'package:g_e_t_i_n_scanner/components/amount_entry/amount_entry_widget.dart'
    show AmountEntryWidget;
import 'package:g_e_t_i_n_scanner/components/event_wise_card_list/event_wise_card_list_widget.dart'
    show EventWiseCardListWidget;
import 'package:g_e_t_i_n_scanner/flutter_flow/flutter_flow_util.dart';

class QuickPayWidget extends StatefulWidget {
  final List<EventsRow> events;
  final Function(EventsRow? event) onEventSelected;
  final EventsRow? selectedEvent;

  const QuickPayWidget({super.key, required this.events, this.selectedEvent, required this.onEventSelected});

  @override
  State<QuickPayWidget> createState() => _QuickPayWidgetState();
}

class _QuickPayWidgetState extends State<QuickPayWidget> {
  initState() {
    super.initState();
  }

  EventsRow? get selectedEvent => widget.selectedEvent;

  @override
  Widget build(BuildContext context) {
    return (selectedEvent == null)
        ? EventWiseCardListWidget(
            events: widget.events,
            onEventSelected: (event) {
              widget.onEventSelected(event);
              // safeSetState(() => selectedEvent = event);
            },
          )
        : AmountEntryWidget(
            eventId: selectedEvent!.eventId.toString(),
            onContinue: () {
              widget.onEventSelected(null);
              // safeSetState(() {
              //   selectedEvent = null;
              // });
            },
          );
  }
}

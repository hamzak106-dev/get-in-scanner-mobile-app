import 'package:flutter/material.dart';
import 'package:g_e_t_i_n_scanner/backend/supabase/database/database.dart';
import 'package:g_e_t_i_n_scanner/components/event_wise_card/event_wise_card_widget.dart';
import 'package:g_e_t_i_n_scanner/components/no_event_found/no_event_found_widget.dart';

class EventWiseCardListWidget extends StatelessWidget {
  final List<EventsRow> events;
  final Function(EventsRow event)? onEventSelected;
  const EventWiseCardListWidget({super.key, required this.events, this.onEventSelected});

  @override
  Widget build(BuildContext context) {
    return events.isEmpty
        ? Center(
      child: NoEventFoundWidget(),
    )
        : ListView.separated(
        separatorBuilder: (context, index) => SizedBox(height: 12),
        itemBuilder: (context, index) {
          return EventWiseCardWidget(
              onTap: () => onEventSelected?.call(events[index]),
              event: events[index]);
        },
        itemCount: events.length);
  }
}

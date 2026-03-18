import 'package:flutter/material.dart';
import 'package:g_e_t_i_n_scanner/backend/supabase/database/database.dart';
import 'package:g_e_t_i_n_scanner/components/event_wise_card/event_wise_card_widget.dart';
import 'package:g_e_t_i_n_scanner/components/no_event_found/no_event_found_widget.dart';
import 'package:g_e_t_i_n_scanner/components/loading_with_message/loading_with_message_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/app_state.dart';

class EventWiseCardListWidget extends StatelessWidget {
  final List<EventsRow> events;
  final Function(EventsRow event)? onEventSelected;
  const EventWiseCardListWidget({super.key, required this.events, this.onEventSelected});

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) {
      if ((FFAppState().syncStatus.downloading) ||
          (FFAppState().syncStatus.uploading) ||
          !(FFAppState().syncStatus.hasSynced)) {
        return const Center(
          child: LoadingWithMessageWidget(
            message: 'Fetching events...',
          ),
        );
      }

      return const Center(
        child: NoEventFoundWidget(),
      );
    }

    return ListView.separated(
        separatorBuilder: (context, index) => SizedBox(height: 12),
        itemBuilder: (context, index) {
          return EventWiseCardWidget(
              onTap: () => onEventSelected?.call(events[index]),
              event: events[index]);
        },
        itemCount: events.length);
  }
}

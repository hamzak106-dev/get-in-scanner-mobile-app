import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:g_e_t_i_n_scanner/backend/supabase/database/database.dart';
import 'package:g_e_t_i_n_scanner/components/event_wise_card/event_wise_card_widget.dart';
import 'package:g_e_t_i_n_scanner/components/no_event_found/no_event_found_widget.dart';
import 'package:g_e_t_i_n_scanner/flutter_flow/flutter_flow_util.dart';

class EventWiseWidget extends StatefulWidget {
  final List<EventsRow> events;

  const EventWiseWidget({super.key, required this.events});

  @override
  State<EventWiseWidget> createState() => _EventWiseWidgetState();
}

class _EventWiseWidgetState extends State<EventWiseWidget> {
  initState() {
    super.initState();
  }

  EventsRow? selectedEvent;

  @override
  Widget build(BuildContext context) {
    return
        // (selectedEvent == null)
        //   ?
        widget.events.isEmpty
            ? Center(
                child: NoEventFoundWidget(),
              )
            : ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return EventWiseCardWidget(
                      onTap: () async {
                        safeSetState(() {
                          selectedEvent = widget.events[index];
                        });
                      },
                      event: widget.events[index]);
                },
                itemCount: widget.events.length);
    // : AmountEntryWidget(
    //     eventId: selectedEvent!.eventId.toString(),
    //     onContinue: () {
    //       safeSetState(() {
    //         selectedEvent = null;
    //       });
    //     },
    //   );
  }
}

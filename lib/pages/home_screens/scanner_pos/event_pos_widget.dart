import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:g_e_t_i_n_scanner/backend/supabase/database/tables/events.dart';
import 'package:g_e_t_i_n_scanner/components/event_wise_card_list/event_wise_card_list_widget.dart';
import 'package:g_e_t_i_n_scanner/components/header_card_for_tap_to_pay/header_card_for_tap_to_pay_widget.dart';
import 'package:g_e_t_i_n_scanner/components/quick_pay/quickPay_widget.dart';
import 'package:g_e_t_i_n_scanner/flutter_flow/flutter_flow_icon_button.dart'
    show FlutterFlowIconButton;
import 'package:g_e_t_i_n_scanner/flutter_flow/flutter_flow_theme.dart';
import 'package:g_e_t_i_n_scanner/flutter_flow/flutter_flow_util.dart';
import 'package:g_e_t_i_n_scanner/pages/home_screens/event_page_tickets/event_page_tickets_widget.dart';

import '/custom_code/actions/index.dart' as actions;

class ScannerPosWidget extends StatefulWidget {
  static String routeName = 'ScannerPos';
  static String routePath = '/scannerPos';

  const ScannerPosWidget({super.key});

  @override
  State<ScannerPosWidget> createState() => _ScannerPosWidgetState();
}

class _ScannerPosWidgetState extends State<ScannerPosWidget> {
  List<EventsRow> todayEvents = <EventsRow>[];

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      final events = await actions.getTodayEventsListOfUser();
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);

      final todaysEvents = <EventsRow>[];
      final otherEvents = <EventsRow>[];

      for (final event in events ?? []) {
        final startDate = DateTime(
            event.startDate.year, event.startDate.month, event.startDate.day);
        final endDate = DateTime(
            event.endDate.year, event.endDate.month, event.endDate.day);

        final isToday = !startDate.isAfter(today) && !endDate.isBefore(today);

        if (isToday) {
          todaysEvents.add(event);
        } else {
          otherEvents.add(event);
        }
      }
      todaysEvents.sort((a, b) {
        final now = DateTime.now();
        final startA = DateTime(
            now.year, now.month, now.day, a.startDate.hour, a.startDate.minute);
        final startB = DateTime(
            now.year, now.month, now.day, b.startDate.hour, b.startDate.minute);
        return startA.compareTo(startB);
      });

      otherEvents.sort((a, b) => a.startDate.compareTo(b.startDate));

// Combine
      final sortedEvents = [...todaysEvents, ...otherEvents];

      safeSetState(() {
        todayEvents = sortedEvents;
      });
    });
  }

  int selectedIndex = 0;
  EventsRow? selectedEvent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground.withValues(alpha: 0.95),
      body: SafeArea(
        top: true,
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              SizedBox(
                height: 12,
              ),
              Stack(
                children: [
                  HeaderCardForTapToPayWidget(
                    onButtonChanged: (index) {
                      safeSetState(() {
                        selectedIndex = index;
                      });
                    },
                  ),
                  if (selectedEvent != null)
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(top: 12, left: 0),
                        child: FlutterFlowIconButton(
                          buttonSize: 40.0,
                          icon: Icon(
                            FFIcons.kicArrowBack,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 24.0,
                          ),
                          onPressed: () async {
                            logFirebaseEvent('ICONBUTTON_IconButton_onPressed');
                            safeSetState(() {
                              selectedEvent = null;
                            });
                          },
                        ),
                      ),
                    ),
                ],
              ),
              if (selectedIndex == 0)
                Expanded(
                    child: QuickPayWidget(
                  events: todayEvents,
                  onEventSelected: (event) {
                    safeSetState(() {
                      selectedEvent = event;
                    });
                  },
                  selectedEvent: selectedEvent,
                ))
              else if (selectedIndex == 1)
                Expanded(
                    child: EventWiseCardListWidget(
                  events: todayEvents,
                  onEventSelected: (event) => context.pushNamed(
                      EventPageTicketsWidget.routeName,
                      pathParameters: {
                        'event_id':
                            serializeParam(event.eventId, ParamType.int)!
                      }),
                ))
              else
                Container(),
              SizedBox(height: 45),
            ].divide(SizedBox(height: 16)),
          ),
        ),
      ),
    );
  }
}

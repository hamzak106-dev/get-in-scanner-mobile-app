import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/components/icon_text_chip/icon_text_chip_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'device_ticket_summary_card_model.dart';
export 'device_ticket_summary_card_model.dart';

class DeviceTicketSummaryCardWidget extends StatefulWidget {
  const DeviceTicketSummaryCardWidget({
    super.key,
    this.attendees,
    this.logs,
  });

  final List<AttendeeRow>? attendees;
  final List<CheckInLogsRow>? logs;

  @override
  State<DeviceTicketSummaryCardWidget> createState() =>
      _DeviceTicketSummaryCardWidgetState();
}

class _DeviceTicketSummaryCardWidgetState
    extends State<DeviceTicketSummaryCardWidget> {
  late DeviceTicketSummaryCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DeviceTicketSummaryCardModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final ticket =
            widget.attendees?.unique((e) => e.ticketName).toList() ?? [];

        return Column(
          mainAxisSize: MainAxisSize.max,
          children: List.generate(ticket.length, (ticketIndex) {
            final ticketItem = ticket[ticketIndex];
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: FlutterFlowTheme.of(context).tertiary,
                  width: 1.0,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          FFIcons.kicDeck,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 20.0,
                        ),
                        Flexible(
                          child: Text(
                            ticketItem.ticketName,
                            style:
                                FlutterFlowTheme.of(context).bodyLarge.override(
                                      fontFamily: 'MonaSans',
                                      letterSpacing: 0.0,
                                    ),
                          ),
                        ),
                      ].divide(SizedBox(width: 16.0)),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        IconTextChipWidget(
                          key: Key('Keyaqh_${ticketIndex}_of_${ticket.length}'),
                          icon: Icon(
                            FFIcons.kicCheckFillCircle,
                            color: FlutterFlowTheme.of(context).success,
                            size: 16.0,
                          ),
                          lable: functions
                              .findTicketScanCount(
                                  widget.attendees!
                                      .where((e) =>
                                          (e.ticketName ==
                                              ticketItem.ticketName) &&
                                          (e.status ==
                                              ScanResult.CHECK_IN.name))
                                      .toList()
                                      .map((e) => e.uid)
                                      .toList(),
                                  widget.logs!
                                      .where((e) =>
                                          e.status == ScanResult.CHECK_IN.name)
                                      .toList()
                                      .map((e) => e.attendeeId)
                                      .toSet()
                                      .withoutNulls
                                      .toList())
                              .toString(),
                          spacing: 8,
                        ),
                        IconTextChipWidget(
                          key: Key('Keyso8_${ticketIndex}_of_${ticket.length}'),
                          icon: Icon(
                            FFIcons.kicCompare,
                            color: FlutterFlowTheme.of(context).secondary,
                            size: 16.0,
                          ),
                          lable: functions
                              .findTicketScanCount(
                                  widget.attendees!
                                      .where((e) =>
                                          e.ticketName == ticketItem.ticketName)
                                      .toList()
                                      .map((e) => e.uid)
                                      .toList(),
                                  widget.logs!
                                      .map((e) => e.attendeeId)
                                      .withoutNulls
                                      .toList())
                              .toString(),
                          spacing: 8,
                        ),
                      ].divide(SizedBox(width: 8.0)),
                    ),
                  ].divide(SizedBox(height: 20.0)),
                ),
              ),
            );
          }).divide(SizedBox(height: 20.0)),
        );
      },
    );
  }
}

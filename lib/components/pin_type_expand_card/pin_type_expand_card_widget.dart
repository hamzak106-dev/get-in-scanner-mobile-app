import '/backend/supabase/supabase.dart';
import '/components/device_ticket_summary_card/device_ticket_summary_card_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'pin_type_expand_card_model.dart';
export 'pin_type_expand_card_model.dart';

class PinTypeExpandCardWidget extends StatefulWidget {
  const PinTypeExpandCardWidget({
    super.key,
    this.pin,
    this.attendee,
    this.logs,
    this.devices,
  });

  final PinRow? pin;
  final List<AttendeeRow>? attendee;
  final List<CheckInLogsRow>? logs;
  final List<DeviceRow>? devices;

  @override
  State<PinTypeExpandCardWidget> createState() =>
      _PinTypeExpandCardWidgetState();
}

class _PinTypeExpandCardWidgetState extends State<PinTypeExpandCardWidget> {
  late PinTypeExpandCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PinTypeExpandCardModel());
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
        final deviceData = widget.devices?.toList() ?? [];

        return Column(
          mainAxisSize: MainAxisSize.max,
          children: List.generate(deviceData.length, (deviceDataIndex) {
            final deviceDataItem = deviceData[deviceDataIndex];
            return custom_widgets.DeviceExpandedCard(
              width: double.infinity,
              height: 60.0,
              device: deviceDataItem,
              child: () => DeviceTicketSummaryCardWidget(
                attendees: widget.attendee,
                logs: widget.logs
                    ?.where((e) => e.deviceId == deviceDataItem.uid)
                    .toList(),
              ),
            );
          }).divide(SizedBox(height: 16.0)),
        );
      },
    );
  }
}

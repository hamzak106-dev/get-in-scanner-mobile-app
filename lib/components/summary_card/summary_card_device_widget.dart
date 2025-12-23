import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/components/icon_text_chip/icon_text_chip_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'summary_card_model.dart';
export 'summary_card_model.dart';

class SummaryCardDeviceWidget extends StatefulWidget {
  const SummaryCardDeviceWidget({
    super.key,
    required this.icon,
    required this.summary,
    required this.eventIds,
  });

  final Widget? icon;
  final SummaryStruct? summary;
  final List<int> eventIds;


  @override
  State<SummaryCardDeviceWidget> createState() => _SummaryCardDeviceWidgetState();
}

class _SummaryCardDeviceWidgetState extends State<SummaryCardDeviceWidget> {
  late SummaryCardModel _model;
  bool _isExpanded = false;
  List<Map<String, dynamic>> _deviceTickets = [];
  bool _isLoading = false;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SummaryCardModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  Future<void> _fetchDeviceTickets() async {
    if (_isLoading || widget.summary?.value == null) return;
    
    setState(() {
      _isLoading = true;
    });

    try {
      final deviceId = widget.summary!.value;
      final results = await actions.getDeviceTickets(deviceId, widget.eventIds);
      setState(() {
        _deviceTickets = results;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Error fetching device tickets: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded && _deviceTickets.isEmpty) {
        _fetchDeviceTickets();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: InkWell(
              onTap: _toggleExpanded,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      valueOrDefault<String>(
                        widget.summary?.name,
                        '-',
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Mona Sans',
                            letterSpacing: 0.0,
                          ),
                    ),
                  ),
                  Icon(
                    _isExpanded ? FFIcons.kicArrowUp : FFIcons.kicArrowDown,
                    color: FlutterFlowTheme.of(context).secondaryText,
                    size: 24.0,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (_isExpanded) ...[
          SizedBox(height: 12.0),
          if (_isLoading)
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: CircularProgressIndicator(
                  color: FlutterFlowTheme.of(context).secondary,
                ),
              ),
            )
          else if (_deviceTickets.isEmpty)
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'No tickets found',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Mona Sans',
                      letterSpacing: 0.0,
                      color: FlutterFlowTheme.of(context).secondaryText,
                    ),
              ),
            )
          else
            ..._deviceTickets.map((ticket) {
              final ticketName = ticket['ticket_name']?.toString() ?? '-';
              final deviceCount = ticket['device_count']?.toString() ?? '0';
              return Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  border: Border.all(
                    color: FlutterFlowTheme.of(context).customDarkBlue,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(
                        FFIcons.kicDeck,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 20.0,
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: Text(
                          ticketName,
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Mona Sans',
                                letterSpacing: 0.0,
                              ),
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        deviceCount,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Mona Sans',
                              letterSpacing: 0.0,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
        ],
      ],
    );
  }
}

import 'package:flutter_svg/svg.dart';
import 'package:g_e_t_i_n_scanner/components/summary_card/summary_card_device_widget.dart';

import '../../../pages/home_screens/add_ons_list_screen/add_ons_list_screen_widget.dart';
import '../../../pages/home_screens/attendees_detail_screen/attendees_detail_screen_model.dart';
import '../../attendee_detail_tile/attendee_detail_tile_widget.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/components/count_details_card/count_details_card_widget.dart';
import '/components/no_data_found/no_data_found_widget.dart';
import '/components/summary_card/summary_card_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'scanner_summary_model.dart';
export 'scanner_summary_model.dart';

class ScannerSummaryWidget extends StatefulWidget {
  const ScannerSummaryWidget({
    super.key,
    required this.event,
  });

  final List<EventsRow>? event;

  @override
  State<ScannerSummaryWidget> createState() => _ScannerSummaryWidgetState();
}

class _ScannerSummaryWidgetState extends State<ScannerSummaryWidget>
    with TickerProviderStateMixin {
  late ScannerSummaryModel _model;
  late AttendeesDetailScreenModel _model2;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ScannerSummaryModel());
    _model2 = createModel(context, () => AttendeesDetailScreenModel());

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('SCANNER_SUMMARY_ScannerSummary_ON_INIT_S');
      await actions.watchAuthorisedAttendees(
        (result) async {
          _model.attendeesResponse = await actions.getAttendeeList(
            result?.toList(),
          );
          _model.attendees =
              _model.attendeesResponse!.toList().cast<AttendeeRow>();
          safeSetState(() {});
        },
        widget.event!.map((e) => e.eventId).toList().toList(),
        true,
        AccessPermission.stats,
      );
      await actions.watchByTicketSummary(
        (ticketsSummary) async {
          _model.ticketSummary = ticketsSummary!.toList().cast<SummaryStruct>();
          safeSetState(() {});
        },
        widget.event!.map((e) => e.eventId).toList().toList(),
      );
      await actions.watchByDeviceSummary(
        (devicesSummary) async {
          _model.deviceSummary = devicesSummary!.toList().cast<SummaryStruct>();
          safeSetState(() {});
        },
        widget.event!.map((e) => e.eventId).toList().toList(),
      );
    });
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Align(
          alignment: AlignmentDirectional(-1.0, 0.0),
          child: TabBar(
            isScrollable: true,
            labelColor: FlutterFlowTheme.of(context).primaryText,
            unselectedLabelColor: FlutterFlowTheme.of(context).secondaryText,
            labelStyle: FlutterFlowTheme.of(context).titleMedium.override(
                  fontFamily: 'Mona Sans',
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                ),
            unselectedLabelStyle:
                FlutterFlowTheme.of(context).titleMedium.override(
                      fontFamily: 'Mona Sans',
                      fontSize: 16.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                    ),
            indicatorColor: FlutterFlowTheme.of(context).secondary,
            tabAlignment: TabAlignment.start,
            tabs: [
              Tab(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text('Tickets'),
                ),
              ),
              Tab(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text('Add-Ons'),
                ),
              ),
            ],
            controller: _model.tabBarController,
            onTap: (i) async {
              [() async {}, () async {}][i]();
            },
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _model.tabBarController,
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Column(
                          children: [
                        wrapWithModel(
                          model: _model.countDetailsCardModel1,
                          updateCallback: () => safeSetState(() {}),
                          child: CountDetailsCardWidget(
                            img: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/g-e-t-i-n-scanner-prototypev2-a61ogi/assets/6ngzmv0djer1/checked-in.png',
                                width: 40.0,
                                height: 40.0,
                                fit: BoxFit.none,
                              ),
                            ),
                            count: _model.attendees
                                .where(
                                    (e) => e.status == ScanResult.CHECK_IN.name)
                                .toList()
                                .length,
                            lable: 'Checked In',
                          ),
                        ),
                        wrapWithModel(
                          model: _model.countDetailsCardModel2,
                          updateCallback: () => safeSetState(() {}),
                          child: CountDetailsCardWidget(
                            img: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/g-e-t-i-n-scanner-prototypev2-a61ogi/assets/5jvmygdig7qz/absent.png',
                                width: 40.0,
                                height: 40.0,
                                fit: BoxFit.none,
                              ),
                            ),
                            count: _model.attendees
                                .where(
                                    (e) => e.status == null || e.status == '')
                                .toList()
                                .length,
                            lable: 'Absent',
                          ),
                        ),
                        wrapWithModel(
                          model: _model.countDetailsCardModel3,
                          updateCallback: () => safeSetState(() {}),
                          child: CountDetailsCardWidget(
                            img: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/g-e-t-i-n-scanner-prototypev2-a61ogi/assets/udm4fp8yq2dd/total.png',
                                width: 40.0,
                                height: 40.0,
                                fit: BoxFit.none,
                              ),
                            ),
                            count: _model.attendees.length,
                            lable: 'Total',
                          ),
                        ),
                      ].paddingTopEach(10.0),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 48.0,
                    decoration: BoxDecoration(
                      color: Color(0xCC0E0F11),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                logFirebaseEvent(
                                    'SCANNER_SUMMARY_Container_09w1bq7f_ON_TA');
                                _model.byTicket = true;
                                safeSetState(() {});
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: _model.byTicket
                                      ? Colors.white
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(50.0),
                                  shape: BoxShape.rectangle,
                                ),
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Builder(
                                  builder: (context) {
                                    if (_model.byTicket) {
                                      return Text(
                                        'By Ticket Type',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'MonaSans',
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                              color: _model.byTicket
                                                  ? Colors.black
                                                  : FlutterFlowTheme.of(context)
                                                      .tertiary,
                                            ),
                                      );
                                    } else {
                                      return Text(
                                        'By Ticket Type',
                                        style: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'MonaSans',
                                              letterSpacing: 0.0,
                                            ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                logFirebaseEvent(
                                    'SCANNER_SUMMARY_Container_esmexos1_ON_TA');
                                _model.byTicket = false;
                                safeSetState(() {});
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: !_model.byTicket
                                      ? Colors.white
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(50.0),
                                  shape: BoxShape.rectangle,
                                ),
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Builder(
                                  builder: (context) {
                                    if (!_model.byTicket) {
                                      return Text(
                                        'By Device Type',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'MonaSans',
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                              color: !_model.byTicket
                                                  ? Colors.black
                                                  : FlutterFlowTheme.of(context)
                                                      .tertiary,
                                            ),
                                      );
                                    } else {
                                      return Text(
                                        'By Device Type',
                                        style: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'MonaSans',
                                              letterSpacing: 0.0,
                                            ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ].divide(SizedBox(width: 6.0)),
                      ),
                    ),
                  ),
                  Builder(
                    builder: (context) {
                      if (_model.byTicket) {
                        return Builder(
                          builder: (context) {
                            final ticketData = _model.ticketSummary.toList();
                            if (ticketData.isEmpty) {
                              return Center(
                                child: NoDataFoundWidget(),
                              );
                            }

                            return ListView.separated(
                              padding: EdgeInsets.zero,
                              primary: false,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: ticketData.length,
                              separatorBuilder: (_, __) =>
                                  SizedBox(height: 20.0),
                              itemBuilder: (context, ticketDataIndex) {
                                final ticketDataItem =
                                    ticketData[ticketDataIndex];
                                return wrapWithModel(
                                  model: _model.summaryCardModels2.getModel(
                                    ticketDataIndex.toString(),
                                    ticketDataIndex,
                                  ),
                                  updateCallback: () => safeSetState(() {}),
                                  child: SummaryCardWidget(
                                    key: Key(
                                      'Key2ug_${ticketDataIndex.toString()}',
                                    ),
                                    icon: Icon(
                                      FFIcons.kicDeck,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 20.0,
                                    ),
                                    byPin: !_model.byTicket,
                                    summary: ticketDataItem,
                                  ),
                                );
                              },
                            );
                          },
                        );
                      } else {
                        return Builder(
                          builder: (context) {
                            final deviceData = _model.deviceSummary.toList();
                            if (deviceData.isEmpty) {
                              return Center(
                                child: NoDataFoundWidget(),
                              );
                            }
                            return ListView.separated(
                              padding: EdgeInsets.zero,
                              primary: false,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: deviceData.length,
                              separatorBuilder: (_, __) =>
                                  SizedBox(height: 20.0),
                              itemBuilder: (context, deviceDataIndex) {
                                final deviceDataItem =
                                    deviceData[deviceDataIndex];
                                return wrapWithModel(
                                  model: _model.summaryCardModels1.getModel(
                                    deviceDataIndex.toString(),
                                    deviceDataIndex,
                                  ),
                                  updateCallback: () => safeSetState(() {}),
                                  child: SummaryCardDeviceWidget(
                                    key: Key(
                                      'Keymfp_${deviceDataIndex.toString()}',
                                    ),
                                    icon: Icon(
                                      FFIcons.kicMobile,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 20.0,
                                    ),
                                    summary: deviceDataItem,
                                    eventIds: widget.event!.map((e) => e.eventId).toList(),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      }
                    },
                  ),
                    ].divide(SizedBox(height: 30.0)),
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).secondaryBackground,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child: Image.network(
                                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/g-e-t-i-n-scanner-prototypev2-a61ogi/assets/op3ah4yv0ask/today.png',
                                          width: 40.0,
                                          height: 40.0,
                                          fit: BoxFit.none,
                                        ),
                                      ),
                                      Text(
                                        'Today',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Mona Sans',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ].divide(SizedBox(width: 12.0)),
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.countDetailsCardModel1,
                                  updateCallback: () => safeSetState(() {}),
                                  child: Text(
                                    _model.attendees
                                        .where((att) =>
                                            att.status == ScanResult.CHECK_IN.name)
                                        .fold<int>(
                                            0,
                                            (count, att) =>
                                                count + att.addOns.length)
                                        .toString(),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Mona Sans',
                                          fontSize: 24.0,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).secondaryBackground,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child: Image.network(
                                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/g-e-t-i-n-scanner-prototypev2-a61ogi/assets/chv408l2fbxw/addons_sold.png',
                                          width: 40.0,
                                          height: 40.0,
                                          fit: BoxFit.none,
                                        ),
                                      ),
                                      Text(
                                        'Add-Ons Sold',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Mona Sans',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ].divide(SizedBox(width: 12.0)),
                                  ),
                                ),
                                Text(
                                  _model.attendees
                                      .map((attendee) => attendee.addOns.length)
                                      .fold<int>(
                                          0, (sum, addOnCount) => sum + addOnCount)
                                      .toString(),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Mona Sans',
                                        fontSize: 24.0,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).secondaryBackground,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child: Image.network(
                                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/g-e-t-i-n-scanner-prototypev2-a61ogi/assets/j4rcbapa8nwr/total_face_value.png',
                                          width: 40.0,
                                          height: 40.0,
                                          fit: BoxFit.none,
                                        ),
                                      ),
                                      Text(
                                        'Total Face Value',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Mona Sans',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ].divide(SizedBox(width: 12.0)),
                                  ),
                                ),
                                Text(
                                  _model.attendees
                                      .expand((attendee) => attendee.addOns)
                                      .fold<double>(
                                  0.0,
                                  (sum, addOn) {
                                    final price =
                                        double.tryParse(addOn.price.toString()) ??
                                            0.0;
                                    return sum + price;
                                  },
                                ).toStringAsFixed(0),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Mona Sans',
                                        fontSize: 24.0,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

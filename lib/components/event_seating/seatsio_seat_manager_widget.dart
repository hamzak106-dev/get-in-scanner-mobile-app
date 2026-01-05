import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:g_e_t_i_n_scanner/components/event_seating/selected_info_card.dart';
import 'package:g_e_t_i_n_scanner/components/event_seating/ticket_transfer_card.dart';
import 'package:g_e_t_i_n_scanner/flutter_flow/flutter_flow_util.dart';
import 'package:seatsio/seatsio.dart';
import 'package:built_collection/built_collection.dart';
import '../../backend/supabase/database/tables/attendee.dart';
import '../../custom_code/widgets/filter_pop_up.dart' as custom_widgets;
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../pages/home_screens/attendees_detail_screen/attendees_detail_screen_model.dart';
import 'assigned_info_card.dart';
import 'not_selected_info_card.dart';
// public keys
//
// c9c97b92-2315-40d4-90e0-2b58fe2d151f - stage
// 4443593e-f4ce-4c87-b38b-af550f310f90 - prod
const String YourWorkspaceKey = "c9c97b92-2315-40d4-90e0-2b58fe2d151f";
const String YourEventKey = "124b637c-a0a8-464b-97e9-10da1d900200";

class SeatsioSeatManagerWidget extends StatefulWidget {
  final AttendeesDetailScreenModel? attendeeModel;

  const SeatsioSeatManagerWidget({super.key, this.attendeeModel,});
  static String routeName = 'SeatsIOSeatManager';
  static String routePath = '/SeatsIOSeatManager';
  @override
  State<SeatsioSeatManagerWidget> createState() => _SeatsioSeatManagerWidgetState();
}

class _SeatsioSeatManagerWidgetState extends State<SeatsioSeatManagerWidget> {


  final scaffoldKey = GlobalKey<ScaffoldState>();


  SeatsioWebViewController? _seatsioController;
  final List<String> selectedObjectLabels = ['Try to click a seat object'];
  late final SeatingChartConfig _chartConfig;
  SeatsioObject? _currentSeat;
  List<SeatsioObject> seats=[];

  void _showTransferTicketSheet(SeatsioObject seat, ) {
    final seatLabel = seat.label ?? seat.id ?? seat.uuid ?? 'unknown';
    if (seatLabel == 'unknown') return;

    final section = seat.category?.label ?? '-';
    final row = seat.labelDetail?.parent?.toString() ?? '-';
    final seatNumber = seat.labelDetail?.own?.toString() ?? '-';
    print("Total Selected Seats ${seats.length}");

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return TransferTicketCard(seat: seats,attendeeModel: widget.attendeeModel,);
      },
    );
  }

  void _showAssignedSeatSheet(SeatsioObject seat, String price) {
    final seatLabel = seat.label ?? seat.id ?? seat.uuid ?? 'unknown';
    if (seatLabel == 'unknown') return;

    final section = seat.category?.label ?? '-';
    final row = seat.labelDetail?.parent?.toString() ?? '-';
    final seatNumber = seat.labelDetail?.own?.toString() ?? '-';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: SizedBox(
            height: 300,
            child: AssignedInfoCard(
              section: section,
              row: row,
              seat: seatNumber,
              price: price,
              onSelect: () {
                _showTransferTicketSheet(seat);
              },
              onDismiss: () {
                setState(() => selectedObjectLabels.remove(seatLabel));
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
  }
  void _selectSeat(SeatsioObject object) {

    final seatLabel = object.label ?? object.id ?? object.uuid;
    if (seatLabel == null) return;
    // Seat is free → select it if not already selected
    setState(() {
      _currentSeat = object;
      selectedObjectLabels.add(seatLabel);
      seats.add(object);
    });

    // Block selection if seat is not free
    if (!isSeatAvailable(object)) {
      print("Seat $seatLabel is NOT free, cannot select");
      _showNotSelectedSeatSheet(object);

      // Make sure chart visually deselects it
      // _seatsioController?.evaluateJavascript('chart.deselectObjects(["$seatLabel"]);');
      return;
    }



      // Make chart reflect selection
      _seatsioController?.evaluateJavascript('chart.selectObjects(["$seatLabel"]);');


    // Show bottom sheet
    _showSelectedSeatSheet(object);
  }

  bool isSeatAvailable(SeatsioObject seat) {
    final status = seat.status ?? 'unknown';
    print("Seat '${seat.label ?? seat.id ?? seat.uuid}': status = $status");

    // Only allow selection if seat is completely free
    if (status != 'free') {
      print("Cannot select seat because status = $status");
      return false;
    }
    return true;
  }

  void _showNotSelectedSeatSheet(SeatsioObject seat) {
    final seatLabel = seat.label ?? seat.id ?? seat.uuid ?? 'unknown';
    if (seatLabel == 'unknown') return;

    final section = seat.category?.label ?? '-';
    final row = seat.labelDetail?.parent?.toString() ?? '-';
    final seatNumber = seat.labelDetail?.own?.toString() ?? '-';
    String price = "N/A";

    if (_chartConfig.pricing != null) {
      final matched = _chartConfig.pricing!.firstWhere(
            (p) => p.category == seat.category?.label,
        orElse: () => PricingForCategory((b) => b
          ..category = seat.category?.label ?? '-'
          ..price = 0),
      );
      price = matched.price.toString();
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: SizedBox(
            height: 300,
            // height:isSeatAvailable(seat)? 300:250,
            child: NotSelectedInfoCard(
              section: section,
              row: row,
              seat: seatNumber,
              price: price,
              onSelect: () {
                // First close current sheet
                Navigator.pop(context);

                // Wait for the pop animation to finish, then open selected sheet
                Future.delayed(const Duration(milliseconds: 200), () {
                  setState(() => selectedObjectLabels.add(seatLabel));
                  _showSelectedSeatSheet(seat);
                });
              },
              onDismiss: () {
                Navigator.pop(context);
                _deselectSeat(seat);
              },
              status: true,
              // status: isSeatAvailable(seat),
            ),
          ),
        );
      },
    );
  }

  void _showSelectedSeatSheet(SeatsioObject seat) {
    final seatLabel = seat.label ?? seat.id ?? seat.uuid ?? 'unknown';
    if (seatLabel == 'unknown') return;

    final section = seat.category?.label ?? '-';
    final row = seat.labelDetail?.parent?.toString() ?? '-';
    final seatNumber = seat.labelDetail?.own?.toString() ?? '-';
    String price = "N/A";

    if (_chartConfig.pricing != null) {
      final matched = _chartConfig.pricing!.firstWhere(
            (p) => p.category == seat.category?.label,
        orElse: () => PricingForCategory((b) => b
          ..category = seat.category?.label ?? '-'
          ..price = 0),
      );
      price = matched.price.toString();
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: SizedBox(
            height: 300,
            child: SelectedInfoCard(
              section: section,
              row: row,
              seat: seatNumber,
              price: price,
              onSelect: () {
                // Close this sheet first
                Navigator.pop(context);

                // Wait a little, then open the Assigned sheet
                Future.delayed(const Duration(milliseconds: 200), () {
                  setState(() => selectedObjectLabels.add(seatLabel));
                  _showAssignedSeatSheet(seat, price);
                });
              },
              onDismiss: () async{
                Navigator.pop(context);
                _deselectSeat(seat);
              },
            ),
          ),
        );
      },
    );
  }
  void _deselectSeat(SeatsioObject object) {
    final seatLabel = object.label ?? object.id ?? object.uuid;
    if (seatLabel == null) return;

    print("Deselecting seat $seatLabel");

    setState(() {
      // Remove from selected labels
      selectedObjectLabels.remove(seatLabel);

      // Remove from seats list
      seats.removeWhere((s) => s.label == seatLabel || s.id == seatLabel || s.uuid == seatLabel);

      // Clear current seat if it matches
      if (_currentSeat != null &&
          (_currentSeat!.label == seatLabel ||
              _currentSeat!.id == seatLabel ||
              _currentSeat!.uuid == seatLabel)) {
        _currentSeat = null;
      }
    });

    // Deselect on Seatsio chart
    _seatsioController?.evaluateJavascript('chart.deselectObjects(["$seatLabel"]);');
  }  void _loadSeatsio() {
    final newChartConfig = _chartConfig.rebuild((b) => b..showLegend = false);
    _seatsioController?.reload(newChartConfig);
  }


  void printAttendeeRecord(AttendeeRow attendee) {
    print('--- Attendee Record ---');
    print('UID: ${attendee.uid}');
    print('Event ID: ${attendee.eventId}');
    print('Ticket Name: ${attendee.ticketName}');
    print('Name: ${attendee.name}');
    print('Email: ${attendee.email}');
    print('Phone: ${attendee.phone}');
    print('Seat: Row ${attendee.seatRow}, Seat ${attendee.seatSeat}, Section ${attendee.seatSection}');
    print('Add-ons: ${attendee.addOns.map((a) => a.name).toList()}'); // if AddOnRow has `name`
    print('Status: ${attendee.status}');
    print('-----------------------');
  }
  void _fetchChartCategories() {
    _seatsioController?.evaluateJavascript('''
    chart.listCategories(function(categories) {
      // Send each category back to Flutter
      categories.forEach(function(c) {
        FlutterJsBridge.postMessage(JSON.stringify(c));
      });
    });
  ''');
  }



  @override
  void initState() {
    super.initState();

    // Print the attendee model for debugging
    if (widget.attendeeModel != null) {
      print("AttendeesDetailScreenModel: ${widget.attendeeModel}");
      print("Attendee details: ${widget.attendeeModel!.attendee}");
      print("Attendee name: ${widget.attendeeModel!.attendee?.name}");
      print("Attendee email: ${widget.attendeeModel!.attendee?.email}");
      // Add other fields you want to check
    } else {
      print("No attendee model passed!");
    }

    safeSetState(() {});
    _chartConfig = SeatingChartConfig.init().rebuild((b) => b
      ..workspaceKey = YourWorkspaceKey
      ..eventKey = YourEventKey
      ..pricing = ListBuilder<PricingForCategory>([
        PricingForCategory(
              (b) => b
            ..category = "D"

                ..price = 100,
        ),
      ])
      ..enableHoldSucceededCallback = true
      ..enableHoldFailedCallback = true
      ..enableHoldTokenExpiredCallback = true
      ..enableSessionInitializedCallback = true
    // ..enableObjectClickedCallback = false
      ..session = "continue");
  }


  @override
  Widget build(BuildContext context) {
    final theme =FlutterFlowTheme.of(context);
    return  Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),
        title: Text(   valueOrDefault<String>(
          widget.attendeeModel?.attendee?.name,
          '-',
        ),
          style: FlutterFlowTheme.of(context).bodySmall.override(
            fontFamily: 'Mona Sans',
            color: Colors.white,
            letterSpacing: 0.56,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),),
      ),
      body: Stack(
        children: [

          Positioned.fill(
            child: SeatsioWebView(
              onWebViewCreated: (controller) {
                _seatsioController = controller;
                _loadSeatsio();
              },
              onChartRendered: (_){
                print("Chart rendered");
                print("Getting Category");
                _fetchChartCategories();
              },

              onChartRenderingFailed: () => print("Chart rendering failed"),
              onObjectSelected: (object, type) {
                print("Selected Seats Record $object");
                _selectSeat(object);
              },
              onObjectDeselected: (object, type) {
                final seatLabel = object.label ?? object.id ?? object.uuid;
                if (seatLabel == null) return;

                if (selectedObjectLabels.contains(seatLabel)) {
                  _deselectSeat(object);
                }
              },

            ),
          ),
          Positioned(
              top: 45,
              left: 20,
              right: 20,
              child: Row(children: [
                Container(
                  height:40,
                  width: 40,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: theme.secondary600
                  ),
                  child: Icon(
                    FFIcons.kicSearchNormal,
                    color: Color(0xFF6B6D75),
                    size: 16.0,
                  ),
                ),
                Spacer(),
                Align(
                  alignment: AlignmentDirectional(0.0, 1.0),
                  child: custom_widgets.FilterPopUp(
                    width: 40.0,
                    height: 40.0,
                    onChange: (value) async {
                      logFirebaseEvent('MANAGER_DASHBOARD_FilterPopUp_ON_CHANGE');
                      safeSetState(() {});
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Container(
                    height:40,
                    width: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SvgPicture.asset("assets/svg/filter-edit.svg",height: 16,width: 16,),
                    ),
                  ),
                ),
              ],
              )),

        ],
      ),
    );

  }
}


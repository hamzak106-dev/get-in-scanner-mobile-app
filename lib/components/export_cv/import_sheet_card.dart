import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:g_e_t_i_n_scanner/components/screen_component/scanner_summary/scanner_summary_model.dart';

import '../../app_state.dart';
import '../../backend/schema/structs/summary_struct.dart';
import '../../backend/supabase/database/tables/attendee.dart';
import '../../flutter_flow/custom_functions.dart' as functions;
import '../../flutter_flow/flutter_flow_theme.dart';
import 'alert_card.dart';

class NewImportCard extends StatefulWidget {
  final ScannerSummaryModel scannerSummaryModel;

  const NewImportCard({super.key, required this.scannerSummaryModel});

  @override
  State<NewImportCard> createState() => _NewImportCardState();
}

class _NewImportCardState extends State<NewImportCard> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, -4),
              blurRadius: 20,
              spreadRadius: 0,
              color: const Color(0x33000000), // black with 20% opacity
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// DRAG HANDLE
            Container(
              width: 45,
              height: 5,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryGrey,
                borderRadius: BorderRadius.circular(2),
              ),
            ),


            /// TITLE
             Padding(
               padding: const EdgeInsets.only(top: 30,bottom: 15),
               child: Text(
                'Export',
                style: FlutterFlowTheme.of(context)
                  .titleMedium
                  .override(
                fontFamily: 'MonaSans',
                color: Colors.black,
                letterSpacing: 1,

                  fontWeight: FontWeight.w600,
                  fontSize: 16
                           ),
                           ),
             ),


            /// DESCRIPTION
            Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: FlutterFlowTheme.of(context).bodySmall.override(
                    fontFamily: 'MonaSans',
                    color: Colors.black,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                  children: [
                    const TextSpan(
                      text: 'Export the file in a structured ',
                    ),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: SvgPicture.asset(
                    'assets/svg/csv_document.svg',
                    width: 16,
                    height: 16,

                  ),
                ),
                    const TextSpan(
                      text: ' CSV\n',
                    ),
                    const TextSpan(
                      text: 'format for easy data sharing and analysis.',
                    ),
                  ],
                ),
              ),
            ),


            /// EXPORT BUTTON
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.all(10),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  showModalBottomSheet(
                    context: context,
                    isDismissible: false,
                    enableDrag: false,
                    backgroundColor: Colors.transparent,
                    transitionAnimationController: AnimationController(
                      vsync: Navigator.of(context),
                      duration: const Duration(milliseconds: 300),
                    ),
                    builder: (_){
                      final ticketSummary =
                      List<SummaryStruct>.from(widget.scannerSummaryModel.ticketSummary);
                      final deviceSummary =
                      List<SummaryStruct>.from(widget.scannerSummaryModel.deviceSummary);

                      return AlertCard(  event: functions.parseEventRow(
                        FFAppState().selectedEvent.toList(),));
                    },
                  );

                },
                child:  Text(
                  'EXPORT',
                  style: FlutterFlowTheme.of(context).labelMedium.override(
                    fontFamily: 'MonaSans',
                    color:Colors.white,
                    letterSpacing: 1,fontSize: 16,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            /// GO BACK BUTTON
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.black),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child:  Text(
                  'GO BACK',
                  style: FlutterFlowTheme.of(context).labelMedium.override(
                      fontFamily: 'MonaSans',
                      color:Colors.black,
                      letterSpacing: 1  ,fontSize: 16,
                      fontWeight: FontWeight.w600
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

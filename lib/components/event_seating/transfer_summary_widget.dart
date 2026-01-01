import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:g_e_t_i_n_scanner/components/custom_button/custom_button_widget.dart';
import 'package:g_e_t_i_n_scanner/components/event_seating/ticket_transfer_widget.dart';
import 'package:seatsio/seatsio.dart';

import '../../flutter_flow/flutter_flow_theme.dart';
import '../../pages/home_screens/attendees_detail_screen/attendees_detail_screen_model.dart';
class TransferSummaryWidget extends StatefulWidget {
  final  SeatsioObject? seat;
  final  AttendeesDetailScreenModel? attendeeModel;
  const TransferSummaryWidget({super.key,  this.seat, this.attendeeModel});

  static String routeName = 'TransferSummaryWidget';
  static String routePath = '/TransferSummaryWidget';
  @override
  State<TransferSummaryWidget> createState() => _TransferSummaryWidgetState();
}

class _TransferSummaryWidgetState extends State<TransferSummaryWidget> {

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leadingWidth: 80,
        leading:GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(9),
            child: Container(
              height: 35,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(217, 217, 217, 0.2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 20,
                    spreadRadius: 0,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 20,

                  ),
                ),
              ),
            ),
          ),
        ),

        centerTitle: true,
        title: Text(
          'TRANSFER SUMMERY',
          style: FlutterFlowTheme.of(context).bodyMedium.override(
            fontFamily: 'Mona Sans',
            color: Colors.white,
            letterSpacing: 0.64,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height:500,
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Title
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              'X1 TICKETS',
                              style: theme.titleMedium.copyWith(
                                fontFamily: 'MonaSans',
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.8,
                                color: Colors.black,
                                fontSize: 16
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                'GA (ENTRY ANYTIME) (FIRST RELEASE)',
                                style: theme.labelSmall.copyWith(
                                  fontFamily: 'MonaSans',
                                  color: theme.secondaryGrey,
                                  letterSpacing: 0.8,
                                  fontSize: 10
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Divider(color: theme.naturalLight),
                    ),
                  
                  
                    /// Description
                    Text.rich(
                      TextSpan(
                        style: theme.bodySmall.copyWith(
                          fontFamily: 'MonaSans',
                          color: theme.tertiary200,
                        ),
                        children: [
                          const TextSpan(
                            text: 'You are about to transfer the ticket to ',
                          ),
                          TextSpan(
                            text: '+1234 76999',
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.14
                            ),
                          ),
                          const TextSpan(
                            text:
                            ', recipient will be notified via email but need to login '
                                'with their phone number.\n\n'
                                'Once confirmed, the transfer is irreversible, and '
                                'refunds go to the original buyer.',
                          ),
                        ],
                      ),
                    ),
                  
                  
                    const SizedBox(height: 20),
                  
                    /// Receiver Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Receiver',
                          style: theme.labelMedium.copyWith(
                            fontFamily: 'MonaSans',
                            color: theme.secondary200,
                            fontSize: 14
                          ),
                        ),
                  
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Ben Hopkins',
                          style: theme.bodyMedium.copyWith(
                            fontFamily: 'MonaSans',
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            height: 1
                          ),
                        ),
                        Text(
                          'US\$80',
                          style: theme.bodyMedium.copyWith(
                              fontFamily: 'MonaSans',
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              height: 1
                  
                          ),
                        ),
                      ],
                    ),
                  
                    const SizedBox(height: 16),
                    Divider(color: theme.naturalLight),
                  
                    const SizedBox(height: 16),
                  
                    /// Info bullets
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset("assets/svg/sms-notification.svg",
                      height:14 ,
                      width: 14,),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "The ticket will appear in the My Tickets page of their Getin app",
                        style: theme.bodySmall.copyWith(
                          fontFamily: 'MonaSans',
                          color: Colors.black,
                          height: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              Padding(
                padding: const EdgeInsets.only(top: 11,bottom: 30),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   Image.asset("assets/icons/mobile.png",
                   height:14 ,
                   width: 14,),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "The ticket will appear in the My Tickets page of their Getin app",
                        style: theme.bodySmall.copyWith(
                          fontFamily: 'MonaSans',
                          color: Colors.black,
                          height: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

                    /// Confirm Button
                    CustomButtonWidget(
                       buttonColor: Colors.black,
                        textColor: Colors.white,
                        title: "CONFIRM & SEND TICKET", onTap: ()async{
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>TicketTransferWidget(
                           attendeeModel: widget.attendeeModel,
                         )));
                    }),
                    SizedBox(height: 15,)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20,bottom: 15,left: 20,right: 20
                ),
                child: Divider(
                  height: 1,
                  color: theme.overlayLight,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Need Help?",style: theme.titleSmall.copyWith(
                      color: Colors.white,
                      fontFamily: 'MonaSans',
                      fontSize: 14,
                      fontWeight: FontWeight.w400
                  
                  
                  
                  
                    ),),
                    SvgPicture.asset("assets/svg/message-question.svg",height: 18.823528289794922,
                    width: 18.823528289794922,
                    color: Colors.white,)
                  
                  ],
                ),
              )
              
            ],
          ),
        ),
      ),



    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../flutter_flow/flutter_flow_theme.dart';
import '../../pages/home_screens/attendees_detail_screen/attendees_detail_screen_model.dart';
import '../custom_button/custom_button_widget.dart';
class TicketTransferWidget extends StatefulWidget {
  final  AttendeesDetailScreenModel? attendeeModel;

  const TicketTransferWidget({super.key, this.attendeeModel});

  @override
  State<TicketTransferWidget> createState() => _TicketTransferWidgetState();
}

class _TicketTransferWidgetState extends State<TicketTransferWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: SizedBox.shrink(),

        centerTitle: true,
        title: Text(
          'THE TICKET HAS \nBEEN TRANSFERRED',
          textAlign: TextAlign.center,

          style: FlutterFlowTheme.of(context).bodyMedium.override(
            fontFamily: 'Mona Sans',
            color: Colors.white,
            letterSpacing: 1,


            fontSize:20,
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
                height:370,
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
                            Icon(
                                Icons.check_circle_outline,
                              color: FlutterFlowTheme.of(context).success,
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                'X1 TICKETS',
                                style: theme.titleMedium.copyWith(
                                    fontFamily: 'MonaSans',
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.8,
                                    color: Colors.black,
                                    fontSize: 16
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10,),
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
                      padding: const EdgeInsets.only(top: 4),
                      child: Divider(color: theme.naturalLight),
                    ),


                    /// Description



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

                    const SizedBox(height: 4),
                    Divider(color: theme.naturalLight),

                    const SizedBox(height: 16),

                    /// Info bullets
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset("assets/svg/ticket.svg",
                          height:14 ,
                          width: 14,),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "Relax, We’ve sent the ticket to the recipient via SMS. Please note that the ticket will only be available in their Getin app",
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
                          SvgPicture.asset("assets/svg/information.svg",
                            height:14 ,
                            width: 14,
                          color: theme.errorRed,),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              "The receiver has 48 hours to approve the transfer. If they don't, the ticket will return to the current ticket holder.",
                              style: theme.bodySmall.copyWith(
                                fontFamily: 'MonaSans',
                                color: theme.errorRed,
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
                        title: "BACK TO WALLET", onTap: ()async{
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



    );  }
}

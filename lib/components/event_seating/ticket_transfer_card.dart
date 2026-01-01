import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:g_e_t_i_n_scanner/components/event_seating/transfer_summary_widget.dart';
import 'package:g_e_t_i_n_scanner/components/simple_text_field/simple_text_field_widget_2.dart';

import 'package:g_e_t_i_n_scanner/flutter_flow/flutter_flow_icon_button.dart';
import 'package:g_e_t_i_n_scanner/flutter_flow/flutter_flow_theme.dart';
import 'package:g_e_t_i_n_scanner/flutter_flow/custom_functions.dart' as functions;
import 'package:seatsio/seatsio.dart';
import '../../custom_code/widgets/mobile_number_text_field_widget_2.dart';
import '../../custom_code/widgets/mobile_number_text_field_widget_2.dart' as custom_widgets;
import '../../pages/home_screens/attendees_detail_screen/attendees_detail_screen_model.dart';
import '../simple_text_field/simple_text_field_widget.dart';
import '/components/custom_button/custom_button_widget.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:provider/provider.dart';

class TransferTicketCard extends StatefulWidget {
 final  SeatsioObject seat;
 final  AttendeesDetailScreenModel? attendeeModel;

 const TransferTicketCard({super.key, required this.seat, this.attendeeModel});

  @override
  _TransferTicketCardState createState() => _TransferTicketCardState();
}

class _TransferTicketCardState extends State<TransferTicketCard> {
  late String _phoneNumber;
  late String _email;
  late String _countryCode;
  late String _errorText;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _phoneNumber = '';
    _email = '';
    _countryCode = '+1'; // Default country code
    _errorText = '';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 530,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
                topRight: Radius.circular(10)
          )

        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12,bottom: 30),
                      child: Container(
                        width: 110,
                        height: 5,
                        decoration: BoxDecoration(
                          color:FlutterFlowTheme.of(context).tertiary800,
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  ],
                ),

                Text(
                  'Transfer Ticket?',
                  textAlign:TextAlign.center,

                  style: FlutterFlowTheme.of(context).headlineMedium.override(
                    fontFamily: 'MonaSans',
                    fontSize: 18,
                    color: Colors.black,
                    letterSpacing: 0.18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15,bottom: 8),
                  child: Text("Who do you want to give your ticket to?",
                    style: FlutterFlowTheme.of(context).bodySmall.override(
                      fontFamily: 'MonaSans',
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black
                    ),),
                ),
                Text(
                  'Fill in the recipient\'s information, and the ticket will be sent directly to them.',
                  style: FlutterFlowTheme.of(context).bodySmall.override(
                    fontFamily: 'MonaSans',
                    fontSize: 14.0,
                      letterSpacing: 0.14,
                    color:FlutterFlowTheme.of(context).tertiary200
                  ),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 30.0),
                // Mobile number text field
                custom_widgets.MobileNumberTextFieldWidget2(
                  width: double.infinity,
                  height: 48,
                  hintText: '12345678',
                  fillColor: FlutterFlowTheme.of(context).overlayLight,
                  phoneNumber: _phoneNumber,
                  onChange: (countryCode, phoneNumber, dialCode) async {
                    setState(() {
                      _countryCode = countryCode;
                      _phoneNumber = phoneNumber??"";
                    });
                  },
                ),
                const SizedBox(height: 12),
                // Email Text Field
                SimpleTextFieldWidget2(
                  hintText: 'mail@mail.com',

                ),
                // Error text display
                const SizedBox(height: 20.0),
                // Transfer Button
                CustomButtonWidget(
                  title: 'TRANSFER',
                  buttonColor: Colors.black,
                  textColor: Colors.white,
                  onTap: () async{
                    if (_phoneNumber.isEmpty && _email.isEmpty) {
                      setState(() {
                        _errorText = 'Please provide either a phone number or an email.';
                      });
                    }

                    setState(() {
                      _errorText = '';
                    });

                    // Simulate transfer logic (this is where you would call your backend)
                    context.pushNamed(
                      TransferSummaryWidget.routeName,
                      queryParameters: {
                        'seat': serializeParam(
                          widget.seat,
                          ParamType.JSON,
                        ),
                        'attendeeModel': serializeParam(
                          widget.attendeeModel,
                          ParamType.JSON,
                        ),
                      },
                    );
                  },
                ),
                // Cancel Button
                Padding(
                  padding: const EdgeInsets.only(top: 15,bottom: 40),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        elevation: 0,
                        side: const BorderSide(
                          color: Colors.red,
                          width: 1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        "CANCEL",
                        style: FlutterFlowTheme.of(context).titleLarge.copyWith(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          letterSpacing: 0.8,
                          fontFamily: 'MonaSans',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:g_e_t_i_n_scanner/backend/api_requests/api_calls.dart';
import 'package:g_e_t_i_n_scanner/components/event_page_components/event_title/event_title_widget.dart'
    show EventTitleWidget;
import 'package:g_e_t_i_n_scanner/config/flavor_helper.dart';
import 'package:g_e_t_i_n_scanner/custom_code/actions/get_event_by_event_id.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '../../../custom_code/widgets/index.dart';
import 'event_page_purchaser_details_model.dart';

export 'event_page_purchaser_details_model.dart';

class EventPagePurchaserDetailsWidget extends StatefulWidget {
  final int eventId;
  final String? hash;

  const EventPagePurchaserDetailsWidget(
      {super.key, required this.eventId, this.hash});

  static String routeName = 'eventPagePurchaserDetails';
  static String routePath = '/eventPagePurchaserDetails/:event_id/:hash';

  @override
  State<EventPagePurchaserDetailsWidget> createState() =>
      _EventPagePurchaserDetailsWidgetState();
}

class _EventPagePurchaserDetailsWidgetState
    extends State<EventPagePurchaserDetailsWidget> {
  late EventPagePurchaserDetailsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EventPagePurchaserDetailsModel());

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('event_page_purchaser_details_fetch_event');
      _model.event = await getEventByEventId(widget.eventId);
      safeSetState(() {});
    });

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'EventPagePurchaserDetails'});
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: PopScope(
        canPop: true,
        onPopInvokedWithResult: (_, __) async {
          _backendCall();
        },
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Builder(builder: (context) {
                      DateTime now = DateTime.now();
                      return wrapWithModel(
                        model: _model.eventTitleModel,
                        updateCallback: () => safeSetState(() {}),
                        child: EventTitleWidget(
                          eventAddress: _model.event?.address,
                          eventTitle: _model.event?.title,
                          eventImg: _model.event?.event_image,
                          eventDate: DateTime(
                            now.year,
                            now.month,
                            now.day,
                            _model.event?.startDate.hour ?? 0,
                            _model.event?.startDate.minute ?? 0,
                          ),
                          onBack: ()=>_backendCall(),
                        ),
                      );
                    }),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(20.0, 00.0, 20.0, 20.0),
                      child: Column(
                        children: [
                          Form(
                            key: _model.formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 16),
                                Text(
                                  "Purchaser Details",
                                  maxLines: 2,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Mona Sans',
                                        fontSize: 20.0,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                                SizedBox(height: 16),
                                EventPurchaserFornfield(
                                  controller: _model.fullNameController,
                                  hintText: 'Full Name',
                                  validator: _model.fullNameControllerValidator,
                                ),
                                SizedBox(height: 16.0),
                                MobileNumberTextFieldWidget(
                                  width: double.infinity,
                                  fillColor: const Color(0xD9D9D933)
                                      .withValues(alpha: 0.1),
                                  hintText: 'Phone No.',
                                  onChange:
                                      (countryCode, phoneNumber, dialCode) async {
                                    logFirebaseEvent(
                                        'event_page_purchaser_details_phone_no_onChange');
                                    _model.phoneNumber = phoneNumber;
                                    _model.countryCode = countryCode;
                                    _model.dialCode = dialCode;
                                  },
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 22, vertical: 0),
                                ),
                                SizedBox(height: 16.0),
                                EventPurchaserFornfield(
                                  controller: _model.emailController,
                                  hintText: 'Email',
                                  keyboardType: TextInputType.emailAddress,
                                  validator: _model.emailControllerValidator,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 24.0, 0.0, 24.0),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      logFirebaseEvent(
                                          'event_page_purchaser_details_done_btn_onTap');

                                      if (_model.formKey.currentState
                                              ?.validate() ==
                                          true) {
                                        logFirebaseEvent(
                                            'event_page_purchaser_details_form_valid');


                                        await _backendCall();
                                        context.safePop();
                                      } else {
                                        logFirebaseEvent(
                                            'event_page_purchaser_details_form_invalid');
                                        showSnackbar(
                                          context,
                                          'Please fill all fields correctly.',
                                        );
                                      }
                                    },
                                    text: 'Done',
                                    options: FFButtonOptions(
                                      height: 48.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 16.0, 0.0),
                                      iconPadding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 0.0),
                                      color: Color(0xFF0E0F11),
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily: 'Mona Sans',
                                            color: Colors.white,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                      elevation: 0.0,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Align(
              //   alignment: AlignmentDirectional(-0.8, -0.85),
              //   child: FlutterFlowIconButton(
              //     showLoadingIndicator: true,
              //     borderRadius: 50.0,
              //     buttonSize: 30.0,
              //     fillColor: Color(0x66FFFFFF),
              //     icon: Icon(
              //       FFIcons.kicArrowLeftRound,
              //       color: FlutterFlowTheme.of(context).secondary,
              //       size: 18.0,
              //     ),
              //     onPressed: () {
              //       context.safePop();
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _backendCall() async {
    logFirebaseEvent(
        'event_page_purchaser_details_api_call_start');
    try {
      await GetInScannerAPIsGroup
          .checkEventQuickPayCall(
        apiBaseURL: FlavorHelper
            .appFlavor.getInAppBaseUrl,
        scannerApiKey: FlavorHelper
            .appFlavor.scannerApiKey,
        eventId: widget.eventId.toString(),
        phone:
        _model.phoneNumber?.isNotEmpty ==
            true
            ? _model.dialCode! +
            _model.phoneNumber!
            : null,
        email: _model.emailController.text
            .isNotEmpty
            ? _model.emailController.text
            : null,
        hash: widget.hash,
      );
      // context.safePop();

      logFirebaseEvent(
          'event_page_purchaser_details_api_call_success');
    } catch (e) {
      // context.safePop();
    }
  }
}

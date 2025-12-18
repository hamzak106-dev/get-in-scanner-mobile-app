import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:g_e_t_i_n_scanner/components/readytousetaptopay/readytousetaptopay_widget.dart'
    show ReadytousetaptopayWidget;
import 'package:g_e_t_i_n_scanner/pages/home_screens/scanner_pos/feature_not_available.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import '../../backend/supabase/database/database.dart';
import '../../custom_code/actions/index.dart' as actions;
import 'card_scanning_model.dart';

export 'card_scanning_model.dart';

class CardScanningWidget extends StatefulWidget {
  final int eventId;

  const CardScanningWidget(
      {super.key, required this.eventId});

  @override
  State<CardScanningWidget> createState() => _CardScanningWidgetState();
}

class _CardScanningWidgetState extends State<CardScanningWidget> {
  late CardScanningModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CardScanningModel());
    // SchedulerBinding.instance.addPostFrameCallback((_) async {
    //   logFirebaseEvent('CARD_SCANNING_PAGE_card_scanning_ON_INIT_STATE');
    //   await DeviceTable().update(
    //     data: {'tap_to_pay_enabled': true},
    //     matchingRows: (rows) => rows.eqOrNull(
    //       'device_id',
    //       FFAppState().uuid,
    //     ).eqOrNull('user_id', FFAppState().user.userId),
    //   );
    // });
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.sizeOf(context).width * 1.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondary,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0.0),
            bottomRight: Radius.circular(0.0),
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20.0, 16.0, 20.0, 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  logFirebaseEvent('CARD_SCANNING_Container_dkew2k1y_ON_TAP');
                  context.safePop();
                },
                child: Container(
                  width: 50.0,
                  height: 5.0,
                  constraints: BoxConstraints(
                    maxWidth: 100.0,
                  ),
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).accent1,
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width * 1.0,
                decoration: BoxDecoration(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
                      child: Text(
                        'TAP TO PAY ON IPHONE NOW AVAILABLE.',
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Mona Sans',
                              color: FlutterFlowTheme.of(context).alternate,
                              fontSize: 16.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    Text(
                      'Accept contactless payments on your iPhone. ',
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Mona Sans',
                            color: FlutterFlowTheme.of(context).alternate,
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                          ),
                    ),
                    FFButtonWidget(
                      onPressed: () async {
                        try {
                          await actions.QuickPay().initTerminal(widget.eventId,
                              onError: (err) {
                            print('error: $err');
                            context.safePop();
                            context.pushNamed(FeatureDisabledPage.routeName,
                                pathParameters: {
                                  'message': '$err',
                                });
                          }, onInitialized: () {
                            context.safePop();
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return ReadytousetaptopayWidget();
                                });
                          });
                        } catch (e) {}
                        // context.pushNamed(ChekoutWidget.routeName);
                      },
                      text: 'ENABLE TAP TO PAY ON IPHONE',
                      options: FFButtonOptions(
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        height: 48.0,
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        textStyle:
                            FlutterFlowTheme.of(context).titleSmall.override(
                                  fontFamily: 'Mona Sans',
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                ),
                        elevation: 0.0,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.pushNamed(
                          TutorialsWidget.routeName,
                        );
                        // context.pushNamed(TapToPayDocumentWidget.routeName);
                      },
                      child: Container(
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 4.0),
                          child: Text(
                            'Learn More',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Mona Sans',
                                  color: FlutterFlowTheme.of(context).alternate,
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ].divide(SizedBox(height: 24.0)),
                ),
              ),
            ].divide(SizedBox(height: 20.0)),
          ),
        ),
      ),
    );
  }
}

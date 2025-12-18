import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:g_e_t_i_n_scanner/backend/supabase/database/database.dart';
import 'package:g_e_t_i_n_scanner/components/addon_redeamed/redeem_addon_widget.dart';
import 'package:g_e_t_i_n_scanner/components/redeem_addon/addon_redeamed_widget.dart'
    show AddonRedeamedWidget;
import 'package:g_e_t_i_n_scanner/flutter_flow/flutter_flow_theme.dart';
import 'package:g_e_t_i_n_scanner/flutter_flow/flutter_flow_util.dart';

import '../../../custom_code/actions/index.dart' as actions;
import 'add_on_details_screen_model.dart';

export 'add_on_details_screen_model.dart';

class AddOnDetailsScreenWidget extends StatefulWidget {
  final AddOnRow? addOnDetails;

  const AddOnDetailsScreenWidget({super.key, this.addOnDetails});

  static String routeName = 'AddOnDetailsScreen';
  static String routePath = '/addOnDetailsScreen';

  @override
  State<AddOnDetailsScreenWidget> createState() =>
      _AddOnDetailsScreenWidgetState();
}

class _AddOnDetailsScreenWidgetState extends State<AddOnDetailsScreenWidget> {
  late AddOnDetailsScreenModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'AddOnDetailsScreen'});
    _model = createModel(context, () => AddOnDetailsScreenModel());
    _model.addOnDetails = widget.addOnDetails;
    actions.watchAttendeeAddOn(
      int.parse(widget.addOnDetails?.attendeeAddOnId.toString() ?? '0'),
      (result) async {
        logFirebaseEvent('ADD_ON_DETAILS_SCREEN_watchAttendeeAddOn');
        _model.addOnDetails = result;
        setState(() {});
      },
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        automaticallyImplyLeading: false,
        leadingWidth: 50.0,
        elevation: 0.0,
        centerTitle: false,
        titleSpacing: 0.0,
        toolbarHeight: 60.0,
        leading: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            logFirebaseEvent('ADD_ON_DETAILS_SCREEN_Icon_7m2rpz6e_ON');
            if (context.canPop()) {
              context.pop(_model.addOnDetails);
            }
          },
          child: Icon(
            FFIcons.kicArrowBack,
            color: FlutterFlowTheme.of(context).secondaryText,
            size: 30.0,
          ),
        ),
        title: Text(
          'Add On',
          style: FlutterFlowTheme.of(context).titleMedium.override(
                fontFamily: 'MonaSans',
                letterSpacing: 0.0,
                useGoogleFonts: false,
              ),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (valueOrDefault(_model.addOnDetails?.imageUrl, '').isNotEmpty)
            Center(
              child: Container(
                width: 150.0,
                height: 150.0,
                margin: const EdgeInsets.only(top: 20.0),
                decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4.0,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        offset: const Offset(0.0, 2.0),
                      )
                    ],
                    image: DecorationImage(
                        image: NetworkImage(
                          _model.addOnDetails!.imageUrl!,
                        ),
                        fit: BoxFit.cover)),
              ),
            ),
          if (valueOrDefault(_model.addOnDetails?.name, '').isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                _model.addOnDetails!.name ?? 'No Name',
                style: FlutterFlowTheme.of(context).titleLarge.override(
                      fontFamily: 'MonaSans',
                      letterSpacing: 0.0,
                      useGoogleFonts: false,
                      fontSize: 22.0,
                    ),
              ),
            ),
          Expanded(
              child: Align(
            alignment: Alignment.topLeft,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  _model.addOnDetails?.description ?? '',
                  textAlign: TextAlign.start,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'MonaSans',
                        letterSpacing: 0.0,
                        useGoogleFonts: false,
                      ),
                ),
              ),
            ),
          )),
          Builder(
            builder: (context) {
              return InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  if (_model.addOnDetails!.status == 1) {
                    await showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                          return AddonRedeamedWidget(
                            title: _model.addOnDetails!.name,
                          );
                        });
                  } else {
                    logFirebaseEvent(
                        'ADD_ON_DETAILS_SCREEN_Container_1k2x4q5_ON');
                    await showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                          return RedeemAddonWidget(
                            onTap: () {
                              logFirebaseEvent(
                                  'ADD_ON_DETAILS_SCREEN_Container_1k2x4q5_ON');
                              actions.updateAddonStatus(
                                  int.parse(_model.addOnDetails!.attendeeAddOnId
                                          .toString() ??
                                      '0'), 1);
                            },
                            title: _model.addOnDetails!.name,
                          );
                        });
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: 60.0,
                  margin: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: _model.addOnDetails!.status == 0
                        ? FlutterFlowTheme.of(context).warning
                        : FlutterFlowTheme.of(context).success,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Builder(
                    builder: (context) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _model.addOnDetails!.status == 0?
                          SvgPicture.asset('assets/svg/info-circle.svg')
                           : Icon(
                            FFIcons.kicCheck,
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            size: 24.0,
                          ),
                          Text(
                            _model.addOnDetails!.status == 0
                                ? 'PENDING'
                                : 'REDEEMED',
                            style: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                    fontFamily: 'MonaSans',
                                    letterSpacing: 0.0,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    fontWeight: FontWeight.w900),
                          ),
                        ].divide(SizedBox(width: 10.0)),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

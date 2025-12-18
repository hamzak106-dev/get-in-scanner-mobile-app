import 'package:flutter/material.dart';
import 'package:g_e_t_i_n_scanner/backend/firebase_analytics/analytics.dart';
import 'package:g_e_t_i_n_scanner/backend/schema/enums/enums.dart';
import 'package:g_e_t_i_n_scanner/custom_code/actions/watch_add_ons_lists.dart';
import 'package:g_e_t_i_n_scanner/flutter_flow/custom_icons.dart';
import 'package:g_e_t_i_n_scanner/flutter_flow/flutter_flow_model.dart';
import 'package:g_e_t_i_n_scanner/flutter_flow/flutter_flow_theme.dart';
import 'package:g_e_t_i_n_scanner/flutter_flow/nav/nav.dart';
import 'package:g_e_t_i_n_scanner/pages/home_screens/add_on_details_screen/add_on_details_screen_widget.dart';

import 'add_ons_list_screen_model.dart';

export 'add_ons_list_screen_model.dart';

class AddOnsListScreenWidget extends StatefulWidget {
  final int attendeeUid;
  const AddOnsListScreenWidget({super.key, required this.attendeeUid});

  static String routeName = 'AddOnsListScreen';
  static String routePath = '/addOnsListScreen/:attendeeUid';

  @override
  State<AddOnsListScreenWidget> createState() => _AddOnsListScreenWidgetState();
}

class _AddOnsListScreenWidgetState extends State<AddOnsListScreenWidget> {
  late AddOnsListScreenModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _model = createModel(context, () => AddOnsListScreenModel());
    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'AddOnsListScreen'});
    watchAddOnsLists(
      widget.attendeeUid.toString(),
      (result) async {
        logFirebaseEvent('ADD_ON_LIST_SCREEN_watchAddOnsLists');
        _model.addOnsList = result ?? [];
        setState(() {});
      },
    );

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
            logFirebaseEvent('ADD_ON_LIST_SCREEN_Icon_7m2rpz6e_ON');
            context.safePop();
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
      body: ListView.builder(
          itemCount: _model.addOnsList.length,
          padding: EdgeInsets.all(16),
          itemBuilder: (context, index) {
            final addOn = _model.addOnsList[index];
            return ListTile(
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () async {
                logFirebaseEvent('ADD_ON_LIST_SCREEN_Tile_1g0q2k3x_ON');
                final data = await context.pushNamed(
                  AddOnDetailsScreenWidget.routeName,
                  queryParameters: {
                    'addOnDetails': serializeParam(
                      addOn,
                      ParamType.SupabaseRow,
                    ),
                  }.withoutNulls,
                );
                // if (data != null && data is AddOnModelStruct) {
                //   _model.addOnsList[index] = data;
                //   setState(() {});
                // }
              },
              title: Text(
                addOn.name ?? 'No Name',
                style: FlutterFlowTheme.of(context).labelMedium.override(
                    fontFamily: 'MonaSans',
                    letterSpacing: 0.0,
                    useGoogleFonts: false,
                    color: addOn.status == 0
                        ? FlutterFlowTheme.of(context).warning
                        : FlutterFlowTheme.of(context).success),
              ),
              trailing: Icon(
                FFIcons.kicArrowNext,
                color: addOn.status == 0
                    ? FlutterFlowTheme.of(context).warning
                    : FlutterFlowTheme.of(context).success,
                size: 24.0,
              ),
            );
          }),
    );
  }
}

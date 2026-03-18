import 'package:flutter/material.dart';
import 'package:g_e_t_i_n_scanner/backend/schema/enums/enums.dart';

import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/components/producer_selection_bottom_sheet/producer_selection_bottom_sheet_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '../config/flavor_helper.dart';

Future syncData(BuildContext context) async {
  ApiCallResponse? apiResponseSyncWithGetIn;

  try {
    if (FFAppState().user.profile == Profile.producer || FFAppState().user.profile == Profile.manager) {
      apiResponseSyncWithGetIn = await GetInScannerAPIsGroup.syncWithGetINCall.call(
        userId: FFAppState().user.userId,
        accessCode: '',
        refreshToken: FFAppState().user.auth.refresh,
        accessToken: FFAppState().user.auth.session,
        name: '${FFAppState().user.user.firstName} ${FFAppState().user.user.lastName}',
        email: FFAppState().user.user.email,
        phone: FFAppState().user.user.phone,
        phoneCountryCode: FFAppState().user.user.phoneCountryCode,
        profileImg: FFAppState().user.user.profileImg,
        apiBaseURL: FlavorHelper.appFlavor.apiBaseUrl,
        token: FlavorHelper.appFlavor.apiToken,
      );
      debugPrint("SyncData Try ${apiResponseSyncWithGetIn.bodyText}");
    }
  } catch (e) {
    debugPrint("SyncData Catch ${e.toString()}");
  } finally {
    print("Sync time start ${DateTime.now()}");
    await actions.syncWithPowersync();
    print("Sync time end ${DateTime.now()}");
  }
}

Future producerSelectionBlock(BuildContext context) async {
  CreatorsRow? producer;

  await showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
    enableDrag: true,
    useSafeArea: true,
    context: context,
    builder: (context) {
      return Padding(
        padding: MediaQuery.viewInsetsOf(context),
        child: ProducerSelectionBottomSheetWidget(),
      );
    },
  ).then((value) {
    if (value != null) producer = value;
  });

  if (producer != null) {
    FFAppState().selectedProducer = functions.convertCreatorToUserModel(producer!);
    FFAppState().update(() {});
  }

  // await actions.watchEventsForManager(
  //   FFAppState().selectedProducer.userId,
  //   (result) async {
  //     FFAppState().selectedEvent = functions
  //         .parseRowToJson(result?.toList(), null)
  //         .toList()
  //         .cast<dynamic>();
  //     FFAppState().update(() {});
  //   },
  // );
}

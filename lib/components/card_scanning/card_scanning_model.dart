import 'package:g_e_t_i_n_scanner/backend/schema/structs/terminal_onboarding_link_struct.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'card_scanning_widget.dart' show CardScanningWidget;
import 'package:flutter/material.dart';

class CardScanningModel extends FlutterFlowModel<CardScanningWidget> {
  String? errorMessage;
  bool termsLoading = true;
  bool isChecked = false;
  TerminalOnboardingLinkStruct? terminalOnboardingLink;



  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}

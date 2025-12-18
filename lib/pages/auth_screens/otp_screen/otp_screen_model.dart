import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/components/custom_button/custom_button_widget.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'otp_screen_widget.dart' show OtpScreenWidget;
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter/material.dart';

class OtpScreenModel extends FlutterFlowModel<OtpScreenWidget> {
  ///  Local state fields for this page.

  bool showResent = false;

  String? errorText;

  int? deviceId;

  ///  State fields for stateful widgets in this page.

  // State field(s) for PinCode widget.
  TextEditingController? pinCodeController;
  FocusNode? pinCodeFocusNode;
  String? Function(BuildContext, String?)? pinCodeControllerValidator;
  // Stores action output result for [Backend Call - API (CheckVFive)] action in Text widget.
  ApiCallResponse? checkResponse;
  // State field(s) for Timer widget.
  final timerInitialTimeMs = 60000;
  int timerMilliseconds = 60000;
  String timerValue = StopWatchTimer.getDisplayTime(
    60000,
    hours: false,
    milliSecond: false,
  );
  FlutterFlowTimerController timerController =
      FlutterFlowTimerController(StopWatchTimer(mode: StopWatchMode.countDown));

  // Model for CustomButton component.
  late CustomButtonModel customButtonModel;
  // Stores action output result for [Backend Call - API (LoginVFive)] action in CustomButton widget.
  ApiCallResponse? loginResponse;
  // Stores action output result for [Backend Call - Query Rows] action in CustomButton widget.
  List<PinRow>? pinResponse;
  // Stores action output result for [Custom Action - getAppVersionName] action in CustomButton widget.
  String? version;
  // Stores action output result for [Backend Call - Query Rows] action in CustomButton widget.
  List<DeviceRow>? checkDeviceResponse;
  // Stores action output result for [Backend Call - Update Row(s)] action in CustomButton widget.
  List<DeviceRow>? updatedData;
  // Stores action output result for [Backend Call - Insert Row] action in CustomButton widget.
  DeviceRow? newDeviceData;

  @override
  void initState(BuildContext context) {
    pinCodeController = TextEditingController();
    customButtonModel = createModel(context, () => CustomButtonModel());
  }

  @override
  void dispose() {
    pinCodeFocusNode?.dispose();
    pinCodeController?.dispose();

    timerController.dispose();
    customButtonModel.dispose();
  }
}

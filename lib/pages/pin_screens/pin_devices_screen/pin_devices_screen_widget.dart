import '../../../custom_code/actions/init_power_sync.dart';
import '/backend/supabase/supabase.dart';
import '/components/device_tile/device_tile_widget.dart';
import '/components/dialogs/delete_scanner_dialog/delete_scanner_dialog_widget.dart';
import '/components/dialogs/success_dialog/success_dialog_widget.dart';
import '/components/no_data_found/no_data_found_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:share_plus/share_plus.dart';
import 'pin_devices_screen_model.dart';
export 'pin_devices_screen_model.dart';

class PinDevicesScreenWidget extends StatefulWidget {
  const PinDevicesScreenWidget({
    super.key,
    this.pin,
  });

  final PinRow? pin;

  static String routeName = 'PinDevicesScreen';
  static String routePath = '/pinDevicesScreen';

  @override
  State<PinDevicesScreenWidget> createState() => _PinDevicesScreenWidgetState();
}

class _PinDevicesScreenWidgetState extends State<PinDevicesScreenWidget> {
  late PinDevicesScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PinDevicesScreenModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'PinDevicesScreen'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('PIN_DEVICES_SCREEN_PinDevicesScreen_ON_I');
      await actions.watchDeviceLists(
        (result) async {
          _model.deviceResponse = await actions.getDeviceList(
            result?.toList(),
          );
          _model.devices = result!.toList().cast<DeviceRow>();
          safeSetState(() {});
        },
        ((int pinID) {
          return [pinID];
        }(widget.pin!.uid))
            .toList(),
      );
    });
  }

  @override
  void dispose() {
    _model.dispose();
    actions.cancelSubscription(deviceSubscription);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    FlutterFlowIconButton(
                      borderColor: Colors.transparent,
                      borderRadius: 30.0,
                      buttonSize: 40.0,
                      icon: Icon(
                        FFIcons.kicArrowBack,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 24.0,
                      ),
                      onPressed: () async {
                        logFirebaseEvent(
                            'PIN_DEVICES_SCREEN_icArrowBack_ICN_ON_TA');
                        context.safePop();
                      },
                    ),
                    Expanded(
                      child: Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Text(
                          'Manage Devices',
                          style:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'MonaSans',
                                    letterSpacing: 0.0,
                                  ),
                        ),
                      ),
                    ),
                  ].addToEnd(SizedBox(width: 40.0)),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                  child: Builder(
                    builder: (context) {
                      final device = _model.devices.toList();
                      if (device.isEmpty) {
                        return Center(
                          child: NoDataFoundWidget(),
                        );
                      }

                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: device.length,
                        itemBuilder: (context, deviceIndex) {
                          final deviceItem = device[deviceIndex];
                          return Builder(
                            builder: (context) => wrapWithModel(
                              model: _model.deviceTileModels.getModel(
                                deviceIndex.toString(),
                                deviceIndex,
                              ),
                              updateCallback: () => safeSetState(() {}),
                              child: DeviceTileWidget(
                                key: Key(
                                  'Key1n3_${deviceIndex.toString()}',
                                ),
                                device: deviceItem,
                                onDeleteDevice: () async {
                                  logFirebaseEvent(
                                      'PIN_DEVICES_SCREEN_Container_1n3ve02d_CA');
                                  await showDialog(
                                    context: context,
                                    builder: (dialogContext) {
                                      return Dialog(
                                        elevation: 0,
                                        insetPadding: EdgeInsets.zero,
                                        backgroundColor: Colors.transparent,
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0)
                                                .resolve(
                                                    Directionality.of(context)),
                                        child: GestureDetector(
                                          onTap: () {
                                            FocusScope.of(dialogContext)
                                                .unfocus();
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                          },
                                          child: DeleteScannerDialogWidget(
                                            title: 'Delete ${deviceItem.name}',
                                            subTitle:
                                                'This action cannot be undone. All associated data will be lost.',
                                            firstBtnText: 'Delete',
                                            secondBtnText: 'Cancel',
                                            firstBtnColor:
                                                FlutterFlowTheme.of(context)
                                                    .error,
                                            secondBtnColor: Color(0x99FFFFFF),
                                          ),
                                        ),
                                      );
                                    },
                                  ).then((value) => safeSetState(
                                      () => _model.isDeleteDevice = value));

                                  if (_model.isDeleteDevice!) {
                                    _model.deletedLogs =
                                        await CheckInLogsTable().delete(
                                      matchingRows: (rows) => rows.eqOrNull(
                                        'device_id',
                                        deviceItem.uid,
                                      ),
                                      returnRows: true,
                                    );
                                    _model.deletedDevices =
                                        await DeviceTable().delete(
                                      matchingRows: (rows) => rows.eqOrNull(
                                        'uid',
                                        deviceItem.uid,
                                      ),
                                      returnRows: true,
                                    );
                                    await showDialog(
                                      context: context,
                                      builder: (dialogContext) {
                                        return Dialog(
                                          elevation: 0,
                                          insetPadding: EdgeInsets.zero,
                                          backgroundColor: Colors.transparent,
                                          alignment: AlignmentDirectional(
                                                  0.0, 0.0)
                                              .resolve(
                                                  Directionality.of(context)),
                                          child: GestureDetector(
                                            onTap: () {
                                              FocusScope.of(dialogContext)
                                                  .unfocus();
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                            },
                                            child: SuccessDialogWidget(),
                                          ),
                                        );
                                      },
                                    );
                                  }

                                  safeSetState(() {});
                                },
                                onTapDevice: () async {
                                  logFirebaseEvent(
                                      'PIN_DEVICES_SCREEN_Container_1n3ve02d_CA');

                                  context.pushNamed(
                                    AddScannersScreenWidget.routeName,
                                    queryParameters: {
                                      'scanner': serializeParam(
                                        widget.pin,
                                        ParamType.SupabaseRow,
                                      ),
                                      'device': serializeParam(
                                        deviceItem,
                                        ParamType.SupabaseRow,
                                      ),
                                    }.withoutNulls,
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              Builder(
                builder: (context) => Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 20.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      logFirebaseEvent(
                          'PIN_DEVICES_SCREEN_SHARE_THE_ACCESS_CODE');
                      await Share.share(
                        'Access Code : ${widget.pin?.accessCode} & Pin : ${widget.pin?.pin.toString()}',
                        sharePositionOrigin: getWidgetBoundingBox(context),
                      );
                    },
                    text: 'Share the Access Code',
                    icon: Icon(
                      FFIcons.kicAddFillCircle,
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      size: 16.0,
                    ),
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 52.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).secondary,
                      textStyle: FlutterFlowTheme.of(context)
                          .labelLarge
                          .override(
                            fontFamily: 'MonaSans',
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            letterSpacing: 0.0,
                          ),
                      elevation: 0.0,
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                ),
              ),
            ].divide(SizedBox(height: 12.0)),
          ),
        ),
      ),
    );
  }
}

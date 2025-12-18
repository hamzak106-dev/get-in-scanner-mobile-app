import '../../../custom_code/actions/init_power_sync.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'device_component_model.dart';
export 'device_component_model.dart';

class DeviceComponentWidget extends StatefulWidget {
  const DeviceComponentWidget({super.key});

  @override
  State<DeviceComponentWidget> createState() => _DeviceComponentWidgetState();
}

class _DeviceComponentWidgetState extends State<DeviceComponentWidget> {
  late DeviceComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DeviceComponentModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('DEVICE_COMPONENT_DeviceComponent_ON_INIT');
      await actions.watchAuthorisedPins(
        (result) async {
          _model.pinResponse = await actions.getPinList(
            result?.toList(),
          );
          _model.pins = _model.pinResponse!.toList().cast<PinRow>();
          safeSetState(() {});
          await actions.watchDeviceLists(
            (result) async {
              _model.deviceResponse = await actions.getDeviceList(
                result?.toList(),
              );
              _model.devices =
                  _model.deviceResponse!.toList().cast<DeviceRow>();
              safeSetState(() {});
            },
            _model.pins.map((e) => e.uid).toList().toList(),
          );
        },
      );
    });
  }

  @override
  void dispose() {
    _model.maybeDispose();
    actions.cancelSubscription(listsSubscription);
    actions.cancelSubscription(deviceSubscription);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Access Code',
                  style: FlutterFlowTheme.of(context).titleLarge.override(
                        fontFamily: 'MonaSans',
                        fontSize: 22.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Icon(
                  FFIcons.kicAdd,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 24.0,
                ),
              ].divide(SizedBox(width: 10.0)),
            ),
            Flexible(
              child: Builder(
                builder: (context) {
                  final pin = _model.pins.toList();

                  return ListView.separated(
                    padding: EdgeInsets.zero,
                    primary: false,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: pin.length,
                    separatorBuilder: (_, __) => SizedBox(height: 20.0),
                    itemBuilder: (context, pinIndex) {
                      final pinItem = pin[pinIndex];
                      return Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: FlutterFlowTheme.of(context).tertiary,
                            width: 1.0,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Access Code\t',
                                    style: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'MonaSans',
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                  Text(
                                    pinItem.accessCode,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'MonaSans',
                                          color: Color(0xFF339D4D),
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ].divide(SizedBox(width: 8.0)),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'PIN #\t',
                                    style: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'MonaSans',
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                  Text(
                                    pinItem.pin.toString(),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'MonaSans',
                                          color: Color(0xFF339D4D),
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ].divide(SizedBox(width: 8.0)),
                              ),
                            ].divide(SizedBox(height: 8.0)),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            if (_model.devices.isNotEmpty)
              Align(
                alignment: AlignmentDirectional(-1.0, 0.0),
                child: Text(
                  'Devices',
                  style: FlutterFlowTheme.of(context).titleLarge.override(
                        fontFamily: 'MonaSans',
                        fontSize: 22.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            if (_model.devices.isNotEmpty)
              Flexible(
                child: Builder(
                  builder: (context) {
                    final device = _model.devices.toList();

                    return ListView.separated(
                      padding: EdgeInsets.zero,
                      primary: false,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: device.length,
                      separatorBuilder: (_, __) => SizedBox(height: 20.0),
                      itemBuilder: (context, deviceIndex) {
                        final deviceItem = device[deviceIndex];
                        return Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).tertiary,
                              width: 1.0,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              deviceItem.name,
                              style: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'MonaSans',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
          ].divide(SizedBox(height: 20.0)),
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gradient_progress_bar/gradient_progress_bar.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'chekout_model.dart';

export 'chekout_model.dart';

class ChekoutWidget extends StatefulWidget {
  const ChekoutWidget({
    super.key,
    // this.pinData,
    // bool? isNew,
  });

  // : this.isNew = isNew ?? true;
  //
  // final PinRow? pinData;
  // final bool isNew;

  static String routeName = 'chekout';
  static String routePath = '/chekout';

  @override
  State<ChekoutWidget> createState() => _ChekoutWidgetState();
}

class _ChekoutWidgetState extends State<ChekoutWidget>
    with SingleTickerProviderStateMixin {
  late ChekoutModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChekoutModel());
    logFirebaseEvent('screen_view', parameters: {'screen_name': 'chekout'});
    // On page load action.
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // total time for the bar to fill
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    )..addListener(() {
        setState(() {}); // rebuild on every tick
      });

    // start the animation
    _controller.repeat();

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('CHEKOUT_PAGE_chekout_ON_INIT_STATE');
      try {
        // await actions.QuickPay().initTerminal(11677);
        // optionally, when initialization completes, set progress full
        _controller.animateTo(1.0, duration: const Duration(milliseconds: 400));
      } catch (e) {
        debugPrint('Error initializing terminal: $e');
        // Optionally stop the progress or show error UI
      }
      // await actions.QuickPay().initTerminal(11677);
      //   _model.permissionsValue =
      //       !widget.isNew ? widget.pinData!.permissions : 0;
      //   _model.pLookUp = await actions.isPermissionSelected(
      //     _model.permissionsValue,
      //     AccessPermission.lookup,
      //   );
      //   _model.pCanView = await actions.isPermissionSelected(
      //     _model.permissionsValue,
      //     AccessPermission.canViewList,
      //   );
      //   _model.pRequireEvent = await actions.isPermissionSelected(
      //     _model.permissionsValue,
      //     AccessPermission.allEvents,
      //   );
      //   _model.pManualEntry = await actions.isPermissionSelected(
      //     _model.permissionsValue,
      //     AccessPermission.manualEntry,
      //   );
      //   _model.pSearch = await actions.isPermissionSelected(
      //     _model.permissionsValue,
      //     AccessPermission.searchAttendee,
      //   );
      //   _model.pScan = await actions.isPermissionSelected(
      //     _model.permissionsValue,
      //     AccessPermission.scan,
      //   );
      //   _model.pStats = await actions.isPermissionSelected(
      //     _model.permissionsValue,
      //     AccessPermission.stats,
      //   );
      //   _model.pSettings = await actions.isPermissionSelected(
      //     _model.permissionsValue,
      //     AccessPermission.settings,
      //   );
      //   _model.generatedPin =
      //       !widget.isNew ? widget.pinData?.pin.toString() : null;
      //   _model.isLookUp = _model.pLookUp!;
      //   _model.canViewLookUp = _model.pCanView!;
      //   _model.requireEventLookUp = _model.pRequireEvent!;
      //   _model.manualEntry = _model.pManualEntry!;
      //   _model.scanSelected = _model.pScan!;
      //   _model.statSelected = _model.pStats!;
      //   _model.searchSelected = _model.pSearch!;
      //   _model.settingSelected = _model.pSettings!;
      //   safeSetState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: GestureDetector(
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
                      // FlutterFlowIconButton(
                      //   borderColor: Colors.transparent,
                      //   borderRadius: 30.0,
                      //   buttonSize: 40.0,
                      //   icon: Icon(
                      //     FFIcons.kicArrowBack,
                      //     color: FlutterFlowTheme.of(context).primaryText,
                      //     size: 24.0,
                      //   ),
                      //   onPressed: () async {
                      //     logFirebaseEvent(
                      //         'CHEKOUT_PAGE_icArrowBack_ICN_ON_TAP');
                      //     context.safePop();
                      //   },
                      // ),
                      Expanded(
                        child: Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Text(
                            'CHECKOUT',
                            style: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: 'Mona Sans',
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                      ),
                    ].addToEnd(SizedBox(width: 40.0)),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GradientProgressIndicator(
                        [
                          Color(0xff8A38F5),
                          Color(0xff9636dd),
                          // Color(0xffA534c1),
                          // Color(0xffcb2e79),
                          // Color(0xffea2b41),
                          Color(0xfff92925),
                          Color(0xffFF281B),
                        ],
                        _animation.value,
                      )
                      // LinearPercentIndicator(
                      //   percent: 0.5,
                      //   width: MediaQuery.sizeOf(context).width * 1.0,
                      //   lineHeight: 2.0,
                      //   animation: true,
                      //   animateFromLastPercent: true,
                      //   progressColor: FlutterFlowTheme.of(context).primary,
                      //   backgroundColor:
                      //       FlutterFlowTheme.of(context).primaryBackground,
                      //   center: Text(
                      //     '50%',
                      //     style:
                      //         FlutterFlowTheme.of(context).headlineSmall.override(
                      //               fontFamily: 'Mona Sans',
                      //               letterSpacing: 0.0,
                      //             ),
                      //   ),
                      //   padding: EdgeInsets.zero,
                      // ),
                    ].divide(SizedBox(height: 4.0)),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Preparing Tap to Pay${isiOS ? ' on iPhone' : ''}',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Mona Sans',
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ].divide(SizedBox(height: 4.0)),
                      ),
                    ),
                  ),
                ),
              ].divide(SizedBox(height: 0.0)),
            ),
          ),
        ),
      ),
    );
  }
}

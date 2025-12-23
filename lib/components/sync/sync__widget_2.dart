import 'package:flutter_svg/svg.dart';

import '/components/dialogs/info_dialog/info_dialog_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import 'package:rive/rive.dart' hide LinearGradient;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'sync_model.dart';
export 'sync_model.dart';

class SyncWidget2 extends StatefulWidget {
  const SyncWidget2({super.key});

  @override
  State<SyncWidget2> createState() => _SyncWidgetState();
}

class _SyncWidgetState extends State<SyncWidget2> {
  late SyncModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SyncModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      width: 40.0,
      height: 40.0,
      decoration: BoxDecoration(),
      child: Builder(
        builder: (context) {
          if (_model.isLoading) {
            return Builder(
              builder: (context) => InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  logFirebaseEvent('SYNC_COMP_RiveAnimation_1pzpdk0q_ON_TAP');
                  await showDialog(
                    context: context,
                    builder: (dialogContext) {
                      return Dialog(
                        elevation: 0,
                        insetPadding: EdgeInsets.zero,
                        backgroundColor: Colors.transparent,
                        alignment: AlignmentDirectional(0.0, 0.0)
                            .resolve(Directionality.of(context)),
                        child: InfoDialogWidget(
                          title: 'Checking Updates.....',
                          isLight: true,
                          firstTap: () async {
                            Navigator.pop(context);
                          },
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  width: 150.0,
                  height: 130.0,
                  child: RiveAnimation.asset(
                    'assets/rive_animations/syncing.riv',
                    artboard: 'Inprogress',
                    fit: BoxFit.contain,
                    controllers: _model.riveAnimationControllers,
                  ),
                ),
              ),
            );
          } else {
            return Builder(
              builder: (context) => InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () async {
                  logFirebaseEvent('SYNC_COMP_icRefresh_ICN_ON_TAP');

                  if (FFAppState().syncStatus.downloading) {
                    await showDialog(
                      context: context,
                      builder: (dialogContext) {
                        return Dialog(
                          elevation: 0,
                          insetPadding: EdgeInsets.zero,
                          backgroundColor: Colors.transparent,
                          alignment: AlignmentDirectional(0.0, 0.0)
                              .resolve(Directionality.of(context)),
                          child: InfoDialogWidget(
                            title: 'Checking Updates.....',
                            isLight: true,
                            firstTap: () async {
                              Navigator.pop(context);
                            },
                          ),
                        );
                      },
                    );
                  } else {
                    _model.lastSyncAt = await actions.powersyncLastSyncAt();
                    if ((_model.lastSyncAt != null) &&
                        (_model.lastSyncAt!.secondsSinceEpoch <
                            (getCurrentTimestamp.secondsSinceEpoch - 30))) {
                      _model.isLoading = !_model.isLoading;
                      safeSetState(() {});
                      await action_blocks.syncData(context);
                      _model.isLoading = !_model.isLoading;
                      safeSetState(() {});
                    } else {
                      await showDialog(
                        context: context,
                        builder: (dialogContext) {
                          return Dialog(
                            elevation: 0,
                            insetPadding: EdgeInsets.zero,
                            backgroundColor: Colors.transparent,
                            alignment: AlignmentDirectional(0.0, 0.0)
                                .resolve(Directionality.of(context)),
                            child: InfoDialogWidget(
                              title: 'No sync necessary',
                              isLight: true,
                              subTitle: 'The device is up to date.',
                              firstBtnText: 'OK',
                              firstBtnColor: FlutterFlowTheme.of(context).accent3,
                              firstTap: () async {
                                Navigator.pop(context);
                              },
                            ),
                          );
                        },
                      );
                    }
                  }

                  safeSetState(() {});
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: FlutterFlowTheme.of(context).secondary600,

                  ),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SvgPicture.asset(
                      height: 20,
                      width: 20,
                      'assets/svg/download_icon.svg',
                      colorFilter: ColorFilter.mode(
                        FlutterFlowTheme.of(context).secondary,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),

            );
          }
        },
      ),
    );
  }
}

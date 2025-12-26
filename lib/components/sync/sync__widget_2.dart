import 'package:flutter_svg/svg.dart';
import 'package:g_e_t_i_n_scanner/components/screen_component/scanner_summary/scanner_summary_model.dart';
import 'package:g_e_t_i_n_scanner/pages/home_screens/summary_screen/summary_screen_model.dart';

import '../../backend/supabase/database/tables/attendee.dart';
import '../export_csv/import_sheet_card.dart';
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
  final ScannerSummaryModel summaryScreenModel;

  const SyncWidget2({super.key, required this.summaryScreenModel});

  @override
  State<SyncWidget2> createState() => _SyncWidgetState();
}

class _SyncWidgetState extends State<SyncWidget2> with TickerProviderStateMixin{
  late SyncModel _model;
  late final AnimationController _exportSheetController;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SyncModel());
    _exportSheetController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 300),
    );
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
                  await showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    barrierColor: Colors.black.withOpacity(0.4),
                    transitionAnimationController: _exportSheetController,
                    builder: (_) {
                      return  NewImportCard( scannerSummaryModel: widget.summaryScreenModel,);
                    },
                  );

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

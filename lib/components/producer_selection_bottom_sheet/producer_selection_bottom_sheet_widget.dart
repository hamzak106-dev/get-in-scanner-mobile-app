import '/backend/supabase/supabase.dart';
import '/components/producer_list_component/producer_list_component_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'producer_selection_bottom_sheet_model.dart';
export 'producer_selection_bottom_sheet_model.dart';

class ProducerSelectionBottomSheetWidget extends StatefulWidget {
  const ProducerSelectionBottomSheetWidget({super.key});

  @override
  State<ProducerSelectionBottomSheetWidget> createState() =>
      _ProducerSelectionBottomSheetWidgetState();
}

class _ProducerSelectionBottomSheetWidgetState
    extends State<ProducerSelectionBottomSheetWidget> {
  late ProducerSelectionBottomSheetModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProducerSelectionBottomSheetModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('PRODUCER_SELECTION_BOTTOM_SHEET_Producer');
      _model.allProducers = await actions.getProducerOfManageEvent();
      _model.producers = _model.allProducers!.toList().cast<CreatorsRow>();
      safeSetState(() {});
    });
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 50.0,
          sigmaY: 50.0,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xE50E0F11),
            boxShadow: [
              BoxShadow(
                blurRadius: 50.0,
                color: Color(0x33000000),
              )
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                logFirebaseEvent('PRODUCER_SELECTION_BOTTOM_SHEET_Column_r');
                await actions.unfocusFields(
                  context,
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Container(
                      width: 110.0,
                      height: 6.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).tertiary,
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                    ),
                  ),
                  Expanded(
                    child: wrapWithModel(
                      model: _model.producerListComponentModel,
                      updateCallback: () => safeSetState(() {}),
                      child: ProducerListComponentWidget(
                        onSelectProducer: (producer) async {
                          logFirebaseEvent(
                              'PRODUCER_SELECTION_BOTTOM_SHEET_Containe');
                          Navigator.pop(context, producer);
                        },
                      ),
                    ),
                  ),
                ].divide(SizedBox(height: 16.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

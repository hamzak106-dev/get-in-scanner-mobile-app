import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/components/no_attendees_view/no_attendees_view_widget.dart';
import '/components/producer_card/producer_card_widget.dart';
import '/components/rive_animation_view/rive_animation_view_widget.dart';
import '/components/search_text_field/search_text_field_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'producer_list_component_model.dart';
export 'producer_list_component_model.dart';

class ProducerListComponentWidget extends StatefulWidget {
  const ProducerListComponentWidget({
    super.key,
    this.onSelectProducer,
  });

  final Future Function(CreatorsRow? producer)? onSelectProducer;

  @override
  State<ProducerListComponentWidget> createState() => _ProducerListComponentWidgetState();
}

class _ProducerListComponentWidgetState extends State<ProducerListComponentWidget> {
  late ProducerListComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProducerListComponentModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('PRODUCER_LIST_COMPONENT_ProducerListComp');
      _model.myProducers = await actions.getProducerOfManageEvent();
      _model.producers = _model.myProducers!.toList().cast<CreatorsRow>();
      _model.isLoading = false;
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
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Text(
                'Select Producer Account',
                style: FlutterFlowTheme.of(context).titleLarge.override(
                      fontFamily: 'MonaSans',
                      fontSize: 16.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ].divide(SizedBox(width: 12.0)),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: wrapWithModel(
                model: _model.searchTextFieldModel,
                updateCallback: () => safeSetState(() {}),
                child: SearchTextFieldWidget(
                  onChange: () async {
                    logFirebaseEvent('PRODUCER_LIST_COMPONENT_Container_0icr73');

                    safeSetState(() {});
                  },
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(1.0, 0.0),
              child: custom_widgets.FilterPopUp(
                width: 40.0,
                height: 40.0,
                onChange: (value) async {
                  logFirebaseEvent('PRODUCER_LIST_COMPONENT_Container_y78a4k');
                  _model.ascending = value == 0;
                  safeSetState(() {});
                },
              ),
            ),
          ].divide(SizedBox(width: 16.0)),
        ),
        Expanded(
          child: Builder(
            builder: (context) {
              if (_model.isLoading) {
                return wrapWithModel(
                  model: _model.riveAnimationViewModel,
                  updateCallback: () => safeSetState(() {}),
                  child: RiveAnimationViewWidget(
                    type: RiveAnimType.AvatarSyncing,
                    fillColor: Colors.transparent,
                  ),
                );
              } else {
                return Builder(
                  builder: (context) {
                    final producer = (_model.ascending != null
                            ? (_model.ascending!
                                ? functions
                                    .filterUserList(
                                        _model.producers.toList(), _model.searchTextFieldModel.textController.text)
                                    .sortedList(keyOf: (e) => e.name!, desc: false)
                                : functions
                                    .filterUserList(
                                        _model.producers.toList(), _model.searchTextFieldModel.textController.text)
                                    .sortedList(keyOf: (e) => e.name!, desc: true))
                            : functions.filterUserList(
                                _model.producers.toList(), _model.searchTextFieldModel.textController.text))
                        .toList();
                    if (producer.isEmpty) {
                      return Center(
                        child: NoAttendeesViewWidget(),
                      );
                    }

                    return ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: producer.length,
                      separatorBuilder: (_, __) => SizedBox(height: 16.0),
                      itemBuilder: (context, producerIndex) {
                        final producerItem = producer[producerIndex];
                        return InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            logFirebaseEvent('PRODUCER_LIST_COMPONENT_Container_dl764v');
                            await widget.onSelectProducer?.call(producerItem);
                          },
                          child: custom_widgets.CardGradientWidget(
                            width: double.infinity,
                            height: 92.0,
                            isSelected: false,
                            child: () => ProducerCardWidget(
                              producer: producerItem,
                              onChange: () async {
                                logFirebaseEvent('PRODUCER_LIST_COMPONENT_Container_dl764v');
                                await widget.onSelectProducer?.call(producerItem);
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              }
            },
          ),
        ),
      ].divide(SizedBox(height: 16.0)),
    );
  }
}

import '/backend/supabase/supabase.dart';
import '/components/rive_animation_view/rive_animation_view_widget.dart';
import '/components/search_text_field/search_text_field_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'producer_list_component_widget.dart' show ProducerListComponentWidget;
import 'package:flutter/material.dart';

class ProducerListComponentModel
    extends FlutterFlowModel<ProducerListComponentWidget> {
  ///  Local state fields for this component.

  List<CreatorsRow> producers = [];
  void addToProducers(CreatorsRow item) => producers.add(item);
  void removeFromProducers(CreatorsRow item) => producers.remove(item);
  void removeAtIndexFromProducers(int index) => producers.removeAt(index);
  void insertAtIndexInProducers(int index, CreatorsRow item) =>
      producers.insert(index, item);
  void updateProducersAtIndex(int index, Function(CreatorsRow) updateFn) =>
      producers[index] = updateFn(producers[index]);

  bool isLoading = true;

  bool? ascending;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Custom Action - getProducerOfManageEvent] action in ProducerListComponent widget.
  List<CreatorsRow>? myProducers;
  // Model for SearchTextField component.
  late SearchTextFieldModel searchTextFieldModel;
  // Model for RiveAnimationView component.
  late RiveAnimationViewModel riveAnimationViewModel;

  @override
  void initState(BuildContext context) {
    searchTextFieldModel = createModel(context, () => SearchTextFieldModel());
    riveAnimationViewModel =
        createModel(context, () => RiveAnimationViewModel());
  }

  @override
  void dispose() {
    searchTextFieldModel.dispose();
    riveAnimationViewModel.dispose();
  }
}

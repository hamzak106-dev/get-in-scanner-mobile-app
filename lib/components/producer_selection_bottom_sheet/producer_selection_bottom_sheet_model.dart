import '/backend/supabase/supabase.dart';
import '/components/producer_list_component/producer_list_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'producer_selection_bottom_sheet_widget.dart'
    show ProducerSelectionBottomSheetWidget;
import 'package:flutter/material.dart';

class ProducerSelectionBottomSheetModel
    extends FlutterFlowModel<ProducerSelectionBottomSheetWidget> {
  ///  Local state fields for this component.

  List<CreatorsRow> producers = [];
  void addToProducers(CreatorsRow item) => producers.add(item);
  void removeFromProducers(CreatorsRow item) => producers.remove(item);
  void removeAtIndexFromProducers(int index) => producers.removeAt(index);
  void insertAtIndexInProducers(int index, CreatorsRow item) =>
      producers.insert(index, item);
  void updateProducersAtIndex(int index, Function(CreatorsRow) updateFn) =>
      producers[index] = updateFn(producers[index]);

  List<CreatorsRow> emptyList = [];
  void addToEmptyList(CreatorsRow item) => emptyList.add(item);
  void removeFromEmptyList(CreatorsRow item) => emptyList.remove(item);
  void removeAtIndexFromEmptyList(int index) => emptyList.removeAt(index);
  void insertAtIndexInEmptyList(int index, CreatorsRow item) =>
      emptyList.insert(index, item);
  void updateEmptyListAtIndex(int index, Function(CreatorsRow) updateFn) =>
      emptyList[index] = updateFn(emptyList[index]);

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Custom Action - getProducerOfManageEvent] action in ProducerSelectionBottomSheet widget.
  List<CreatorsRow>? allProducers;
  // Model for ProducerListComponent component.
  late ProducerListComponentModel producerListComponentModel;

  @override
  void initState(BuildContext context) {
    producerListComponentModel =
        createModel(context, () => ProducerListComponentModel());
  }

  @override
  void dispose() {
    producerListComponentModel.dispose();
  }
}

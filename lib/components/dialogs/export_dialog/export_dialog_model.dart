import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'export_dialog_widget.dart' show ExportDialogWidget;
import 'package:flutter/material.dart';

class ExportDialogModel extends FlutterFlowModel<ExportDialogWidget> {
  ///  Local state fields for this component.

  ExportFileStruct? exportData;
  void updateExportDataStruct(Function(ExportFileStruct) updateFn) {
    updateFn(exportData ??= ExportFileStruct());
  }

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Custom Action - exportCsvFile] action in ExportDialog widget.
  ExportFileStruct? exportedFile;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}

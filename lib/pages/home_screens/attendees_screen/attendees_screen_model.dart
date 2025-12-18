import '/backend/api_requests/api_calls.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/components/rive_animation_view/rive_animation_view_widget.dart';
import '/components/search_text_field/search_text_field_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'attendees_screen_widget.dart' show AttendeesScreenWidget;
import 'package:flutter/material.dart';

class AttendeesScreenModel extends FlutterFlowModel<AttendeesScreenWidget> {
  ///  Local state fields for this page.

  List<AttendeeRow> attendees = [];
  void addToAttendees(AttendeeRow item) => attendees.add(item);
  void removeFromAttendees(AttendeeRow item) => attendees.remove(item);
  void removeAtIndexFromAttendees(int index) => attendees.removeAt(index);
  void insertAtIndexInAttendees(int index, AttendeeRow item) =>
      attendees.insert(index, item);
  void updateAttendeesAtIndex(int index, Function(AttendeeRow) updateFn) =>
      attendees[index] = updateFn(attendees[index]);

  String? searchText;

  bool ascending = true;

  CsvUploadResponseStruct? uploadResponse;
  void updateUploadResponseStruct(Function(CsvUploadResponseStruct) updateFn) {
    updateFn(uploadResponse ??= CsvUploadResponseStruct());
  }

  bool? whichOption;

  int? selectedEventId;

  bool isLoading = true;

  AttendeeFilterBy? status = AttendeeFilterBy.ALL;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - getAttendeeList] action in AttendeesScreen widget.
  List<AttendeeRow>? attendeeList;
  // Stores action output result for [Bottom Sheet - LookupScannerBottomSheet] action in IconButton widget.
  String? scannedValue;
  // Stores action output result for [Custom Action - findAttendee] action in IconButton widget.
  AttendeeRow? redirectAttendeeResponse;
  // Stores action output result for [Custom Action - csvReader] action in IconButton widget.
  FFUploadedFile? selectedFileData;
  // Stores action output result for [Backend Call - API (Upload CSV)] action in IconButton widget.
  ApiCallResponse? uploadFileResponse;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // Stores action output result for [Alert Dialog - Custom Dialog] action in IconButton widget.
  ExportFileStruct? haveExport;
  // Stores action output result for [Alert Dialog - Custom Dialog] action in IconButton widget.
  ExportFileStruct? exportResponse;
  // Stores action output result for [Alert Dialog - Custom Dialog] action in IconButton widget.
  ExportFileStruct? hasOpenFile;
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

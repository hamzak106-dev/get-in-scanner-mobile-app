import 'package:flutter/src/widgets/framework.dart';
import 'package:g_e_t_i_n_scanner/backend/supabase/database/tables/add_on.dart';
import 'package:g_e_t_i_n_scanner/flutter_flow/flutter_flow_model.dart';
import 'package:g_e_t_i_n_scanner/pages/home_screens/add_pin_screen/add_pin_screen_widget.dart';

class AddOnDetailsScreenModel extends FlutterFlowModel<AddPinScreenWidget> {
  AddOnRow? _addOnDetails;

  AddOnRow? get addOnDetails => _addOnDetails;

  set addOnDetails(AddOnRow? value) {
    _addOnDetails = value;
  }

  @override
  void dispose() {}

  @override
  void initState(BuildContext context) {}
}

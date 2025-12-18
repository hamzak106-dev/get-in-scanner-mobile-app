import '/backend/supabase/supabase.dart';
import '/components/permission_tile/permission_tile_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'pin_permissions_screen_widget.dart' show PinPermissionsScreenWidget;
import 'package:flutter/material.dart';

class PinPermissionsScreenModel
    extends FlutterFlowModel<PinPermissionsScreenWidget> {
  ///  Local state fields for this page.

  bool isAdminDevice = true;

  int permissions = 0;

  bool isScannerCheck = false;

  bool isManualEntry = false;

  bool isLookUpCheck = false;

  bool isStatCheck = false;

  bool isSettingsCheck = false;

  int pinPermissionNumber = 0;

  ///  State fields for stateful widgets in this page.

  // Model for PermissionTile component.
  late PermissionTileModel permissionTileModel1;
  // Stores action output result for [Custom Action - updatePermissionBitMask] action in PermissionTile widget.
  int? permissionNumber;
  // Model for PermissionTile component.
  late PermissionTileModel permissionTileModel2;
  // Stores action output result for [Custom Action - updatePermissionBitMask] action in PermissionTile widget.
  int? permissionNumber1;
  // Model for PermissionTile component.
  late PermissionTileModel permissionTileModel3;
  // Stores action output result for [Custom Action - updatePermissionBitMask] action in PermissionTile widget.
  int? permissionNumber2;
  // Model for PermissionTile component.
  late PermissionTileModel permissionTileModel4;
  // Stores action output result for [Custom Action - updatePermissionBitMask] action in PermissionTile widget.
  int? permissionNumber3;
  // Model for PermissionTile component.
  late PermissionTileModel permissionTileModel5;
  // Stores action output result for [Custom Action - updatePermissionBitMask] action in PermissionTile widget.
  int? permissionNumber4;
  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<PinRow>? updatedPinRows;

  @override
  void initState(BuildContext context) {
    permissionTileModel1 = createModel(context, () => PermissionTileModel());
    permissionTileModel2 = createModel(context, () => PermissionTileModel());
    permissionTileModel3 = createModel(context, () => PermissionTileModel());
    permissionTileModel4 = createModel(context, () => PermissionTileModel());
    permissionTileModel5 = createModel(context, () => PermissionTileModel());
  }

  @override
  void dispose() {
    permissionTileModel1.dispose();
    permissionTileModel2.dispose();
    permissionTileModel3.dispose();
    permissionTileModel4.dispose();
    permissionTileModel5.dispose();
  }
}

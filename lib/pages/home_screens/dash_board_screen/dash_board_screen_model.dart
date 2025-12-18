import '/backend/supabase/supabase.dart';
import '/components/rive_animation_view/rive_animation_view_widget.dart';
import '/components/screen_component/admin_dashboard/admin_dashboard_widget.dart';
import '/components/screen_component/user_dashboard/user_dashboard_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/manager/manager_dashboard/manager_dashboard_widget.dart';
import '/index.dart';
import 'dash_board_screen_widget.dart' show DashBoardScreenWidget;
import 'package:flutter/material.dart';

class DashBoardScreenModel extends FlutterFlowModel<DashBoardScreenWidget> {
  ///  Local state fields for this page.

  List<EventsRow> events = [];
  void addToEvents(EventsRow item) => events.add(item);
  void removeFromEvents(EventsRow item) => events.remove(item);
  void removeAtIndexFromEvents(int index) => events.removeAt(index);
  void insertAtIndexInEvents(int index, EventsRow item) => events.insert(index, item);
  void updateEventsAtIndex(int index, Function(EventsRow) updateFn) => events[index] = updateFn(events[index]);

  bool topBannerVisible = false;

  Color? bannerColor = Color(4285248255);

  String messageSyncing = 'Syncing Started ...';

  bool isDeleteDialogOpen = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Alert Dialog - Custom Dialog] action in DashBoardScreen widget.
  bool? deleteAccount;

  double currentProgress = 0.0;
  // Model for ManagerDashboard component.
  late ManagerDashboardModel managerDashboardModel;
  // Model for UserDashboard component.
  late UserDashboardModel userDashboardModel;
  // Model for AdminDashboard component.
  late AdminDashboardModel adminDashboardModel;
  // Model for RiveAnimationView component.
  late RiveAnimationViewModel riveAnimationViewModel;

  @override
  void initState(BuildContext context) {
    managerDashboardModel = createModel(context, () => ManagerDashboardModel());
    userDashboardModel = createModel(context, () => UserDashboardModel());
    adminDashboardModel = createModel(context, () => AdminDashboardModel());
    riveAnimationViewModel = createModel(context, () => RiveAnimationViewModel());
  }

  @override
  void dispose() {
    managerDashboardModel.dispose();
    userDashboardModel.dispose();
    adminDashboardModel.dispose();
    riveAnimationViewModel.dispose();
  }
}

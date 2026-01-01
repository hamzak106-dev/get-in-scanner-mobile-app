import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:g_e_t_i_n_scanner/components/event_seating/transfer_summary_widget.dart';
import 'package:g_e_t_i_n_scanner/components/setting/splash_setting_widget.dart';
import 'package:g_e_t_i_n_scanner/pages/home_screens/event_page_tickets/event_page_tickets_widget.dart'
    show EventPageTicketsWidget;
import 'package:g_e_t_i_n_scanner/pages/home_screens/scanner_pos/feature_not_available.dart'
    show FeatureDisabledPage;
import 'package:provider/provider.dart';

import '../../components/event_seating/seatsio_seat_manager_widget.dart';
import '../custom_functions.dart' as functions;
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import '/main.dart';

export 'package:go_router/go_router.dart';

export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;

  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  bool showSplashImage = true;

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      navigatorKey: appNavigatorKey,
      errorBuilder: (context, state) {
        log("From router.dart: Error in router: ${state.error}");
        context.watch<AppStateNotifier>();
        return appStateNotifier.showSplashImage
            ? Builder(
          builder: (context) =>
              Container(
                color: FlutterFlowTheme
                    .of(context)
                    .primaryBackground,
                child: Center(
                  child: Image.asset(
                    'assets/images/appLogo.png',
                    width: 120.0,
                    height: 120.0,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
        )
            : LoadingScreenWidget();
      },
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) {
            Widget splashLogo = Container(
              color: FlutterFlowTheme.of(context).primaryBackground,
              child: Center(
                child: Image.asset(
                  'assets/images/appLogo.png',
                  width: 120.0,
                  height: 120.0,
                  fit: BoxFit.fill,
                ),
              ),
            );

            // Always show splash logo first for 2 seconds
            Future.microtask(() async {
              await Future.delayed(const Duration(seconds: 3));

              if (FFAppState().splashScreenStatus == 'Enabled') {
                context.goNamed(LoadingScreenWidget.routeName);
              } else {
                if (functions.checkJson(FFAppState().user.toMap()) &&
                    (FFAppState().user.userId != 0)) {
                  context.goNamed(DashBoardScreenWidget.routeName);
                } else {
                  context.goNamed(LoginScreenWidget.routeName);
                }
              }
            });

            return splashLogo;
          },
        ),
        FFRoute(
          name: LoadingScreenWidget.routeName,
          path: LoadingScreenWidget.routePath,
          builder: (context, params) => LoadingScreenWidget(
            avoidWaiting: params.getParam(
              'avoidWaiting',
              ParamType.bool,
            ),
          ),
        ),
        FFRoute(
          name: LoginScreenWidget.routeName,
          path: LoginScreenWidget.routePath,
          builder: (context, params) => LoginScreenWidget(),
        ),
        FFRoute(
          name: ForgotPasswordScreenWidget.routeName,
          path: ForgotPasswordScreenWidget.routePath,
          builder: (context, params) => ForgotPasswordScreenWidget(),
        ),
        FFRoute(
          name: DashBoardScreenWidget.routeName,
          path: DashBoardScreenWidget.routePath,
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'DashBoardScreen')
              : DashBoardScreenWidget(),
        ),
        FFRoute(
          name: ScannerPosWidget.routeName,
          path: ScannerPosWidget.routePath,
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'ScannerPos')
              : ScannerPosWidget(),
        ),
        FFRoute(
          name: SummaryScreenWidget.routeName,
          path: SummaryScreenWidget.routePath,
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'SummaryScreen')
              : SummaryScreenWidget(),
        ),
        FFRoute(
          name: ScanScreenWidget.routeName,
          path: ScanScreenWidget.routePath,
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'ScanScreen')
              : ScanScreenWidget(),
        ),
        FFRoute(
          name: SettingScreenWidget.routeName,
          path: SettingScreenWidget.routePath,
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'SettingScreen')
              : SettingScreenWidget(),
        ),
        FFRoute(
          name: AttendeesDetailScreenWidget.routeName,
          path: AttendeesDetailScreenWidget.routePath,
          builder: (context, params) {
            Map<String, dynamic> json = params.getParam(
                  'attendee',
                  ParamType.JSON,
                ) ??
                {};
            final row = AttendeeRow.mapAttendeeWithAddons(json);
          return AttendeesDetailScreenWidget(attendee: row);
          },
        ),
        FFRoute(
          name: AttendeesScreenWidget.routeName,
          path: AttendeesScreenWidget.routePath,
          builder: (context, params) => AttendeesScreenWidget(
            eventId: params.getParam(
              'eventId',
              ParamType.int,
            ),
          ),
        ),
        FFRoute(
          name: PasskeyLoginScreenWidget.routeName,
          path: PasskeyLoginScreenWidget.routePath,
          builder: (context, params) => PasskeyLoginScreenWidget(),
        ),
        FFRoute(
          name: OtpScreenWidget.routeName,
          path: OtpScreenWidget.routePath,
          builder: (context, params) => OtpScreenWidget(
            token: params.getParam(
              'token',
              ParamType.String,
            ),
            phoneEmail: params.getParam(
              'phoneEmail',
              ParamType.String,
            ),
            otp: params.getParam(
              'otp',
              ParamType.String,
            ),
            countryCode: params.getParam(
              'countryCode',
              ParamType.String,
            ),
            firebaseToken: params.getParam(
              'firebaseToken',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: AddScannersScreenWidget.routeName,
          path: AddScannersScreenWidget.routePath,
          builder: (context, params) => AddScannersScreenWidget(
            scanner: params.getParam<PinRow>(
              'scanner',
              ParamType.SupabaseRow,
            ),
            device: params.getParam<DeviceRow>(
              'device',
              ParamType.SupabaseRow,
            ),
          ),
        ),
        FFRoute(
          name: EventSummaryScreenWidget.routeName,
          path: EventSummaryScreenWidget.routePath,
          builder: (context, params) => EventSummaryScreenWidget(
            event: params.getParam<EventsRow>(
              'event',
              ParamType.SupabaseRow,
            ),
          ),
        ),
        FFRoute(
          name: TicketCommentScreenWidget.routeName,
          path: TicketCommentScreenWidget.routePath,
          builder: (context, params) => TicketCommentScreenWidget(
            attendee: params.getParam<AttendeeRow>(
              'attendee',
              ParamType.SupabaseRow,
            ),
            isRemark: params.getParam(
              'isRemark',
              ParamType.bool,
            ),
          ),
        ),
        FFRoute(
          name: SyncScreenWidget.routeName,
          path: SyncScreenWidget.routePath,
          builder: (context, params) => SyncScreenWidget(),
        ),
        FFRoute(
          name: AddPinScreenWidget.routeName,
          path: AddPinScreenWidget.routePath,
          builder: (context, params) => AddPinScreenWidget(
            pinData: params.getParam<PinRow>(
              'pinData',
              ParamType.SupabaseRow,
            ),
            isNew: params.getParam(
              'isNew',
              ParamType.bool,
            ),
          ),
        ),
        FFRoute(
          name: PinDetailsScreenWidget.routeName,
          path: PinDetailsScreenWidget.routePath,
          builder: (context, params) => PinDetailsScreenWidget(
            pinData: params.getParam<PinRow>(
              'pinData',
              ParamType.SupabaseRow,
            ),
            isNew: params.getParam(
              'isNew',
              ParamType.bool,
            ),
          ),
        ),
        FFRoute(
          name: PinInfoScreenWidget.routeName,
          path: PinInfoScreenWidget.routePath,
          builder: (context, params) => PinInfoScreenWidget(
            pin: params.getParam<PinRow>(
              'pin',
              ParamType.SupabaseRow,
            ),
            isNew: params.getParam(
              'isNew',
              ParamType.bool,
            ),
          ),
        ),
        FFRoute(
          name: PinEventsScreenWidget.routeName,
          path: PinEventsScreenWidget.routePath,
          builder: (context, params) => PinEventsScreenWidget(
            pin: params.getParam<PinRow>(
              'pin',
              ParamType.SupabaseRow,
            ),
            isNew: params.getParam(
              'isNew',
              ParamType.bool,
            ),
          ),
        ),
        FFRoute(
          name: PinDevicesScreenWidget.routeName,
          path: PinDevicesScreenWidget.routePath,
          builder: (context, params) => PinDevicesScreenWidget(
            pin: params.getParam<PinRow>(
              'pin',
              ParamType.SupabaseRow,
            ),
          ),
        ),
        FFRoute(
          name: PinPermissionsScreenWidget.routeName,
          path: PinPermissionsScreenWidget.routePath,
          builder: (context, params) => PinPermissionsScreenWidget(
            pin: params.getParam<PinRow>(
              'pin',
              ParamType.SupabaseRow,
            ),
            isNew: params.getParam(
              'isNew',
              ParamType.bool,
            ),
          ),
        ),
        FFRoute(
          name: EditAttendeeScreenWidget.routeName,
          path: EditAttendeeScreenWidget.routePath,
          builder: (context, params) => EditAttendeeScreenWidget(
            attendee: params.getParam<AttendeeRow>(
              'attendee',
              ParamType.SupabaseRow,
            ),
          ),
        ),
        FFRoute(
          name: PinByManagerWidget.routeName,
          path: PinByManagerWidget.routePath,
          builder: (context, params) => PinByManagerWidget(
            eventId: params.getParam(
              'eventId',
              ParamType.int,
            ),
            producerId: params.getParam(
              'producerId',
              ParamType.int,
            ),
          ),
        ),
        FFRoute(
          name: SelectProfileScreenWidget.routeName,
          path: SelectProfileScreenWidget.routePath,
          builder: (context, params) => SelectProfileScreenWidget(),
        ),
        FFRoute(
          name: SplashSettingWidget.routeName,
          path: SplashSettingWidget.routePath,
          builder: (context, params) => SplashSettingWidget(),
        ),
        FFRoute(
          name: TransferSummaryWidget.routeName,
          path: TransferSummaryWidget.routePath,
          builder: (context, params) => TransferSummaryWidget(),
        ),
        FFRoute(
          name: SeatsioSeatManagerWidget.routeName,
          path: SeatsioSeatManagerWidget.routePath,
          builder: (context, params) => SeatsioSeatManagerWidget(),
        ),
        FFRoute(
          name: PinManagerEventsScreenWidget.routeName,
          path: PinManagerEventsScreenWidget.routePath,
          builder: (context, params) => PinManagerEventsScreenWidget(),
        ),
        FFRoute(
          name: AddOnsListScreenWidget.routeName,
          path: AddOnsListScreenWidget.routePath,
          builder: (context, params) => AddOnsListScreenWidget(
            attendeeUid: params.getParam<int>(
              'attendeeUid',
              ParamType.int,
            ),
          ),
        ),
        FFRoute(
          name: AddOnDetailsScreenWidget.routeName,
          path: AddOnDetailsScreenWidget.routePath,
          builder: (context, params) {
            final json = params.getParam<Map<String, dynamic>>(
                  'addOnDetails',
                  ParamType.JSON,
                ) ??
                {};

            final data = AddOnRow(Map<String, dynamic>.from(json));
            print('AddOnDetailsScreenWidget: $data');

            return AddOnDetailsScreenWidget(
              addOnDetails: data,
            );
          },
        ),
        FFRoute(
          name: EventPageTicketsWidget.routeName,
          path: EventPageTicketsWidget.routePath,
          builder: (context, params) => EventPageTicketsWidget(
            eventId: params.getParam(
              'event_id',
              ParamType.int,
            ),
          ),
        ),
        FFRoute(
          name: EventPagePurchaserDetailsWidget.routeName,
          path: EventPagePurchaserDetailsWidget.routePath,
          builder: (context, params) => EventPagePurchaserDetailsWidget(
            eventId: params.getParam(
              'event_id',
              ParamType.int,
            ),
            hash: params.getParam(
              'hash',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: EventPageAmountEntryWidget.routeName,
          path: EventPageAmountEntryWidget.routePath,
          builder: (context, params) => EventPageAmountEntryWidget(
            eventId: params.getParam(
              'event_id',
              ParamType.int,
            ),
          ),
        ),
        FFRoute(
            name: TutorialsWidget.routeName,
            path: TutorialsWidget.routePath,
            builder: (context, params) => TutorialsWidget()),
        FFRoute(
            name: TapToPayDocumentWidget.routeName,
            path: TapToPayDocumentWidget.routePath,
            builder: (context, params) => TapToPayDocumentWidget()),
        FFRoute(
            name: ChekoutWidget.routeName,
            path: ChekoutWidget.routePath,
            builder: (context, params) => ChekoutWidget()),
        FFRoute(
            name: FeatureDisabledPage.routeName,
            path: FeatureDisabledPage.routePath,
            builder: (context, params) => FeatureDisabledPage(
                  message: params.getParam(
                    'message',
                    ParamType.String,
                  ),
                 )),
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};

  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);

  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.allParams.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));

  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;

  bool get hasFutures => state.allParams.entries.any(isAsyncParam);

  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, {
    bool isList = false,
    StructBuilder<T>? structBuilder,
  }) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
      structBuilder: structBuilder,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);

  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouterState.of(context).uri.toString();
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}

extension GoRouterLocationExtension on GoRouter {
  String getCurrentLocation() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}

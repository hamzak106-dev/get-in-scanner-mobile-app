import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:g_e_t_i_n_scanner/backend/schema/enums/enums.dart';
import 'package:g_e_t_i_n_scanner/flutter_flow/custom_functions.dart';
import 'package:provider/provider.dart';
import 'package:upgrader/upgrader.dart';
import '/backend/supabase/supabase.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/flutter_flow_theme.dart';
import 'backend/firebase/firebase_config.dart';
import 'config/flavor_helper.dart';
import 'custom_code/actions/index.dart' as customActions;
import 'custom_code/actions/listen_for_internet_access.dart';
import 'flutter_flow/firebase_app_check_util.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  actions.checkForUpdates();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  usePathUrlStrategy();
  await FlavorHelper.initialize();

  await initFirebase(devFlavor: FlavorHelper.devFlavor);
  await initializeFirebaseRemoteConfig();
  await initializeFirebaseAppCheck();

  FlavorHelper.appFlavor = await FlavorHelper.getFlavorConfig();

  await SupaFlow.initialize();
  final appState = FFAppState(); // Initialize FFAppState
  await appState.initializePersistedState();

  // Start final custom actions code
  await actions.initPowerSync();
  // await actions.startMulticast();
  await actions.listenForInternetAccess();
  // End final custom actions code

  // Get Flavor Config

  if (kDebugMode) {
    debugPrint('APP FLAVOR ${FlavorHelper.appFlavor.name}');
    debugPrint('APP Base URL ${FlavorHelper.appFlavor.apiBaseUrl}');
    debugPrint('PowerSync URL ${FlavorHelper.appFlavor.powerSyncUrl}');
    debugPrint('GetInAppBaseUrl ${FlavorHelper.appFlavor.getInAppBaseUrl}');
    debugPrint('SB API URL ${FlavorHelper.appFlavor.sbApiUrl}');
  }

  runApp(ChangeNotifierProvider(
    create: (context) => appState,
    child: ChangeNotifierProvider(
        create: (_) => AppStateNotifier.instance, child: const MyApp()),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;

  String getRoute([RouteMatchBase? routeMatch]) {
    final RouteMatchBase lastMatch =
        routeMatch ?? _router.routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : _router.routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }

  List<String> getRouteStack() =>
      _router.routerDelegate.currentConfiguration.matches
          .map((e) => getRoute(e))
          .toList();

  bool displaySplashImage = true;
  bool isDisplaySafeArea = false;

  @override
  void initState() {
    super.initState();

    _appStateNotifier = AppStateNotifier.instance;
    _router = createRouter(_appStateNotifier);

    Future.delayed(const Duration(milliseconds: 1000),
        () => safeSetState(() => _appStateNotifier.stopShowingSplashImage()));

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (isAndroid) {
        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        if (androidInfo.version.sdkInt >= 34) {
          isDisplaySafeArea = true;
          safeSetState(() {});
        }
      }
    });
  }

  void setThemeMode(ThemeMode mode) => safeSetState(() {
        _themeMode = mode;
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'GETIN Scanner',
      // localizationsDelegates: const [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      debugShowCheckedModeBanner: !kDebugMode,
      supportedLocales: const [Locale('en', '')],
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      themeMode: _themeMode,
      routerConfig: _router,
      builder: (context, child) {
        return UpgradeAlert(
          navigatorKey: _router.routerDelegate.navigatorKey,
          upgrader: Upgrader(durationUntilAlertAgain: Duration(minutes: 1)),
          onUpdate: () {
            return true;
          },
          onIgnore: () {
            return true;
          },
          onLater: () {
            return true;
          },
          child: isDisplaySafeArea
              ? SafeArea(bottom: true, child: child!)
              : child!,
        );
      },
    );
  }

  @override
  void dispose() {
    stopConnectivityListener();
    super.dispose();
  }
}

class NavBarPage extends StatefulWidget {
  const NavBarPage({super.key, this.initialPage, this.page});

  final String? initialPage;
  final Widget? page;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {
  String _currentPageName = 'DashBoardScreen';
  late Widget? _currentPage;

  DateTime? currentBackPressTime;
  bool canPopNow = false;
  int requiredSeconds = 2;

  @override
  void initState() {
    super.initState();
    _currentPageName = widget.initialPage ?? _currentPageName;
    _currentPage = widget.page;
  }

  @override
  void didUpdateWidget(NavBarPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialPage != null && widget.initialPage != _currentPageName) {
      setState(() {
        _currentPageName = widget.initialPage!;
        _currentPage = widget.page;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String? allowTapToPay = getRemoteConfigString('allow_tap_to_pay');

    bool isAllowTapToPay = true;
    // FlavorHelper.prodFlavor
    //     ? (isAndroid &&
    //         () {
    //           if (allowTapToPay == null || allowTapToPay.isEmpty) {
    //             // Empty → allow all
    //             return true;
    //           }
    //           // Split by "." and check if user email exists
    //           final allowedEmails =
    //               allowTapToPay.split(',').map((e) => e.trim()).toList();
    //           print("Allowed email " + allowedEmails.toString());
    //           return allowedEmails.contains(FFAppState().user.user.email);
    //         }())
    //     : true;

    final tabs = {
      if (isAllowTapToPay) 'ScannerPos': ScannerPosWidget(),
      'DashBoardScreen': const DashBoardScreenWidget(),
      'ScanScreen': const ScanScreenWidget(),
      'SummaryScreen': const SummaryScreenWidget(),
      'SettingScreen': const SettingScreenWidget(),
    };
    final currentIndex = tabs.keys.toList().indexOf(_currentPageName);

    return PopScope(
      canPop: canPopNow,
      onPopInvokedWithResult: (didPop, result) {
        DateTime now = DateTime.now();
        if (currentBackPressTime == null ||
            now.difference(currentBackPressTime!) >
                Duration(seconds: requiredSeconds)) {
          currentBackPressTime = now;
          Fluttertoast.showToast(
              msg: "Click exit again", gravity: ToastGravity.CENTER);
          Future.delayed(
            Duration(seconds: requiredSeconds),
            () {
              // Disable pop invoke and close the toast after 2s timeout
              setState(() {
                canPopNow = false;
              });
              Fluttertoast.cancel();
            },
          );
          // Ok, let user exit app on the next back press
          setState(() {
            canPopNow = true;
          });
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            _currentPage ?? tabs[_currentPageName]!,
            // if(isAllowTapToPay)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                // height: 60,
                constraints: BoxConstraints(
                  minHeight: isiOS ? 76 : 56,
                ),
                color: Colors.transparent,
                padding: const EdgeInsets.only(top: 10),
                alignment: Alignment.topCenter,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    // Main Row
                    Container(
                      // height: isiOS ? 76: 56,
                      constraints: BoxConstraints(
                        minHeight: isiOS ? 76 : 56,
                      ),
                      color: Colors.black.withValues(alpha: .25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Ticket
                          if (isAllowTapToPay)
                            _buildNavItem(
                              context,
                              asset: 'assets/svg/ticket2.svg',
                              pageName: 'ScannerPos',
                            ),

                          // Dashboard
                          _buildNavItem(
                            context,
                            asset: 'assets/svg/user_search.svg',
                            pageName: 'DashBoardScreen',
                            permissionCheck: ()  =>
                                getAccessPermissionAllow(
                              FFAppState().user.permissions,
                              AccessPermission.scan,
                              FFAppState().user.profile,
                            ),
                          ),
                          if (isAllowTapToPay)
                            const SizedBox(width: 40)
                          else
                            _buildNavItem(
                              context,
                              asset: 'assets/svg/scan_barcode.svg',
                              pageName: 'ScanScreen',
                              permissionCheck: () =>
                                getAccessPermissionAllow(
                                  FFAppState().user.permissions,
                                  AccessPermission.scan,
                                  FFAppState().user.profile,
                                ),
                            ),
                          // Stats
                          _buildNavItem(
                            context,
                            asset: 'assets/svg/statics.svg',
                            pageName: 'SummaryScreen',
                            permissionCheck: () =>
                                getAccessPermissionAllow(
                              FFAppState().user.permissions,
                              AccessPermission.stats,
                              FFAppState().user.profile,
                            ),
                          ),

                          // Settings
                          _buildNavItem(
                            context,
                            asset: 'assets/svg/setting2.svg',
                            pageName: 'SettingScreen',
                          ),
                        ],
                      ),
                    ),

                    if (isAllowTapToPay)
                      Center(
                        heightFactor: 0.7,
                        child: Material(
                          shape: const CircleBorder(),
                          color: FlutterFlowTheme.of(context).secondary,
                          child: InkWell(
                            customBorder: const CircleBorder(),
                            splashColor: FlutterFlowTheme.of(context)
                                .alternate
                                .withValues(alpha: 0.3),
                            onTap: () async {
                              // bool hasCameraAccess = await customActions
                              //     .requestCameraPermission(context);
                              // if (!hasCameraAccess) {
                              //   return;
                              // }
                              bool isAllow = getAccessPermissionAllow(
                                FFAppState().user.permissions,
                                AccessPermission.scan,
                                FFAppState().user.profile,
                              );
                              if (!isAllow) {
                                return;
                              }
                              safeSetState(() {
                                _currentPage = null;
                                _currentPageName = 'ScanScreen';
                              });
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 26,
                              child: SvgPicture.asset(
                                'assets/svg/scan_barcode.svg',
                                colorFilter: _currentPageName == 'ScanScreen'
                                    ? ColorFilter.mode(
                                        FlutterFlowTheme.of(context).alternate,
                                        BlendMode.srcIn,
                                      )
                                    : null,
                              ),
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: isiOS
            ? Container(
                height: 20,
                color: Colors.black,
              )
            : null,
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required String asset,
    required String pageName,
    bool Function()? permissionCheck,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        customBorder: const CircleBorder(),
        splashColor:
            FlutterFlowTheme.of(context).secondary.withValues(alpha: 0.2),
        hoverColor:
            FlutterFlowTheme.of(context).secondary.withValues(alpha: 0.1),
        onTap: () {
          if (permissionCheck != null) {
            bool allow = permissionCheck();
            if (!allow) {

              return;
            }
          }
          safeSetState(() {
            _currentPage = null;
            _currentPageName = pageName;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            asset,
            height: 25,
            colorFilter: _currentPageName == pageName
                ? ColorFilter.mode(
                    FlutterFlowTheme.of(context).secondary,
                    BlendMode.srcIn,
                  )
                : null,
          ),
        ),
      ),
    );
  }
}

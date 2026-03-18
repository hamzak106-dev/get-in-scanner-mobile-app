import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:g_e_t_i_n_scanner/components/event_page_components/checkout_items/checkout_items_widget.dart';
import 'package:g_e_t_i_n_scanner/components/readytousetaptopay/readytousetaptopay_widget.dart'
    show ReadytousetaptopayWidget;
import 'package:g_e_t_i_n_scanner/pages/home_screens/scanner_pos/feature_not_available.dart';
import 'package:gradient_progress_bar/gradient_progress_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import '../../backend/schema/enums/enums.dart' show Profile;
import '../../custom_code/actions/index.dart' as actions;
import 'card_scanning_model.dart';
import 'location_permission_bottom_sheet_widget.dart';
import 'package:location/location.dart' as loc;

export 'card_scanning_model.dart';

enum TTPStatus { initial, preparing, success }

class CardScanningWidget extends StatefulWidget {
  final int eventId;

  const CardScanningWidget({super.key, required this.eventId});

  @override
  State<CardScanningWidget> createState() => _CardScanningWidgetState();
}

class _CardScanningWidgetState extends State<CardScanningWidget>
    with TickerProviderStateMixin {
  late CardScanningModel _model;
  ValueNotifier<String> _termsAndConditionUrl = ValueNotifier<String>('');
  TTPStatus _status = TTPStatus.initial;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late AnimationController _progressController;
  late Animation<double> _progressAnimation;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CardScanningModel());
    logFirebaseEvent('CARD_SCANNING_PAGE_initState');

    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    try {
      _progressController.animateTo(1.0,
          duration: const Duration(milliseconds: 400));
    } catch (e) {
      debugPrint('Error initializing terminal: $e');
    }

    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeInOut),
    )..addListener(() {
        setState(() {});
      });

    _progressController.repeat();

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      try {
        _model.terminalOnboardingLink =
            await actions.QuickPay().getOnboardingLink(
          (FFAppState().user.profile == Profile.manager)
              ? FFAppState().selectedProducer.firstName
              : FFAppState().user.user.firstName,
        );
        _termsAndConditionUrl.value =
            _model.terminalOnboardingLink?.redirectUrl ?? '';
        if (_model.terminalOnboardingLink?.redirectUrl == null) {
          _model.errorMessage = 'Failed to load terms URL';
        }
      } catch (e) {
        _model.errorMessage = e.toString();
      }
      _model.termsLoading = false;
      safeSetState(() {});
    });
  }

  @override
  void dispose() {
    _progressController.dispose();
    _model.maybeDispose();
    super.dispose();
  }

  Future<void> _proceedWithTapToPay() async {
    logFirebaseEvent('CARD_SCANNING_PAGE_ENABLE_TAP_TO_PAY_ON_IPHONE');
    if (!_model.isChecked) {
      try {
        final urlToOpen = _model.terminalOnboardingLink!.redirectUrl!;

        final result = await Navigator.push<Map<String, dynamic>>(
          context,
          MaterialPageRoute(
            builder: (context) => TapToPaySetupPage(setupUrl: urlToOpen),
          ),
        );

        debugPrint("Setup result: $result");

        if (result?['success'] == true) {
          _model.isChecked = true;

          // Log if user was already authenticated
          if (result?['wasAlreadyAuthenticated'] == true) {
            debugPrint('✅ User was already authenticated');
          } else {
            debugPrint('✅ User completed first-time authentication');
          }

          safeSetState(() {});
        } else if (result?['cancelled'] == true) {
          debugPrint('⚠️ User cancelled setup');
        }
      } catch (e) {
        debugPrint('Could not launch URL: $e');
      }
      return;
    }

    setState(() {
      _status = TTPStatus.preparing;
    });
    _progressController.repeat();

    await actions.QuickPay().initTerminal(widget.eventId, onError: (err) {
      _progressController.stop();
      context.pushNamed(FeatureDisabledPage.routeName, pathParameters: {
        'message': '$err',
      });
    }, onInitialized: () async {
      _progressController
          .animateTo(1.0, duration: const Duration(milliseconds: 400))
          .then((_) {
        setState(() {
          _status = TTPStatus.success;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_status == TTPStatus.success) {
      return const ReadytousetaptopayWidget();
    }

    if (_status == TTPStatus.preparing) {
      return ChekoutWidget();
    }

    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.sizeOf(context).width * 1.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondary,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(20.0, 16.0, 20.0, 20.0),
          child: _buildInitialView(),
        ),
      ),
    );
  }

  Widget _buildPreparingView() {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Text(
                        'CHECKOUT',
                        style: FlutterFlowTheme.of(context).titleSmall.override(
                              fontFamily: 'Mona Sans',
                              letterSpacing: 0.0,
                            ),
                      ),
                    ),
                  ),
                ].addToEnd(SizedBox(width: 40.0)),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GradientProgressIndicator(
                    [
                      Color(0xff8A38F5),
                      Color(0xff9636dd),
                      Color(0xfff92925),
                      Color(0xffFF281B),
                    ],
                    _progressAnimation.value,
                  )
                ].divide(SizedBox(height: 4.0)),
              ),
            ),
            Expanded(
              child: Align(
                alignment: AlignmentDirectional(0.0, 0.0),
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Preparing Tap to Pay${isiOS ? ' on iPhone' : ''}',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Mona Sans',
                              fontSize: 14.0,
                              letterSpacing: 0.0,
                            ),
                      ),
                    ].divide(SizedBox(height: 4.0)),
                  ),
                ),
              ),
            ),
          ].divide(SizedBox(height: 0.0)),
        ),
      ),
    );
  }

  Widget _buildInitialView() {
    return Builder(builder: (context) {
      if (_model.termsLoading) {
        return const SizedBox(
            height: 200,
            child:
                Center(child: CircularProgressIndicator(color: Colors.black)));
      }
      if (_model.errorMessage != null) {
        return _buildErrorView();
      }
      return Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 50.0,
              height: 5.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).accent1,
                borderRadius: BorderRadius.circular(100.0),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ValueListenableBuilder(
              valueListenable: _termsAndConditionUrl,
              builder: (context, termsUrl, child) {
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'TAP TO PAY ON IPHONE\nNOW AVAILABLE.',
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Mona Sans',
                            color: FlutterFlowTheme.of(context).alternate,
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Accept contactless payments on your iPhone.',
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Mona Sans',
                            color: FlutterFlowTheme.of(context).alternate,
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                          ),
                    ),
                    const SizedBox(height: 10),
                    FFButtonWidget(
                      onPressed: () async {
                        final status =
                            await actions.requestLocationPermissionStatus();
                        if (status == loc.PermissionStatus.granted) {
                          await _proceedWithTapToPay();
                          return;
                        }
                        await showModalBottomSheet(
                          context: context,
                          builder: (bc) => LocationPermissionBottomSheetWidget(
                            onContinue: () async {
                              Navigator.pop(bc);
                              await _proceedWithTapToPay();
                            },
                          ),
                        );
                      },
                      text: 'ENABLE TAP TO PAY ON IPHONE',
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 48.0,
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        textStyle:
                            FlutterFlowTheme.of(context).titleSmall.override(
                                  fontFamily: 'Mona Sans',
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildTermsAndConditions(termsUrl),
                  ],
                );
              }),
        ],
      );
    });
  }

  Widget _buildErrorView() {
    return Column(
      children: [
        Text(
          '${_model.errorMessage}',
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: 'Mona Sans',
                color: FlutterFlowTheme.of(context).alternate,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 10),
        FFButtonWidget(
          onPressed: () => Navigator.pop(context),
          text: 'OK',
          options: FFButtonOptions(
            width: double.infinity,
            height: 48.0,
            color: FlutterFlowTheme.of(context).secondaryBackground,
            textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                  fontFamily: 'Mona Sans',
                  color: Colors.white,
                ),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ],
    );
  }

  Widget _buildTermsAndConditions(String termsUrl) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(children: [
          TextSpan(
            text: 'By Enabling Your are agree to the '
                .toCapitalization(TextCapitalization.words),
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Mona Sans',
                  color: const Color(0xFF6B6D75),
                  fontSize: 12.0,
                ),
          ),
          TextSpan(
            text: 'terms and\nconditions'
                .toCapitalization(TextCapitalization.words),
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Mona Sans',
                  color: const Color(0xFFFF281B),
                  fontSize: 12.0,
                ),
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                try {
                  await launchURL(termsUrl);
                  _model.isChecked = true;
                  safeSetState(() {});
                } catch (e) {}
              },
          ),
          TextSpan(
            text: ' for the tap-to-pay feature '
                .toCapitalization(TextCapitalization.words),
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Mona Sans',
                  color: const Color(0xFF6B6D75),
                  fontSize: 12.0,
                ),
          ),
          TextSpan(
            text: 'Find out more'.toCapitalization(TextCapitalization.words),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                context.pushNamed(TutorialsWidget.routeName,
                    pathParameters: {'url': termsUrl});
              },
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Mona Sans',
                  color: const Color(0xFFFF281B),
                  fontSize: 12.0,
                  decoration: TextDecoration.underline,
                ),
          ),
        ]),
      ),
    );
  }
}
// ========================================
// UPDATED TapToPaySetupPage with improved authentication detection
// ========================================

class TapToPaySetupPage extends StatefulWidget {
  final String setupUrl;

  const TapToPaySetupPage({Key? key, required this.setupUrl}) : super(key: key);

  @override
  State<TapToPaySetupPage> createState() => _TapToPaySetupPageState();
}

class _TapToPaySetupPageState extends State<TapToPaySetupPage> {
  late final WebViewController _controller;
  bool _setupCompleted = false;
  bool _hasSeenOnboarding = false;
  bool _hasSeenSignIn = false;
  int _onboardingVisitCount = 0;
  DateTime? _firstOnboardingTime;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) {
            debugPrint('WebView is loading (progress : $progress%)');
            if (progress > 10 && _isLoading) {
              setState(() {
                _isLoading = false;
              });
            }
          },
          onPageFinished: (url) {
            debugPrint('🔗 URL finished loading: $url');
            _checkIfSetupComplete(url);
          },
          onUrlChange: (UrlChange change) {
            debugPrint('🔗 URL changed to: ${change.url}');

            if (change.url != null) {
              _trackUrlFlow(change.url!);
            }
          },
        ),
      )
      ..loadRequest(
        Uri.parse(widget.setupUrl),
        headers: {
          'Accept':
              'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
          'Accept-Language': 'en-US,en;q=0.9',
        },
      );
  }

  void _trackUrlFlow(String url) {
    // Track if we've seen the sign-in page
    if (url.contains('idmsa.apple.com/IDMSWebAuth/signin')) {
      debugPrint('📝 Sign-in page detected - user needs to authenticate');
      _hasSeenSignIn = true;
    }

    // Track onboarding page visits
    if (url.contains('businessconnect.apple.com/onboarding')) {
      _onboardingVisitCount++;

      if (!_hasSeenOnboarding) {
        _hasSeenOnboarding = true;
        _firstOnboardingTime = DateTime.now();
        debugPrint('📊 First onboarding page visit');
      } else {
        debugPrint('📊 Onboarding page visit count: $_onboardingVisitCount');
      }

      // Success scenario 1: User completed login and returned to onboarding
      // (We've seen sign-in AND this is the second visit to onboarding)
      if (_hasSeenSignIn && _onboardingVisitCount >= 2) {
        _handleSetupSuccess(
            'Completed authentication and returned to onboarding');
        return;
      }

      // Success scenario 2: Already authenticated user
      // (First onboarding visit, no sign-in seen, and page has loaded)
      // We'll confirm this in onPageFinished with a delay
    }

    // Check for explicit success URLs
    if (url.contains('taptopay') ||
        url.contains('link-brand') ||
        (url.contains('/companies/') && url.contains('taptopay'))) {
      _handleSetupSuccess('Success URL detected: taptopay/link-brand');
    }
  }

  void _checkIfSetupComplete(String url) {
    // After page finishes loading on the onboarding page
    if (url.contains('businessconnect.apple.com/onboarding')) {
      // If we've seen the onboarding page but haven't seen sign-in yet,
      // wait to confirm we're not being redirected to sign-in
      if (_hasSeenOnboarding && !_hasSeenSignIn && !_setupCompleted) {
        // Wait 5 seconds to see if we get redirected to sign-in
        // Apple can redirect after the page loads, not during navigation
        Future.delayed(Duration(seconds: 5), () {
          if (!_hasSeenSignIn && !_setupCompleted && mounted) {
            debugPrint(
                '✅ User confirmed as already authenticated (no sign-in redirect after 5s)');
            _handleSetupSuccess('Already authenticated - no sign-in required');
          } else if (_hasSeenSignIn) {
            debugPrint(
                '🔄 Sign-in redirect detected - waiting for user to authenticate');
          }
        });
      }
    }
  }

  void _handleSetupSuccess(String reason) {
    if (_setupCompleted) return;

    debugPrint('✅ Setup successful: $reason');
    _setupCompleted = true;

    Future.delayed(Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pop(context, {
          'success': true,
          'wasAlreadyAuthenticated': !_hasSeenSignIn,
          'reason': reason,
          'visitCount': _onboardingVisitCount,
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryText,
        title: Text('Account Setup'),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context, {
              'success': _setupCompleted,
              'cancelled': !_setupCompleted,
              'wasAlreadyAuthenticated': !_hasSeenSignIn,
              'visitCount': _onboardingVisitCount,
            });
          },
        ),
      ),
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const SizedBox(
                height: 200,
                child: Center(
                    child: CircularProgressIndicator(color: Colors.black)))
        ],
      ),
    );
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:g_e_t_i_n_scanner/flutter_flow/flutter_flow_util.dart';
import '../../app_state.dart';
import '../../flutter_flow/flutter_flow_theme.dart';

class SplashSettingWidget extends StatefulWidget {
  const SplashSettingWidget({super.key});

  static String routeName = 'SplashSetting';
  static String routePath = '/SplashSetting';
  @override
  State<SplashSettingWidget> createState() => _SplashSettingWidgetState();
}

class _SplashSettingWidgetState extends State<SplashSettingWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool skipSplash = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leadingWidth: 80,
        leading:GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(9),
            child: Container(
              height: 35,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(217, 217, 217, 0.2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 20,
                    spreadRadius: 0,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 20,

                  ),
                ),
              ),
            ),
          ),
        ),

        centerTitle: true,
        title: Text(
          'SPLASH SCREEN',
          style: FlutterFlowTheme.of(context).bodyMedium.override(
            fontFamily: 'Mona Sans',
            color: Colors.white,
            letterSpacing: 0.64,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(
                sigmaX: 150,
                sigmaY: 150,
              ),
              child: Container(
                width: 267,
                height: 267,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Color(0xFFFF4C00).withOpacity(0.8), // #FF4C00 with 0.8 opacity
                      Color(0xFFFF281B).withOpacity(0.0), // #FF281B fully transparent
                    ],
                    radius: 0.8,
                  ),
                ),
              ),
            ),
          ),

          /// Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Text Section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Skip the splash screen?',
                        style: FlutterFlowTheme.of(context).bodyLarge.override(
                          fontFamily: 'Mona Sans',
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Instantly jump into the app without waiting.\n'
                                'Enable this option to bypass the splash\n'
                                'screen and get straight to what you need.',
                            style: FlutterFlowTheme.of(context).bodySmall.override(
                              fontFamily: 'Mona Sans',
                              fontSize: 14,
                              color: FlutterFlowTheme.of(context).secondaryGrey,
                            ),
                          ),
                          SizedBox(
                            height: 28,
                            width: 52,
                            child: Switch(
                              value: FFAppState().splashScreenStatus == 'Enabled',
                              onChanged: (value) {
                                safeSetState(() {
                                  FFAppState().splashScreenStatus =
                                  value ? 'Enabled' : 'Disabled';
                                });
                              },
                              trackOutlineColor: MaterialStateProperty.all(Colors.transparent),
                              activeThumbColor: Colors.white,
                              inactiveThumbColor: Color.fromRGBO(255, 255, 255, 1),
                              activeTrackColor: FlutterFlowTheme.of(context).primary,
                              inactiveTrackColor: FlutterFlowTheme.of(context).naturalLight,
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                ),

                /// Switch
              ],
            ),
          ),
        ],
      ),
    );
  }
}

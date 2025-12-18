import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:g_e_t_i_n_scanner/flutter_flow/flutter_flow_theme.dart';
import 'package:g_e_t_i_n_scanner/flutter_flow/flutter_flow_widgets.dart'
    show FFButtonOptions, FFButtonWidget;

class FeatureDisabledPage extends StatelessWidget {
  final String? message;

  static String routeName = 'FeatureDisabled';
  static String routePath = '/feature_disabled:message';

  const FeatureDisabledPage({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Warning icon
                SvgPicture.asset(
                  'assets/svg/warning.svg',
                  width: 64,
                  height: 64,
                ),
                const SizedBox(height: 24),

                // Title text
                Text(
                  message ??
                      "This feature is currently disabled for your account.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),

                // Subtitle text
                if (message == null)
                  const Text(
                    "If you believe this is an error, please contact our Customer Support team for assistance.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: FFButtonWidget(
                        text: 'OK',
                        onPressed: () {
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   const SnackBar(
                          //     content: Text('Contact Support pressed'),
                          //     backgroundColor: Colors.red,
                          //   ),
                          // );
                          Navigator.pop(context);
                        },
                        showLoadingIndicator: true,
                        options: FFButtonOptions(
                          height: 40.0,
                          color: FlutterFlowTheme.of(context).secondary,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'Mona Sans',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    fontSize: 18.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                          elevation: 0.0,
                        ),
                      ),
                    ),
                  ],
                ),
                // Row(
                //   children: [
                //     Expanded(
                //       child: FFButtonWidget(
                //         text: 'CONTACT SUPPORT',
                //         onPressed: () {
                //           ScaffoldMessenger.of(context).showSnackBar(
                //             const SnackBar(
                //               content: Text('Contact Support pressed'),
                //               backgroundColor: Colors.red,
                //             ),
                //           );
                //           Navigator.pop(context);
                //         },
                //         showLoadingIndicator: true,
                //         options: FFButtonOptions(
                //           height: 40.0,
                //           color: FlutterFlowTheme.of(context).secondary,
                //           textStyle:
                //               FlutterFlowTheme.of(context).titleSmall.override(
                //                     fontFamily: 'Mona Sans',
                //                     color: FlutterFlowTheme.of(context)
                //                         .primaryBackground,
                //                     fontSize: 18.0,
                //                     letterSpacing: 0.0,
                //                     fontWeight: FontWeight.normal,
                //                   ),
                //           elevation: 0.0,
                //           borderRadius: BorderRadius.circular(10.0),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

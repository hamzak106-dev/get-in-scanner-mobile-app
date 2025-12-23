import 'package:flutter/material.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '../../custom_code/actions/resolve_profile_image.dart'
    show resolveProfileImage;
import 'header_card_for_tap_to_pay_model.dart';

export 'header_card_for_tap_to_pay_model.dart';

class HeaderCardForTapToPayWidget extends StatefulWidget {
  final Function(int)? onButtonChanged;

  const HeaderCardForTapToPayWidget({super.key, this.onButtonChanged});

  @override
  State<HeaderCardForTapToPayWidget> createState() =>
      _HeaderCardForTapToPayWidgetState();
}

class _HeaderCardForTapToPayWidgetState
    extends State<HeaderCardForTapToPayWidget> {
  late HeaderCardForTapToPayModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HeaderCardForTapToPayModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF27272D), Color(0xFF0E0F11)],
              stops: [0.0, 1.0],
              begin: AlignmentDirectional(0.0, -1.0),
              end: AlignmentDirectional(0, 1.0),
            ),
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(
              color: Color(0xFF27272D),
            ),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 12.0, 12.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: FFAppState().user.user.profileImg.isNotEmpty
                      ? Image.network(
                          valueOrDefault(
                              resolveProfileImage(
                                  FFAppState().user.user.profileImg),
                              'https://picsum.photos/seed/200/600'),
                          width: 48.0,
                          height: 48.0,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/images/image_place_holder.png',
                          width: 48.0,
                          height: 48.0,
                          fit: BoxFit.cover,
                        ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Welcome Back',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Mona Sans',
                            letterSpacing: 0.0,
                          ),
                    ),
                    Text(
                      '${valueOrDefault(FFAppState().user.user.firstName, '')} ${valueOrDefault(FFAppState().user.user.lastName, '')}',
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Mona Sans',
                            fontSize: 22.0,
                            letterSpacing: 0.0,
                          ),
                    ),
                  ],
                ),
                Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: Stack(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: FFButtonWidget(
                                onPressed: () {
                                  print('Button pressed ...');
                                  widget.onButtonChanged?.call(0);
                                  safeSetState(() {
                                    _model.selectedButtonIndex = 0;
                                  });
                                },
                                text: 'Quick Pay',
                                options: FFButtonOptions(
                                  height: 40.0,
                                  // padding: EdgeInsetsDirectional.fromSTEB(
                                  //     16.0, 0.0, 16.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: _model.selectedButtonIndex == 0
                                      ? FlutterFlowTheme.of(context).secondary
                                      : Color(0x00FF281B),
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: 'Mona Sans',
                                        color: _model.selectedButtonIndex == 0
                                            ? FlutterFlowTheme.of(context)
                                                .primaryBackground
                                            : Color(0xFFB5B6BA),
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  elevation: 0.0,
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                              ),
                            ),
                            Expanded(
                              child: FFButtonWidget(
                                onPressed: () {
                                  widget.onButtonChanged?.call(1);
                                  safeSetState(() {
                                    _model.selectedButtonIndex = 1;
                                  });
                                },
                                text: 'By Event',
                                options: FFButtonOptions(
                                  height: 40.0,
                                  // padding: EdgeInsetsDirectional.fromSTEB(
                                  //     16.0, 0.0, 16.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: _model.selectedButtonIndex == 1
                                      ? FlutterFlowTheme.of(context).secondary
                                      : Color(0x00FF281B),
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: 'Mona Sans',
                                        color: _model.selectedButtonIndex == 1
                                            ? FlutterFlowTheme.of(context)
                                                .primaryBackground
                                            : Color(0xFFB5B6BA),
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  elevation: 0.0,
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                              ),
                            ),
                            Expanded(
                              child: FFButtonWidget(
                                onPressed: () {
                                  print('Button pressed ...');
                                  widget.onButtonChanged?.call(2);
                                  safeSetState(() {
                                    _model.selectedButtonIndex = 2;
                                  });
                                },
                                text: 'Activity',
                                options: FFButtonOptions(
                                  height: 40.0,
                                  // padding: EdgeInsetsDirectional.fromSTEB(
                                  //     16.0, 0.0, 16.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: _model.selectedButtonIndex == 2
                                      ? FlutterFlowTheme.of(context).secondary
                                      : Color(0x00FF281B),
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: 'Mona Sans',
                                        color: _model.selectedButtonIndex == 2
                                            ? FlutterFlowTheme.of(context)
                                                .primaryBackground
                                            : Color(0xFFB5B6BA),
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  elevation: 0.0,
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                              ),
                            ),
                          ].divide(SizedBox(width: 4.0)),
                        ),
                        Positioned.fill(
                            child: Container(
                          color: Colors.transparent,
                        ))
                      ],
                    ),
                  ),
                ),
              ].divide(SizedBox(height: 8.0)),
            ),
          ),
        ),
      ],
    );
  }
}

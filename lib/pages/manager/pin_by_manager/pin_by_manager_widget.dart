import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/components/dialogs/info_dialog/info_dialog_widget.dart';
import '/components/event_card_for_scanner/event_card_for_scanner_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'pin_by_manager_model.dart';
export 'pin_by_manager_model.dart';

class PinByManagerWidget extends StatefulWidget {
  const PinByManagerWidget({
    super.key,
    required this.eventId,
    required this.producerId,
  });

  final int? eventId;
  final int? producerId;

  static String routeName = 'PinByManager';
  static String routePath = '/pinByManager';

  @override
  State<PinByManagerWidget> createState() => _PinByManagerWidgetState();
}

class _PinByManagerWidgetState extends State<PinByManagerWidget> {
  late PinByManagerModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PinByManagerModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'PinByManager'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('PIN_BY_MANAGER_PinByManager_ON_INIT_STAT');
      _model.producer = await CreatorsTable().queryRows(
        queryFn: (q) => q.eqOrNull(
          'user_id',
          widget.producerId,
        ),
      );
      _model.dbEvent = await EventsTable().queryRows(
        queryFn: (q) => q.eqOrNull(
          'event_id',
          widget.eventId,
        ),
      );
      _model.pins = await PinTable().queryRows(
        queryFn: (q) => q
            .eqOrNull(
              'user_id',
              widget.producerId,
            )
            .eqOrNull(
              'type',
              PinType.SYSTEM.name,
            ),
      );
      _model.event = _model.dbEvent?.firstOrNull;
      _model.eventCreator = _model.producer?.firstOrNull;
      _model.isLoading = false;
      _model.producerPin = _model.pins?.firstOrNull;
      safeSetState(() {});
    });

    _model.codeInfoTextFieldTextController ??= TextEditingController();
    _model.codeInfoTextFieldFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Container(
            decoration: BoxDecoration(),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20.0, 44.0, 20.0, 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Text(
                      'Confirm producer and Event',
                      style: FlutterFlowTheme.of(context).titleSmall.override(
                            fontFamily: 'MonaSans',
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                    child: Text(
                      'To generate the pin, please verify the producer associated with the chosen event.',
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'MonaSans',
                            color: Color(0xFF5B5B5B),
                            fontSize: 14.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  Flexible(
                    child: Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Builder(
                        builder: (context) {
                          if (!_model.isLoading) {
                            return SingleChildScrollView(
                              primary: false,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  if (_model.eventCreator != null)
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        custom_widgets.ProfilePicWidget(
                                          width: 60.0,
                                          height: 60.0,
                                          profileImg: _model.eventCreator?.profileImg,
                                        ),
                                        if (_model.eventCreator?.name != null && _model.eventCreator?.name != '')
                                          Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                                            child: Text(
                                              valueOrDefault<String>(
                                                _model.eventCreator?.name,
                                                '-',
                                              ),
                                              style: FlutterFlowTheme.of(context).headlineSmall.override(
                                                    fontFamily: 'MonaSans',
                                                    color: Colors.white,
                                                    fontSize: 16.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                    lineHeight: 1.5,
                                                  ),
                                            ),
                                          ),
                                        if ((_model.eventCreator?.followerCounter != null) &&
                                            (_model.eventCreator!.followerCounter! > 0))
                                          Text(
                                            '${formatNumber(
                                              _model.eventCreator?.followerCounter,
                                              formatType: FormatType.compact,
                                            )} Followers',
                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                  fontFamily: 'MonaSans',
                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.0,
                                                  lineHeight: 1.42,
                                                ),
                                          ),
                                      ],
                                    ),
                                  if (_model.event != null)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                                      child: wrapWithModel(
                                        model: _model.eventCardForScannerModel,
                                        updateCallback: () => safeSetState(() {}),
                                        child: EventCardForScannerWidget(
                                          event: _model.event!,
                                          onTap: () async {},
                                        ),
                                      ),
                                    ),
                                  Align(
                                    alignment: AlignmentDirectional(1.0, 0.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                                      child: Stack(
                                        alignment: AlignmentDirectional(1.0, 0.0),
                                        children: [
                                          TextFormField(
                                            controller: _model.codeInfoTextFieldTextController,
                                            focusNode: _model.codeInfoTextFieldFocusNode,
                                            autofocus: false,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              isDense: false,
                                              hintText: 'Pin',
                                              hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                    fontFamily: 'MonaSans',
                                                    letterSpacing: 0.0,
                                                  ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(context).tertiary,
                                                  width: 1.0,
                                                ),
                                                borderRadius: BorderRadius.circular(50.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 1.0,
                                                ),
                                                borderRadius: BorderRadius.circular(50.0),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(context).error,
                                                  width: 1.0,
                                                ),
                                                borderRadius: BorderRadius.circular(50.0),
                                              ),
                                              focusedErrorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(context).error,
                                                  width: 1.0,
                                                ),
                                                borderRadius: BorderRadius.circular(50.0),
                                              ),
                                              filled: true,
                                              fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                              contentPadding: EdgeInsets.all(8.0),
                                              prefixIcon: Icon(
                                                FFIcons.kicPassword,
                                                color: FlutterFlowTheme.of(context).primaryText,
                                                size: 16.0,
                                              ),
                                            ),
                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                  fontFamily: 'MonaSans',
                                                  letterSpacing: 0.0,
                                                ),
                                            maxLength: 4,
                                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                                            buildCounter: (context,
                                                    {required currentLength, required isFocused, maxLength}) =>
                                                null,
                                            keyboardType: TextInputType.phone,
                                            cursorColor: FlutterFlowTheme.of(context).primaryText,
                                            validator:
                                                _model.codeInfoTextFieldTextControllerValidator.asValidator(context),
                                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
                                          ),
                                          Builder(
                                            builder: (context) => Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 16.0, 0.0),
                                              child: FFButtonWidget(
                                                onPressed: () async {
                                                  logFirebaseEvent('PIN_BY_MANAGER_PAGE_GENERATE_BTN_ON_TAP');
                                                  if (_model.codeInfoTextFieldTextController.text != '') {
                                                    _model.existingPins = await PinTable().queryRows(
                                                      queryFn: (q) => q
                                                          .eqOrNull(
                                                            'access_code',
                                                            _model.producerPin?.accessCode,
                                                          )
                                                          .eqOrNull(
                                                            'pin',
                                                            int.tryParse(_model.codeInfoTextFieldTextController.text),
                                                          ),
                                                    );
                                                    if (_model.existingPins != null &&
                                                        (_model.existingPins)!.isNotEmpty) {
                                                      await showDialog(
                                                        context: context,
                                                        builder: (dialogContext) {
                                                          return Dialog(
                                                            elevation: 0,
                                                            insetPadding: EdgeInsets.zero,
                                                            backgroundColor: Colors.transparent,
                                                            alignment: AlignmentDirectional(0.0, 0.0)
                                                                .resolve(Directionality.of(context)),
                                                            child: GestureDetector(
                                                              onTap: () {
                                                                FocusScope.of(dialogContext).unfocus();
                                                                FocusManager.instance.primaryFocus?.unfocus();
                                                              },
                                                              child: InfoDialogWidget(
                                                                title: 'Pin exists',
                                                                subTitle:
                                                                    'Selected pin already exist, Please choose different one.',
                                                                firstBtnText: 'OK',
                                                                firstBtnColor: FlutterFlowTheme.of(context).accent3,
                                                                isLight: true,
                                                                firstTap: () async {
                                                                  Navigator.pop(context);
                                                                },
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    } else {
                                                      _model.addPinResponse = await PinTable().insert({
                                                        'user_id': _model.producerPin?.userId,
                                                        'access_code': _model.producerPin?.accessCode,
                                                        'pin':
                                                            int.tryParse(_model.codeInfoTextFieldTextController.text),
                                                        'type': PinType.ON_SITE_PIN.name,
                                                        'permissions': functions.getPermissionWithoutAllEvent(),
                                                        'is_enable': true,
                                                        'event_ids': widget.eventId?.toString(),
                                                        'created_by': FFAppState().user.userId,
                                                      });
                                                      context.safePop();
                                                    }
                                                  } else {
                                                    await showDialog(
                                                      context: context,
                                                      builder: (dialogContext) {
                                                        return Dialog(
                                                          elevation: 0,
                                                          insetPadding: EdgeInsets.zero,
                                                          backgroundColor: Colors.transparent,
                                                          alignment: AlignmentDirectional(0.0, 0.0)
                                                              .resolve(Directionality.of(context)),
                                                          child: GestureDetector(
                                                            onTap: () {
                                                              FocusScope.of(dialogContext).unfocus();
                                                              FocusManager.instance.primaryFocus?.unfocus();
                                                            },
                                                            child: InfoDialogWidget(
                                                              title: 'Pin Info Alert',
                                                              subTitle: 'Enter the code to continue.',
                                                              firstBtnText: 'OK',
                                                              firstBtnColor: FlutterFlowTheme.of(context).accent3,
                                                              isLight: true,
                                                              firstTap: () async {
                                                                Navigator.pop(context);
                                                              },
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  }

                                                  safeSetState(() {});
                                                },
                                                text: 'Generate',
                                                options: FFButtonOptions(
                                                  height: 32.0,
                                                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                                  iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                  color: FlutterFlowTheme.of(context).secondary,
                                                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                        fontFamily: 'MonaSans',
                                                        color: FlutterFlowTheme.of(context).primaryBackground,
                                                        fontSize: 14.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight: FontWeight.normal,
                                                      ),
                                                  elevation: 0.0,
                                                  borderRadius: BorderRadius.circular(24.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                                    child: Text(
                                      'A 4 Digit generated pin used to confirm your identity.',
                                      style: FlutterFlowTheme.of(context).bodySmall.override(
                                            fontFamily: 'MonaSans',
                                            color: Color(0xFFB5B6BA),
                                            fontSize: 12.0,
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Container(
                              width: 40.0,
                              height: 40.0,
                              child: custom_widgets.Loader(
                                width: 40.0,
                                height: 40.0,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  FFButtonWidget(
                    onPressed: () async {
                      logFirebaseEvent('PIN_BY_MANAGER_PAGE_BACK_BTN_ON_TAP');
                      context.safePop();
                    },
                    text: 'Back',
                    icon: Icon(
                      FFIcons.kicArrowBack,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 16.0,
                    ),
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 52.0,
                      padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      iconAlignment: IconAlignment.start,
                      iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                            fontFamily: 'MonaSans',
                            color: FlutterFlowTheme.of(context).primaryText,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.normal,
                          ),
                      elevation: 0.0,
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                ].divide(SizedBox(height: 20.0)).addToEnd(SizedBox(height: 12.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

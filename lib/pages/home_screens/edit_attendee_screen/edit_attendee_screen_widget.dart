import '/backend/supabase/supabase.dart';
import '/components/dialogs/info_dialog/info_dialog_widget.dart';
import '/components/label_text_field/label_text_field_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'edit_attendee_screen_model.dart';
export 'edit_attendee_screen_model.dart';

class EditAttendeeScreenWidget extends StatefulWidget {
  const EditAttendeeScreenWidget({
    super.key,
    required this.attendee,
  });

  final AttendeeRow? attendee;

  static String routeName = 'EditAttendeeScreen';
  static String routePath = '/editAttendeeScreen';

  @override
  State<EditAttendeeScreenWidget> createState() =>
      _EditAttendeeScreenWidgetState();
}

class _EditAttendeeScreenWidgetState extends State<EditAttendeeScreenWidget> {
  late EditAttendeeScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditAttendeeScreenModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'EditAttendeeScreen'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('EDIT_ATTENDEE_SCREEN_EditAttendeeScreen_');
      _model.phoneNumber = widget.attendee?.phone;
      safeSetState(() {});
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    FlutterFlowIconButton(
                      borderColor: Colors.transparent,
                      borderRadius: 30.0,
                      buttonSize: 40.0,
                      icon: Icon(
                        FFIcons.kicArrowBack,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 24.0,
                      ),
                      onPressed: () async {
                        logFirebaseEvent(
                            'EDIT_ATTENDEE_SCREEN_icArrowBack_ICN_ON_');
                        context.safePop();
                      },
                    ),
                    Expanded(
                      child: Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Text(
                          'Edit Attendee',
                          style:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'MonaSans',
                                    letterSpacing: 0.0,
                                  ),
                        ),
                      ),
                    ),
                  ].addToEnd(SizedBox(width: 40.0)),
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        wrapWithModel(
                          model: _model.fNameLabelTextFieldModel,
                          updateCallback: () => safeSetState(() {}),
                          child: LabelTextFieldWidget(
                            initialValue: (String name) {
                              return name.split(" ").first;
                            }(widget.attendee!.name!),
                            title: 'First Name',
                            icon: Icon(
                              FFIcons.kicOutlineUser,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 16.0,
                            ),
                            readOnly: false,
                          ),
                        ),
                        wrapWithModel(
                          model: _model.lNameLabelTextFieldModel,
                          updateCallback: () => safeSetState(() {}),
                          child: LabelTextFieldWidget(
                            initialValue: (String name) {
                              return name.split(" ").skip(1).join(" ");
                            }(widget.attendee!.name!),
                            title: 'Last Name',
                            icon: Icon(
                              FFIcons.kicOutlineUser,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 16.0,
                            ),
                            readOnly: false,
                          ),
                        ),
                        wrapWithModel(
                          model: _model.emailLabelTextFieldModel,
                          updateCallback: () => safeSetState(() {}),
                          child: LabelTextFieldWidget(
                            initialValue: widget.attendee?.email,
                            title: 'Email',
                            icon: Icon(
                              FFIcons.kicMail,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 16.0,
                            ),
                            readOnly: false,
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  FFIcons.kicMobile,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                                Text(
                                  'Phone',
                                  style: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: 'MonaSans',
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ].divide(SizedBox(width: 8.0)),
                            ),
                            custom_widgets.MobileNumberTextFieldWidget(
                              width: double.infinity,
                              height: 60.0,
                              hintText: 'Phone number',
                              onChange:
                                  (countryCode, phoneNumber, dialCode) async {
                                logFirebaseEvent(
                                    'EDIT_ATTENDEE_SCREEN_Container_21d65mla_');
                                _model.phoneNumber = phoneNumber;
                                _model.countryCode = countryCode;
                                _model.dialCode = dialCode;
                                safeSetState(() {});
                              },
                            ),
                          ].divide(SizedBox(height: 10.0)),
                        ),
                      ].divide(SizedBox(height: 24.0)),
                    ),
                  ),
                ),
              ),
              Builder(
                builder: (context) => Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 20.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      logFirebaseEvent('EDIT_ATTENDEE_SCREEN_SAVE_BTN_ON_TAP');
                      if (_model.fNameLabelTextFieldModel.textController.text ==
                              '') {
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
                                  title: 'Error',
                                  subTitle: 'First Name cannot be empty.',
                                  firstBtnText: 'OK',
                                  firstBtnColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  firstTap: () async {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      } else if (_model.emailLabelTextFieldModel.textController.text ==
                              '') {
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
                                  title: 'Error',
                                  subTitle: 'Email cannot be empty.',
                                  firstBtnText: 'OK',
                                  firstBtnColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  firstTap: () async {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      } else if (_model.phoneNumber == null ||
                          _model.phoneNumber == '') {
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
                                  title: 'Error',
                                  subTitle: 'Phone number cannot be empty.',
                                  firstBtnText: 'OK',
                                  firstBtnColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  firstTap: () async {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        _model.updateDetailsResp = await AttendeeTable().update(
                          data: {
                            'name':
                                '${_model.fNameLabelTextFieldModel.textController.text} ${_model.lNameLabelTextFieldModel.textController.text}',
                            'email': _model
                                .emailLabelTextFieldModel.textController.text,
                            'phone':
                                '${_model.countryCode}${_model.phoneNumber}',
                          },
                          matchingRows: (rows) => rows.eqOrNull(
                            'purchase_id',
                            widget.attendee?.purchaseId,
                          ),
                          returnRows: true,
                        );
                        if (_model.updateDetailsResp != null &&
                            (_model.updateDetailsResp)!.isNotEmpty) {
                          context.safePop();
                        }
                      }

                      safeSetState(() {});
                    },
                    text: 'Save',
                    icon: Icon(
                      FFIcons.kicCheck,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 24.0,
                    ),
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 60.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).tertiary,
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'MonaSans',
                                color: FlutterFlowTheme.of(context).primaryText,
                                fontSize: 16.0,
                                letterSpacing: 0.0,
                              ),
                      elevation: 0.0,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ].divide(SizedBox(height: 8.0)),
          ),
        ),
      ),
    );
  }
}

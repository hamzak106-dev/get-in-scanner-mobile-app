import '/backend/supabase/supabase.dart';
import '/components/attendee_detail_tile/attendee_detail_tile_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'ticket_comment_screen_model.dart';
export 'ticket_comment_screen_model.dart';

class TicketCommentScreenWidget extends StatefulWidget {
  const TicketCommentScreenWidget({
    super.key,
    required this.attendee,
    bool? isRemark,
  }) : this.isRemark = isRemark ?? false;

  final AttendeeRow? attendee;
  final bool isRemark;

  static String routeName = 'TicketCommentScreen';
  static String routePath = '/ticketCommentScreen';

  @override
  State<TicketCommentScreenWidget> createState() =>
      _TicketCommentScreenWidgetState();
}

class _TicketCommentScreenWidgetState extends State<TicketCommentScreenWidget> {
  late TicketCommentScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TicketCommentScreenModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'TicketCommentScreen'});
    _model.commentTextFieldTextController ??=
        TextEditingController(text: widget.attendee?.remark);
    _model.commentTextFieldFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        top: true,
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      logFirebaseEvent(
                          'TICKET_COMMENT_SCREEN_Icon_vyssgu74_ON_T');
                      context.safePop();
                    },
                    child: Icon(
                      FFIcons.kicArrowBack,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      size: 30.0,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      'Attendee  |  ${widget.isRemark ? 'Remarks' : 'Ticket Comment'}',
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                            fontFamily: 'MonaSans',
                            color: FlutterFlowTheme.of(context).secondaryText,
                            fontSize: 14.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                  ),
                ].divide(SizedBox(width: 6.0)),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        valueOrDefault<String>(
                          widget.attendee?.name,
                          '-',
                        ),
                        style: FlutterFlowTheme.of(context).bodyLarge.override(
                              fontFamily: 'MonaSans',
                              fontSize: 22.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      Builder(
                        builder: (context) {
                          if (widget.isRemark) {
                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                wrapWithModel(
                                  model: _model.attendeeDetailTileModel1,
                                  updateCallback: () => safeSetState(() {}),
                                  child: AttendeeDetailTileWidget(
                                    icon: Icon(
                                      FFIcons.kicOutlineReceipt,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 16.0,
                                    ),
                                    title: 'Remarks',
                                    endLable: '',
                                    isEndBold: false,
                                    onTap: () async {},
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                  child: TextFormField(
                                    controller:
                                        _model.commentTextFieldTextController,
                                    focusNode: _model.commentTextFieldFocusNode,
                                    autofocus: false,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily: 'MonaSans',
                                            color: Color(0xCCFFFFFF),
                                            letterSpacing: 0.4,
                                          ),
                                      hintText: 'Add your remarks in here.',
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily: 'MonaSans',
                                            letterSpacing: 0.4,
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .tertiary,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .tertiary,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      filled: true,
                                      fillColor: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      contentPadding: EdgeInsets.all(16.0),
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'MonaSans',
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0.4,
                                        ),
                                    textAlign: TextAlign.start,
                                    maxLines: 7,
                                    minLines: 5,
                                    maxLength: 128,
                                    cursorColor: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    validator: _model
                                        .commentTextFieldTextControllerValidator
                                        .asValidator(context),
                                  ),
                                ),
                              ].divide(SizedBox(height: 8.0)),
                            );
                          } else {
                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                wrapWithModel(
                                  model: _model.attendeeDetailTileModel2,
                                  updateCallback: () => safeSetState(() {}),
                                  child: AttendeeDetailTileWidget(
                                    icon: Icon(
                                      FFIcons.kicChat,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 16.0,
                                    ),
                                    title: 'Ticket Comment',
                                    endLable: '',
                                    isEndBold: false,
                                    onTap: () async {},
                                  ),
                                ),
                                Text(
                                  '“${widget.attendee?.ticketComment}”',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'MonaSans',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ].divide(SizedBox(height: 16.0)),
                            );
                          }
                        },
                      ),
                    ].divide(SizedBox(height: 30.0)),
                  ),
                ),
              ),
              if (widget.isRemark)
                Container(
                  decoration: BoxDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FFButtonWidget(
                        onPressed: () async {
                          logFirebaseEvent(
                              'TICKET_COMMENT_SCREEN_SAVE_BTN_ON_TAP');
                          await AttendeeTable().update(
                            data: {
                              'remark': _model
                                  .commentTextFieldTextController.text
                                  .trim(),
                            },
                            matchingRows: (rows) => rows.eqOrNull(
                              'uid',
                              widget.attendee?.uid,
                            ),
                          );
                          context.safePop();

                          safeSetState(() {});
                        },
                        text: 'Save',
                        icon: Icon(
                          FFIcons.kicCheck,
                          size: 15.0,
                        ),
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 60.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).secondary,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'MonaSans',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                  ),
                          elevation: 0.0,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      FFButtonWidget(
                        onPressed: () async {
                          logFirebaseEvent(
                              'TICKET_COMMENT_SCREEN_DELETE_BTN_ON_TAP');
                          await AttendeeTable().update(
                            data: {
                              'remark': null,
                            },
                            matchingRows: (rows) => rows.eqOrNull(
                              'uid',
                              widget.attendee?.uid,
                            ),
                          );
                          context.safePop();

                          safeSetState(() {});
                        },
                        text: 'Delete',
                        icon: Icon(
                          FFIcons.kicDelete,
                          size: 15.0,
                        ),
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 60.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).error,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'MonaSans',
                                    color: Colors.white,
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                  ),
                          elevation: 0.0,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ].divide(SizedBox(height: 24.0)),
                  ),
                ),
            ].divide(SizedBox(height: 26.0)),
          ),
        ),
      ),
    );
  }
}

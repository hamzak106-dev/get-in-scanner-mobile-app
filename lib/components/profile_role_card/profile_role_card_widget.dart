import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'profile_role_card_model.dart';
export 'profile_role_card_model.dart';

class ProfileRoleCardWidget extends StatefulWidget {
  const ProfileRoleCardWidget({
    super.key,
    required this.role,
    bool? isSelected,
  }) : this.isSelected = isSelected ?? false;

  final Profile? role;
  final bool isSelected;

  @override
  State<ProfileRoleCardWidget> createState() => _ProfileRoleCardWidgetState();
}

class _ProfileRoleCardWidgetState extends State<ProfileRoleCardWidget> {
  late ProfileRoleCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfileRoleCardModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                () {
                  if (widget.role == Profile.admin) {
                    return '👉';
                  } else if (widget.role == Profile.manager) {
                    return '📋';
                  } else {
                    return '🎭';
                  }
                }(),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'MonaSans',
                      fontSize: 16.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                      lineHeight: 1.5,
                    ),
              ),
              Text(
                () {
                  if (widget.role == Profile.admin) {
                    return 'Administrator';
                  } else if (widget.role == Profile.manager) {
                    return 'Manager';
                  } else {
                    return 'Producer';
                  }
                }(),
                style: FlutterFlowTheme.of(context).titleSmall.override(
                      fontFamily: 'MonaSans',
                      color: widget.isSelected
                          ? FlutterFlowTheme.of(context).primaryBackground
                          : FlutterFlowTheme.of(context).primaryText,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                      lineHeight: 1.5,
                    ),
              ),
            ].divide(SizedBox(width: 10.0)),
          ),
          Text(
            () {
              if (widget.role == Profile.admin) {
                return 'As an Administrator, you manage system settings, users, and overall platform configurations.';
              } else if (widget.role == Profile.manager) {
                return 'Managers oversee event planning, coordinating logistics, staff, and operations to ensure smooth execution.';
              } else {
                return 'Producers organize and manage events while gathering insights from attendee data to enhance future experiences.';
              }
            }(),
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'MonaSans',
                  color: Color(0xFF6B6D75),
                  fontSize: 12.0,
                  letterSpacing: 0.0,
                  lineHeight: 1.5,
                ),
          ),
        ].divide(SizedBox(height: 8.0)),
      ),
    );
  }
}

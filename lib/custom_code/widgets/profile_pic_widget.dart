// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class ProfilePicWidget extends StatefulWidget {
  const ProfilePicWidget({
    super.key,
    this.width,
    this.height,
    this.profileImg,
  });

  final double? width;
  final double? height;
  final String? profileImg;

  @override
  State<ProfilePicWidget> createState() => _ProfilePicWidgetState();
}

class _ProfilePicWidgetState extends State<ProfilePicWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(1.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.width ?? 60),
        child: Image.network(
          '${getRemoteConfigString('ImageBaseUrl')}/profile/${widget.profileImg}',
          width: widget.width ?? 60,
          height: widget.height ?? 60,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Image.asset(
            'assets/images/error_image.png',
            width: widget.width ?? 60,
            height: widget.height ?? 60,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
// Imports other custom widgets
// Imports custom actions
// Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/flutter_flow/flutter_flow_icon_button.dart';

class FilterPopUp extends StatefulWidget {
  const FilterPopUp({
    super.key,
    this.width,
    this.height,
    required this.onChange,
  });

  final double? width;
  final double? height;
  final Future Function(int? value) onChange;

  @override
  State<FilterPopUp> createState() => _FilterPopUpState();
}

class _FilterPopUpState extends State<FilterPopUp> {
  GlobalKey<PopupMenuButtonState> popUpKey = GlobalKey<PopupMenuButtonState>();

  List<String> filterList = ["A to Z", "Z to A"];

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      key: popUpKey,
      itemBuilder: (context) => List.generate(
        filterList.length,
        (index) => PopupMenuItem(
          onTap: () => widget.onChange(index),
          padding: EdgeInsets.only(left: 10),
          height: 32,
          child: Text(
            filterList[index],
            style: FlutterFlowTheme.of(context).bodySmall.override(
                  fontFamily: 'MonaSans',
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                  useGoogleFonts: false,
                  color: FlutterFlowTheme.of(context).tertiary,
                ),
          ),
        ),
      ),
      color: FlutterFlowTheme.of(context).secondary,
      position: PopupMenuPosition.under,
      padding: EdgeInsets.zero,
      constraints: BoxConstraints(maxWidth: 100),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      tooltip: "Filter",
      child: FlutterFlowIconButton(
        borderColor: Colors.transparent,
        borderRadius: 40.0,
        buttonSize: 40.0,
        fillColor: FlutterFlowTheme.of(context).secondary,
        icon: Icon(
          FFIcons.kicOutlineSort,
          color: FlutterFlowTheme.of(context).tertiary,
          size: 20.0,
        ),
      ),
    );
  }
}

// Automatic FlutterFlow imports
// Imports other custom widgets
// Imports custom actions
// Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class ExpandableScrollViewWidget extends StatefulWidget {
  const ExpandableScrollViewWidget({
    super.key,
    this.width,
    this.height,
    required this.child,
  });

  final double? width;
  final double? height;
  final Widget Function() child;

  @override
  State<ExpandableScrollViewWidget> createState() =>
      _ExpandableScrollViewWidgetState();
}

class _ExpandableScrollViewWidgetState
    extends State<ExpandableScrollViewWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            height: constraints.maxHeight,
            child: widget.child.call(),
          );
        },
      ),
    );
  }
}

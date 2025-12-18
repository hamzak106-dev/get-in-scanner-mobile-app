// Automatic FlutterFlow imports
// Imports other custom widgets
// Imports custom actions
// Imports custom functions
import 'package:flutter/material.dart';

// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class AnimagedPositionWidget extends StatefulWidget {
  const AnimagedPositionWidget({
    super.key,
    this.width,
    this.height,
    required this.child,
    this.isVisible,
  });

  final double? width;
  final double? height;
  final Widget Function() child;
  final bool? isVisible;

  @override
  State<AnimagedPositionWidget> createState() => _AnimagedPositionWidgetState();
}

class _AnimagedPositionWidgetState extends State<AnimagedPositionWidget> {
  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
      top: widget.isVisible ?? false ? 0 : -56,
      // Adjust this value based on your widget height
      left: 0,
      right: 0,
      child: widget.child.call(),
    );
  }
}

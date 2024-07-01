import 'package:flutter/material.dart';
import 'package:qrmenu/core/extension/context_extension.dart';
import 'package:qrmenu/product/utility/zoom_tap_animation.dart';

class CommonElevationButton extends StatelessWidget {
  const CommonElevationButton(
      {super.key, required this.child, required this.onPressed, this.style});
  final Widget child;
  final void Function()? onPressed;
  final ButtonStyle? style;
  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
        child:
            ElevatedButton(style: style, onPressed: onPressed, child: child));
  }
}

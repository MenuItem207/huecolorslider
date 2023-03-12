import 'package:flutter/material.dart';

/// the gradient bar
class ColorGradientBar extends StatelessWidget {
  final Color baseColor;
  final int cellCount;
  final double? height;
  final BorderRadius? borderRadius;

  const ColorGradientBar({
    super.key,
    required this.baseColor,
    this.cellCount = 360,
    this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 20,
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(25),
        gradient: LinearGradient(
          colors: List.generate(
            cellCount,
            (i) {
              double hue = i.toDouble() / cellCount * 360;
              return HSVColor.fromColor(baseColor).withHue(hue).toColor();
            },
          ),
        ),
      ),
    );
  }
}

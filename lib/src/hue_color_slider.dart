import 'package:flutter/material.dart';
import 'package:huecolorslider/src/color_gradient_bar.dart';

/// renders a color slider which varies the hue of the [baseColor]
class HueColorSlider extends StatefulWidget {
  final Color baseColor;
  final Function(Color newColor) onColorChanged;
  final Color? buttonColor;
  final double? height;
  final BorderRadius? borderRadius;

  const HueColorSlider({
    super.key,
    required this.baseColor,
    required this.onColorChanged,
    this.buttonColor,
    this.height,
    this.borderRadius,
  });

  @override
  State<HueColorSlider> createState() => _HueColorSliderState();
}

class _HueColorSliderState extends State<HueColorSlider> {
  double _hue = 0;
  late Color currentColor = widget.baseColor;

  @override
  void initState() {
    super.initState();
    _hue = HSVColor.fromColor(widget.baseColor).hue;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: ColorGradientBar(
            baseColor: widget.baseColor,
            height: widget.height,
            borderRadius: widget.borderRadius,
          ),
        ),
        SliderTheme(
          data: SliderThemeData(
            thumbColor: widget.buttonColor ?? currentColor,
            activeTrackColor: Colors.transparent,
            inactiveTrackColor: Colors.transparent,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 15),
            overlayColor: (widget.buttonColor ?? currentColor).withOpacity(0.2),
          ),
          child: Slider(
            value: _hue,
            min: 0,
            max: 360,
            onChanged: (value) {
              setState(
                () {
                  _hue = value;
                  currentColor =
                      HSVColor.fromColor(currentColor).withHue(_hue).toColor();
                  widget.onColorChanged(currentColor); // update callback
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

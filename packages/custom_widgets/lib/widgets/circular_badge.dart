import 'package:flutter/material.dart';

import '../corporate_design/color.dart';

class CircularBadge extends StatelessWidget {
  const CircularBadge({
    super.key,
    required this.text,
    this.diameter = 18,
    this.backGroundColor = BahagColor.bauhausRed,
    this.textColor = BahagColor.nearlyWhite,
    this.fontSize = 10,
  });
  final String text;
  final double diameter;
  final Color backGroundColor;
  final Color textColor;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: backGroundColor,
      elevation: 0,
      type: MaterialType.circle,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: BahagColor.nearlyWhite),
          shape: BoxShape.circle,
        ),
        width: diameter,
        height: diameter,
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  color: textColor,
                  fontSize: fontSize,
                ),
          ),
        ),
      ),
    );
  }
}

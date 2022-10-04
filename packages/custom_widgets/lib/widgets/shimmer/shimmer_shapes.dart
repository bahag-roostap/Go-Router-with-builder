import 'package:flutter/material.dart';

import 'shimmer.dart';

class ShimmerShapes {
  static Widget rect({
    double? width,
    double? height,
    EdgeInsetsGeometry? margin,
    double borderRadius = 0,
    Color color = const Color(0xFFF5F5F5),
    ShimmerMode mode = ShimmerMode.fade,
  }) {
    if (mode == ShimmerMode.fade) {
      return Shimmer.fromFade(
        color: color,
        period: const Duration(milliseconds: 1000),
        minFadeValue: 0.2,
        child: Container(
          width: width,
          margin: margin,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: Colors.white,
          ),
        ),
      );
    }
    return Shimmer.fromColors(
      baseColor: color,
      highlightColor: Colors.white,
      period: const Duration(milliseconds: 1000),
      minFadeValue: 0.2,
      child: Container(
        width: width,
        margin: margin,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: Colors.white,
        ),
      ),
    );
  }

  static Widget circle({
    required double radius,
    EdgeInsetsGeometry? margin,
    Color color = const Color(0xFFF5F5F5),
    ShimmerMode mode = ShimmerMode.fade,
  }) {
    if (mode == ShimmerMode.fade) {
      return Shimmer.fromFade(
        color: color,
        period: const Duration(milliseconds: 1000),
        minFadeValue: 0.2,
        mode: mode,
        child: Container(
          width: radius,
          height: radius,
          margin: margin,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
        ),
      );
    }
    return Shimmer.fromColors(
      baseColor: color,
      highlightColor: Colors.white,
      period: const Duration(milliseconds: 1000),
      minFadeValue: 0.2,
      mode: mode,
      child: Container(
        width: radius,
        height: radius,
        margin: margin,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
      ),
    );
  }
}

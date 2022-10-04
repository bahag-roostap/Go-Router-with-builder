// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/widgets.dart';
import 'konglomerat_painting.dart';

/// The Flutter logo, in widget form. This widget respects the [IconTheme].
/// For guidelines on using the Flutter logo, visit https://flutter.dev/brand.
///
/// See also:
///
///  * [IconTheme], which provides ambient configuration for icons.
///  * [Icon], for showing icons the Material design icon library.
///  * [ImageIcon], for showing icons from [AssetImage]s or other [ImageProvider]s.
class Konglomerat extends StatelessWidget {
  /// Creates a widget that paints the Flutter logo.
  ///
  /// The [size] defaults to the value given by the current [IconTheme].
  ///
  /// The [textColor], [style], [duration], and [curve] arguments must not be
  /// null.
  const Konglomerat({
    super.key,
    this.size,
    this.textColor = const Color(0xFF757575),
    this.shapeColor = const Color(0xffe2382a),
    this.duration = const Duration(milliseconds: 750),
    this.curve = Curves.fastOutSlowIn,
  });

  /// The size of the logo in logical pixels.
  ///
  /// The logo will be fit into a square this size.
  ///
  /// Defaults to the current [IconTheme] size, if any. If there is no
  /// [IconTheme], or it does not specify an explicit size, then it defaults to
  /// 24.0.
  final double? size;

  final Color textColor;

  final Color shapeColor;

  /// The length of time for the animation if the [style] or [textColor]
  /// properties are changed.
  final Duration duration;

  /// The curve for the logo animation if the [style] or [textColor] change.
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: size,
      height: size,
      duration: duration,
      curve: curve,
      decoration: KonglomeratDecoration(
        textColor: textColor,
        shapeColor: shapeColor,
      ),
    );
  }
}

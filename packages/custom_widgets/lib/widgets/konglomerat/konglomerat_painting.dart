// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Possible ways to draw Flutter's logo.
enum KonglomeratStyle {
  /// Show only Flutter's logo, not the "Flutter" label.
  ///
  /// This is the default behavior for [KonglomeratDecoration] objects.
  markOnly, // 0.0

  // /// Show Flutter's logo on the left, and the "Flutter" label to its right.
  // horizontal, // 1.0

  // /// Show Flutter's logo above the "Flutter" label.
  // stacked, // -1.0
}

/// An immutable description of how to paint Flutter's logo.
class KonglomeratDecoration extends Decoration {
  /// Creates a decoration that knows how to paint Flutter's logo.
  ///
  /// The [style] controls whether and where to draw the "Flutter" label. If one
  /// is shown, the [textColor] controls the color of the label.
  ///
  /// The [textColor], [style], and [margin] arguments must not be null.
  const KonglomeratDecoration({
    this.textColor = const Color(0xFF757575),
    this.shapeColor = const Color(0xffe2382a),
    this.margin = EdgeInsets.zero,
  })  : _position = 0.0,
        _opacity = 1.0;

  const KonglomeratDecoration._(
    this.textColor,
    this.shapeColor,
    this.margin,
    this._position,
    this._opacity,
  );

  /// The color used to paint the "Flutter" text on the logo, if [style] is
  /// [KonglomeratStyle.horizontal] or [KonglomeratStyle.stacked].
  ///
  /// If possible, the default (a medium grey) should be used against a white
  /// background.
  final Color textColor;

  final Color shapeColor;

  /// How far to inset the logo from the edge of the container.
  final EdgeInsets margin;

  // The following are set when lerping, to represent states that can't be
  // represented by the constructor.
  final double _position; // 0.0 for no logo
  final double _opacity; // 0.0 .. 1.0

  bool get _inTransition => _opacity != 1.0 || _position != 0.0;

  @override
  bool debugAssertIsValid() {
    assert(
      _position.isFinite && _opacity >= 0.0 && _opacity <= 1.0,
    );
    return true;
  }

  @override
  bool get isComplex => !_inTransition;

  /// Linearly interpolate between two Flutter logo descriptions.
  ///
  /// Interpolates both the color and the style in a continuous fashion.
  ///
  /// If both values are null, this returns null. Otherwise, it returns a
  /// non-null value. If one of the values is null, then the result is obtained
  /// by scaling the other value's opacity and [margin].
  ///
  /// {@macro dart.ui.shadow.lerp}
  ///
  /// See also:
  ///
  ///  * [Decoration.lerp], which interpolates between arbitrary decorations.
  static KonglomeratDecoration? lerp(
      KonglomeratDecoration? a, KonglomeratDecoration? b, double t) {
    assert(a == null || a.debugAssertIsValid());
    assert(b == null || b.debugAssertIsValid());
    if (a == null && b == null) return null;
    if (a == null) {
      return KonglomeratDecoration._(
        b!.textColor,
        b.shapeColor,
        b.margin * t,
        b._position,
        b._opacity * t.clamp(0.0, 1.0),
      );
    }
    if (b == null) {
      return KonglomeratDecoration._(
        a.textColor,
        a.shapeColor,
        a.margin * t,
        a._position,
        a._opacity * (1.0 - t).clamp(0.0, 1.0),
      );
    }
    if (t == 0.0) return a;
    if (t == 1.0) return b;
    return KonglomeratDecoration._(
      Color.lerp(a.textColor, b.textColor, t)!,
      Color.lerp(a.shapeColor, b.shapeColor, t)!,
      EdgeInsets.lerp(a.margin, b.margin, t)!,
      a._position + (b._position - a._position) * t,
      (a._opacity + (b._opacity - a._opacity) * t).clamp(0.0, 1.0),
    );
  }

  @override
  KonglomeratDecoration? lerpFrom(Decoration? a, double t) {
    assert(debugAssertIsValid());
    if (a == null || a is KonglomeratDecoration) {
      assert(a == null || a.debugAssertIsValid());
      return KonglomeratDecoration.lerp(a as KonglomeratDecoration?, this, t);
    }
    return super.lerpFrom(a, t) as KonglomeratDecoration?;
  }

  @override
  KonglomeratDecoration? lerpTo(Decoration? b, double t) {
    assert(debugAssertIsValid());
    if (b == null || b is KonglomeratDecoration) {
      assert(b == null || b.debugAssertIsValid());
      return KonglomeratDecoration.lerp(this, b as KonglomeratDecoration?, t);
    }
    return super.lerpTo(b, t) as KonglomeratDecoration?;
  }

  @override
  bool hitTest(Size size, Offset position, {TextDirection? textDirection}) =>
      true;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    assert(debugAssertIsValid());
    return _KonglomeratPainter(this);
  }

  @override
  Path getClipPath(Rect rect, TextDirection textDirection) {
    return Path()..addRect(rect);
  }

  @override
  bool operator ==(Object other) {
    assert(debugAssertIsValid());
    if (identical(this, other)) return true;
    return other is KonglomeratDecoration &&
        other.textColor == textColor &&
        other._position == _position &&
        other._opacity == _opacity;
  }

  @override
  int get hashCode {
    assert(debugAssertIsValid());
    return Object.hash(
      textColor,
      _position,
      _opacity,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('textColor', textColor));
    if (_inTransition) {
      properties.add(DiagnosticsNode.message(
          'transition ${debugFormatDouble(_position)}:${debugFormatDouble(_opacity)}'));
    }
  }
}

/// An object that paints a [BoxDecoration] into a canvas.
class _KonglomeratPainter extends BoxPainter {
  _KonglomeratPainter(
    this._config,
  )   : assert(_config.debugAssertIsValid()),
        super(null);

  final KonglomeratDecoration _config;

  // This class contains a lot of magic numbers. They were derived from the
  // values in the SVG files exported from the original artwork source.

  void _paintLogo(Canvas canvas, Rect rect) {
    // Our points are in a coordinate space that's 3606.67 pixels wide and 4583.5 pixels high.
    // First, transform the rectangle so that our coordinate space is a square 4583.5 pixels
    // to a side, with the top left at the origin.
    canvas.save();
    canvas.translate(rect.left, rect.top);
    canvas.scale(rect.width / 4583.5, rect.height / 4583.5);
    // Next, offset it some more so that the 3606.67 horizontal pixels are centered
    // in that square (as opposed to being on the left side of it). This means
    // that if we draw in the rectangle from 0,0 to 3606.67,4583.5, we are drawing in
    // the center of the given rect.
    canvas.translate((4583.5 - 3606.67) / 2.0, 0.0);

    final paint0 = Paint()..color = _config.shapeColor;

    final path0 = Path()
      ..moveTo(0, 2889.44)
      ..lineTo(0, 1748.71)
      ..lineTo(1019.44, 689.1)
      ..lineTo(1563.13, 1255.41)
      ..lineTo(1563.13, 856.5)
      ..lineTo(2386.54, 0)
      ..lineTo(3209.37, 857)
      ..lineTo(3209.37, 1778.59)
      ..lineTo(2037.38, 1778.59)
      ..lineTo(2037.38, 2297.26)
      ..lineTo(2382.83, 1938.23)
      ..lineTo(3606.67, 3212.96)
      ..lineTo(3606.67, 4583.5)
      ..lineTo(1157.11, 4583.5)
      ..lineTo(1157.11, 3212.2)
      ..lineTo(1467.63, 2889.44)
      ..lineTo(0, 2889.44);

    final path1 = Path()
      ..moveTo(1542.89, 4180.5)
      ..lineTo(1542.89, 3382.74)
      ..lineTo(2384.97, 2499.26)
      ..lineTo(3223.15, 3376.66)
      ..lineTo(3223.15, 4180.5)
      ..lineTo(1542.89, 4180.5);

    final path2 = Path()
      ..moveTo(326.97, 2554.25)
      ..lineTo(326.97, 1890.52)
      ..lineTo(1027.14, 1155.73)
      ..lineTo(1724.46, 1890.52)
      ..lineTo(1724.46, 2554.25)
      ..lineTo(326.97, 2554.25);

    final path3 = Path()
      ..moveTo(1820.46, 1507.64)
      ..lineTo(1820.46, 971.14)
      ..lineTo(2387.99, 376.54)
      ..lineTo(2951.51, 967.05)
      ..lineTo(2951.51, 1507.64)
      ..lineTo(1820.46, 1507.64);

    final pathK0 = Path.combine(PathOperation.difference, path0, path1);
    final pathK1 = Path.combine(PathOperation.difference, pathK0, path2);
    final pathK = Path.combine(PathOperation.difference, pathK1, path3);

    canvas.drawPath(pathK, paint0);
    canvas.restore();
  }

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    offset += _config.margin.topLeft;
    final Size canvasSize = _config.margin.deflateSize(configuration.size!);
    if (canvasSize.isEmpty) return;
    const logoSize = Size(4583.5, 4583.5);

    final FittedSizes fittedSize = applyBoxFit(
      BoxFit.contain,
      logoSize,
      canvasSize,
    );
    assert(fittedSize.source == logoSize);

    final double centerSquareHeight = canvasSize.shortestSide;
    final Rect centerSquare = Rect.fromLTWH(
      offset.dx + (canvasSize.width - centerSquareHeight) / 2.0,
      offset.dy + (canvasSize.height - centerSquareHeight) / 2.0,
      centerSquareHeight,
      centerSquareHeight,
    );

    final Rect logoTargetSquare;
    logoTargetSquare = centerSquare;

    final Rect logoSquare =
        Rect.lerp(centerSquare, logoTargetSquare, _config._position.abs())!;

    canvas.saveLayer(
      offset & canvasSize,
      Paint()
        ..colorFilter = ColorFilter.mode(
          const Color(0xFFFFFFFF).withOpacity(_config._opacity),
          BlendMode.modulate,
        ),
    );

    _paintLogo(canvas, logoSquare);
    canvas.restore();
  }
}

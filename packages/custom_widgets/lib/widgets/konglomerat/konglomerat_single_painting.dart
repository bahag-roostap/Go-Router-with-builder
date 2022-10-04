// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Possible ways to draw Flutter's logo.
enum KonglomeratSingleStyle {
  /// Show only Flutter's logo, not the "Flutter" label.
  ///
  /// This is the default behavior for [KonglomeratSingleDecoration] objects.
  markOnly, // 0.0

  // /// Show Flutter's logo on the left, and the "Flutter" label to its right.
  // horizontal, // 1.0

  // /// Show Flutter's logo above the "Flutter" label.
  // stacked, // -1.0
}

/// An immutable description of how to paint Flutter's logo.
class KonglomeratSingleDecoration extends Decoration {
  /// Creates a decoration that knows how to paint Flutter's logo.
  ///
  /// The [style] controls whether and where to draw the "Flutter" label. If one
  /// is shown, the [textColor] controls the color of the label.
  ///
  /// The [textColor], [style], and [margin] arguments must not be null.
  const KonglomeratSingleDecoration({
    this.textColor = const Color(0xFF757575),
    this.margin = EdgeInsets.zero,
  })  : _position = 0.0,
        _opacity = 1.0;

  const KonglomeratSingleDecoration._(
      this.textColor, this.margin, this._position, this._opacity);

  /// The color used to paint the "Flutter" text on the logo, if [style] is
  /// [KonglomeratSingleStyle.horizontal] or [KonglomeratSingleStyle.stacked].
  ///
  /// If possible, the default (a medium grey) should be used against a white
  /// background.
  final Color textColor;

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
  static KonglomeratSingleDecoration? lerp(KonglomeratSingleDecoration? a,
      KonglomeratSingleDecoration? b, double t) {
    assert(a == null || a.debugAssertIsValid());
    assert(b == null || b.debugAssertIsValid());
    if (a == null && b == null) return null;
    if (a == null) {
      return KonglomeratSingleDecoration._(
        b!.textColor,
        b.margin * t,
        b._position,
        b._opacity * t.clamp(0.0, 1.0),
      );
    }
    if (b == null) {
      return KonglomeratSingleDecoration._(
        a.textColor,
        a.margin * t,
        a._position,
        a._opacity * (1.0 - t).clamp(0.0, 1.0),
      );
    }
    if (t == 0.0) return a;
    if (t == 1.0) return b;
    return KonglomeratSingleDecoration._(
      Color.lerp(a.textColor, b.textColor, t)!,
      EdgeInsets.lerp(a.margin, b.margin, t)!,
      a._position + (b._position - a._position) * t,
      (a._opacity + (b._opacity - a._opacity) * t).clamp(0.0, 1.0),
    );
  }

  @override
  KonglomeratSingleDecoration? lerpFrom(Decoration? a, double t) {
    assert(debugAssertIsValid());
    if (a == null || a is KonglomeratSingleDecoration) {
      assert(a == null || a.debugAssertIsValid());
      return KonglomeratSingleDecoration.lerp(
          a as KonglomeratSingleDecoration?, this, t);
    }
    return super.lerpFrom(a, t) as KonglomeratSingleDecoration?;
  }

  @override
  KonglomeratSingleDecoration? lerpTo(Decoration? b, double t) {
    assert(debugAssertIsValid());
    if (b == null || b is KonglomeratSingleDecoration) {
      assert(b == null || b.debugAssertIsValid());
      return KonglomeratSingleDecoration.lerp(
          this, b as KonglomeratSingleDecoration?, t);
    }
    return super.lerpTo(b, t) as KonglomeratSingleDecoration?;
  }

  @override
  bool hitTest(Size size, Offset position, {TextDirection? textDirection}) =>
      true;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    assert(debugAssertIsValid());
    return _KonglomeratSinglePainter(this);
  }

  @override
  Path getClipPath(Rect rect, TextDirection textDirection) {
    return Path()..addRect(rect);
  }

  @override
  bool operator ==(Object other) {
    assert(debugAssertIsValid());
    if (identical(this, other)) return true;
    return other is KonglomeratSingleDecoration &&
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
class _KonglomeratSinglePainter extends BoxPainter {
  _KonglomeratSinglePainter(this._config)
      : assert(_config.debugAssertIsValid()),
        super(null);

  final KonglomeratSingleDecoration _config;

  // This class contains a lot of magic numbers. They were derived from the
  // values in the SVG files exported from the original artwork source.

  void _paintLogo(Canvas canvas, Rect rect) {
    // Our points are in a coordinate space that's 2449.56 pixels wide and 2646.00 pixels high.
    // First, transform the rectangle so that our coordinate space is a square 2646.00 pixels
    // to a side, with the top left at the origin.
    canvas.save();
    canvas.translate(rect.left, rect.top);
    canvas.scale(rect.width / 2646.00, rect.height / 2646.00);
    // Next, offset it some more so that the 2449.56 horizontal pixels are centered
    // in that square (as opposed to being on the left side of it). This means
    // that if we draw in the rectangle from 0,0 to 2449.56,2646.00, we are drawing in
    // the center of the given rect.
    canvas.translate((2646.00 - 2449.56) / 2.0, 0.0);

    final paint0 = Paint()..color = const Color(0xffe2382a);

    final path0 = Path()
      ..moveTo(0.00, 1274.00)
      ..lineTo(1225.72, 0.00)
      ..lineTo(2449.56, 1275.00)
      ..lineTo(2449.56, 2646.00)
      ..lineTo(0.00, 2646.00)
      ..lineTo(0.00, 1274.00);

    final path1 = Path()
      ..moveTo(385.78, 2243.00)
      ..lineTo(385.78, 1445.00)
      ..lineTo(1227.86, 561.00)
      ..lineTo(2066.04, 1439.00)
      ..lineTo(2066.04, 2243.00)
      ..lineTo(385.78, 2243.00);

    final pathK = Path.combine(PathOperation.difference, path0, path1);

    canvas.drawPath(pathK, paint0);
    canvas.restore();
  }

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    offset += _config.margin.topLeft;
    final Size canvasSize = _config.margin.deflateSize(configuration.size!);
    if (canvasSize.isEmpty) return;
    const logoSize = Size(2646.00, 2646.00);

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

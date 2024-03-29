///
/// * author: hunghd
/// * email: hunghd.yb@gmail.com
/// * github: https://github.com/hnvn/flutter_shimmer
///
/// A package provides an easy way to add shimmer effect to Flutter application.
///
/// Note: this package has been customized to support the fade shimmer
/// animation. Therefore, [ShimmerMode] is not provided by the original
/// package.
///
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

///
/// An enum defines all supported directions of shimmer effect
///
/// * [ShimmerDirection.ltr] left to right direction
/// * [ShimmerDirection.rtl] right to left direction
/// * [ShimmerDirection.ttb] top to bottom direction
/// * [ShimmerDirection.btt] bottom to top direction
///
enum ShimmerDirection { ltr, rtl, ttb, btt }

///
/// An enum defines all supported shimmer effect modes
///
/// * [ShimmerMode.gradient]
/// * [ShimmerMode.fade]
///
enum ShimmerMode { gradient, fade }

///
/// A widget renders shimmer effect over [child] widget tree.
///
/// [child] defines an area that shimmer effect blends on. You can build [child]
/// from whatever [Widget] you like but there're some notices in order to get
/// exact expected effect and get better rendering performance:
///
/// * Use static [Widget] (which is an instance of [StatelessWidget]).
/// * [Widget] should be a solid color element. Every colors you set on these
/// [Widget]s will be overridden by colors of [gradient].
/// * Shimmer effect only affects to opaque areas of [child], transparent areas
/// still stays transparent.
///
/// [period] controls the speed of shimmer effect. The default value is 1500
/// milliseconds.
///
/// [direction] controls the direction of shimmer effect. The default value
/// is [ShimmerDirection.ltr].
///
/// [gradient] controls colors of shimmer effect.
///
/// [loop] the number of animation loop, set value of `0` to make animation run
/// forever.
///
/// [enabled] controls if shimmer effect is active. When set to false the animation
/// is paused
///
///
/// ## Pro tips:
///
/// * [child] should be made of basic and simple [Widget]s, such as [Container],
/// [Row] and [Column], to avoid side effect.
///
/// * use one [Shimmer] to wrap list of [Widget]s instead of a list of many [Shimmer]s
///
@immutable
class Shimmer extends StatefulWidget {
  final Widget child;
  final Duration period;
  final ShimmerDirection direction;
  final Gradient gradient;
  final int loop;
  final bool enabled;
  final ShimmerMode mode;
  final double minFadeValue;
  final Curve curve;

  const Shimmer({
    super.key,
    required this.child,
    required this.gradient,
    this.direction = ShimmerDirection.ltr,
    this.period = const Duration(milliseconds: 1500),
    this.loop = 0,
    this.enabled = true,
    this.mode = ShimmerMode.gradient,
    this.minFadeValue = 0.0,
    this.curve = Curves.linear,
  });

  ///
  /// A convenient constructor provides an easy and convenient way to create a
  /// [Shimmer] which [gradient] is [LinearGradient] made up of `baseColor` and
  /// `highlightColor`.
  ///
  Shimmer.fromColors({
    super.key,
    required this.child,
    required Color baseColor,
    required Color highlightColor,
    this.period = const Duration(milliseconds: 1500),
    this.direction = ShimmerDirection.ltr,
    this.loop = 0,
    this.enabled = true,
    this.mode = ShimmerMode.gradient,
    this.minFadeValue = 0.1,
    this.curve = Curves.linear,
  }) : gradient = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.centerRight,
          colors: <Color>[
            baseColor,
            baseColor,
            highlightColor,
            baseColor,
            baseColor
          ],
          stops: const <double>[0.0, 0.35, 0.5, 0.65, 1.0],
        );

  ///
  /// A convenient constructor provides an easy and convenient way to create a
  /// [Shimmer] which with fadeInFadeOut behavior.
  ///
  Shimmer.fromFade({
    Key? key,
    required this.child,
    required Color color,
    this.period = const Duration(milliseconds: 1500),
    this.direction = ShimmerDirection.ltr,
    this.loop = 0,
    this.enabled = true,
    this.mode = ShimmerMode.fade,
    this.minFadeValue = 0.1,
    this.curve = Curves.linear,
  })  : gradient = LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.centerRight,
            colors: <Color>[
              color,
            ],
            stops: const <double>[
              1.0
            ]),
        super(key: key);

  @override
  State<Shimmer> createState() => _ShimmerState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Gradient>('gradient', gradient,
        defaultValue: null));
    properties.add(EnumProperty<ShimmerDirection>('direction', direction));
    properties.add(
        DiagnosticsProperty<Duration>('period', period, defaultValue: null));
    properties
        .add(DiagnosticsProperty<bool>('enabled', enabled, defaultValue: null));
    properties.add(DiagnosticsProperty<int>('loop', loop, defaultValue: 0));
    properties.add(DiagnosticsProperty<ShimmerMode>('mode', mode));
    properties.add(DiagnosticsProperty<ShimmerMode>('mode', mode));
    properties.add(DiagnosticsProperty<double>('minFadeValue', minFadeValue));
    properties.add(DiagnosticsProperty<Curve>('curve', curve));
  }
}

class _ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  int _count = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.period)
      ..addStatusListener((AnimationStatus status) {
        if (status != AnimationStatus.completed) {
          return;
        }
        _count++;
        if (widget.loop <= 0) {
          _controller.repeat(reverse: widget.mode == ShimmerMode.fade);
        } else if (_count < widget.loop) {
          _controller.forward(from: 0.0);
        }
      });
    _animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));
    if (widget.enabled) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(Shimmer oldWidget) {
    if (widget.enabled) {
      _controller.forward();
    } else {
      _controller.stop();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      child: widget.child,
      builder: (BuildContext context, Widget? child) => _Shimmer(
        direction: widget.direction,
        gradient: widget.gradient,
        percent: _controller.value,
        mode: widget.mode,
        minFadeValue: widget.minFadeValue,
        child: child,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

@immutable
class _Shimmer extends SingleChildRenderObjectWidget {
  final double percent;
  final ShimmerDirection direction;
  final Gradient gradient;
  final ShimmerMode mode;
  final double minFadeValue;

  const _Shimmer({
    Widget? child,
    required this.percent,
    required this.direction,
    required this.gradient,
    required this.mode,
    required this.minFadeValue,
  }) : super(child: child);

  @override
  _ShimmerFilter createRenderObject(BuildContext context) {
    return _ShimmerFilter(percent, direction, gradient, mode, minFadeValue);
  }

  @override
  void updateRenderObject(BuildContext context, _ShimmerFilter shimmer) {
    shimmer.percent = percent;
    shimmer.gradient = gradient;
    shimmer.direction = direction;
  }
}

class _ShimmerFilter extends RenderProxyBox {
  ShimmerDirection _direction;
  Gradient _gradient;
  double _percent;
  ShimmerMode mode;
  double minFadeValue;

  _ShimmerFilter(
    this._percent,
    this._direction,
    this._gradient,
    this.mode,
    this.minFadeValue,
  );

  @override
  ShaderMaskLayer? get layer => super.layer as ShaderMaskLayer?;

  @override
  bool get alwaysNeedsCompositing => child != null;

  set percent(double newValue) {
    if (newValue == _percent) {
      return;
    }
    _percent = newValue;
    markNeedsPaint();
  }

  set gradient(Gradient newValue) {
    if (newValue == _gradient) {
      return;
    }
    _gradient = newValue;
    markNeedsPaint();
  }

  set direction(ShimmerDirection newDirection) {
    if (newDirection == _direction) {
      return;
    }
    _direction = newDirection;
    markNeedsLayout();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      assert(needsCompositing);

      final double width = child!.size.width;
      final double height = child!.size.height;
      if (mode == ShimmerMode.gradient) {
        Rect rect;
        double dx, dy;
        if (_direction == ShimmerDirection.rtl) {
          dx = _offset(width, -width, _percent);
          dy = 0.0;
          rect = Rect.fromLTWH(dx - width, dy, 3 * width, height);
        } else if (_direction == ShimmerDirection.ttb) {
          dx = 0.0;
          dy = _offset(-height, height, _percent);
          rect = Rect.fromLTWH(dx, dy - height, width, 3 * height);
        } else if (_direction == ShimmerDirection.btt) {
          dx = 0.0;
          dy = _offset(height, -height, _percent);
          rect = Rect.fromLTWH(dx, dy - height, width, 3 * height);
        } else {
          dx = _offset(-width, width, _percent);
          dy = 0.0;
          rect = Rect.fromLTWH(dx - width, dy, 3 * width, height);
        }
        layer ??= ShaderMaskLayer();
        layer!
          ..shader = _gradient.createShader(rect)
          ..maskRect = offset & size
          ..blendMode = BlendMode.srcIn;
        context.pushLayer(layer!, super.paint, offset);
      } else if (mode == ShimmerMode.fade) {
        final LinearGradient fadedGradient = LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.centerRight,
            colors: _gradient.colors
                .map((color) => color.withOpacity(
                    (_percent * (1 - minFadeValue)) + minFadeValue))
                .toList(),
            stops: _gradient.stops);
        layer ??= ShaderMaskLayer();
        layer!
          ..shader = fadedGradient
              .createShader(const Offset(0, 0) & Size(width, height))
          ..maskRect = offset & size
          ..blendMode = BlendMode.srcIn;
        context.pushLayer(layer!, super.paint, offset);
      }
    } else {
      layer = null;
    }
  }

  double _offset(double start, double end, double percent) {
    return start + (end - start) * percent;
  }
}

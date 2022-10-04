import 'dart:math';
import 'package:flutter/widgets.dart';

class KonglomeratSpinner extends StatefulWidget {
  const KonglomeratSpinner({super.key});

  @override
  State<KonglomeratSpinner> createState() => _KonglomeratSpinnerState();
}

class _KonglomeratSpinnerState extends State<KonglomeratSpinner> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (
      BuildContext context,
      BoxConstraints constraints,
    ) {
      return AnimatedKonglomerat(
        constraints: constraints,
      );
    });
  }
}

class AnimatedKonglomerat extends StatefulWidget {
  final Color color;
  final BoxConstraints constraints;

  const AnimatedKonglomerat({
    super.key,
    this.color = const Color.fromARGB(255, 226, 56, 42),
    required this.constraints,
  });

  @override
  State<AnimatedKonglomerat> createState() => _AnimatedKonglomeratState();
}

class _AnimatedKonglomeratState extends State<AnimatedKonglomerat>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1250),
    );
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ),
    );
    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // enable this to get Duration based on size
    // controller.repeat(
    //   period: Duration(
    //     milliseconds: getDurationInMilliseconds(constraints.maxWidth),
    //   ),
    // );
    final height = widget.constraints.maxHeight;
    final width = widget.constraints.maxWidth;
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => CustomPaint(
        size: Size(height, width),
        painter: SpinnerPainter(
          color: widget.color,
          size: min(height, width),
          animation: animation,
        ),
      ),
    );
  }
}

class SpinnerPainter extends CustomPainter {
  final Color color;
  final double size;
  final Animation<double> animation;

  SpinnerPainter({
    required this.color,
    required this.size,
    required this.animation,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Animation animateOpacity = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: animation,
        curve: FadeCurve(),
      ),
    );
    Color fadedColor = color.withAlpha((animateOpacity.value * 150).toInt());

    const strokeWidth = 97.5550473384533 * 0.16441288570981;
    final fadingOutPaint = Paint()
      ..color = fadedColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.square;
    final solidPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.square;

    // scale to parent widget
    canvas.scale(size.width / 125.0, size.height / 125.0);
    // translate to center/center
    canvas.translate((125.0 - 97.5550473384533) / 2.0, 25.0 / 2);

    final rawPath = Path()
      ..moveTo(0.00, 100.0)
      ..lineTo(0.00, 48.9470796217883)
      ..lineTo(48.9470796217883, 0.00)
      ..lineTo(97.5550473384533, 48.9470796217883)
      ..lineTo(97.5550473384533, 100.0)
      ..close();
    // get rawPath totalLength
    final metric = rawPath.computeMetrics().first;
    final totalLength = metric.length;

    // get growing path and draw fading out paint
    canvas.drawPath(
      extractPartialPath(rawPath, totalLength, animation),
      fadingOutPaint,
    );

    // compute start and stop position of running rectangle (which is a line)
    final tangentBefore = metric.getTangentForOffset(
      (animation.value - 0.001) * totalLength,
    );
    final tangent = metric.getTangentForOffset(
      animation.value * totalLength,
    );
    // draw line (which is visually a rectangle)
    canvas.drawLine(
      tangentBefore!.position,
      tangent!.position,
      solidPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

Path extractPartialPath(
  Path fullPath,
  double totalLength,
  Animation animation,
) {
  final currentLength = animation.value * totalLength;
  final path = Path();

  var metricsIterator = fullPath.computeMetrics().iterator;
  while (metricsIterator.moveNext()) {
    var metric = metricsIterator.current;

    path.addPath(
      metric.extractPath(0, currentLength),
      Offset.zero,
    );
  }
  return path;
}

int getDurationInMilliseconds(double size) {
  final sizeToMs = (size * 11).toInt();
  if (sizeToMs > 1600) return 1600;
  if (sizeToMs < 1300) return 1300;
  return sizeToMs;
}

class FadeCurve extends Curve {
  @override
  double transform(double t) => sin(3.14159 * t);
}

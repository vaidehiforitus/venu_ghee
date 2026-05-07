// // gradient_border_container.dart


import 'package:venu_ghee/core/theme/theme_helper.dart';
import 'package:venu_ghee/core/utils/exports/common_exports.dart';

class GradientBorderContainer extends StatelessWidget {
  final Widget child;
  final double borderWidth;
  final double borderRadius;
  final Color innerColor;
  final Gradient? customGradient; // ← custom gradient joiiae to pass karo

  const GradientBorderContainer({
    super.key,
    required this.child,
    this.borderWidth = 1,
    this.borderRadius = 18,
    this.innerColor = const Color(0xFF1A1A2E), // ← default dark bg
    this.customGradient,
  });

  // Default border gradient
  static const Gradient defaultBorderGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0x66FFFFFF), // white 40%
      Color(0x00FFFFFF), // white 0%
      Color(0x00FFFFFF), // white 0%
      Color(0x66FFFFFF), // white 40%
    ],
    stops: [0.0, 0.4, 0.6, 1.0],
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: customGradient ?? defaultBorderGradient,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      padding: EdgeInsets.all(borderWidth),
      child: Container(
        decoration: BoxDecoration(
          color: innerColor,
          borderRadius: BorderRadius.circular(borderRadius - borderWidth),
        ),
        child: child,
      ),
    );
  }
}

///container border linner
class GradientBorderPainter extends CustomPainter {
  final double strokeWidth;
  final BorderRadius borderRadius;
  final Gradient gradient;

  GradientBorderPainter({
    required this.strokeWidth,
    required this.borderRadius,
    required this.gradient,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(
      strokeWidth / 2,
      strokeWidth / 2,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..shader = gradient.createShader(rect)
      ..isAntiAlias = true;

    final rRect = borderRadius.toRRect(rect);

    canvas.drawRRect(rRect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


///dot border

class GradientDashedBorderPainter extends CustomPainter {
  final double strokeWidth;
  final double radius;
  final double dashWidth;
  final double dashSpace;
  final Gradient gradient;

  GradientDashedBorderPainter({
    required this.strokeWidth,
    required this.radius,
    required this.gradient,
    this.dashWidth = 6,
    this.dashSpace = 4,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTWH(
      strokeWidth / 2,
      strokeWidth / 2,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..shader = gradient.createShader(rect)
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true;

    final RRect rRect = RRect.fromRectAndRadius(rect, Radius.circular(radius));

    final Path path = Path()..addRRect(rRect);

    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        canvas.drawPath(
          metric.extractPath(distance, distance + dashWidth),
          paint,
        );
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

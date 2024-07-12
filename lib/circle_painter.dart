part of 'animated_ripple.dart';

class CirclePainter extends CustomPainter {
  final double radius;
  final Color color;
  final double opacity;
  final bool fill;

  const CirclePainter({
    required this.radius,
    required this.opacity,
    required this.color,
    this.fill = false,
  });

  @override
  void paint(Canvas canvas, _) {
    final paint = Paint()
      ..strokeWidth = 2
      ..style = fill ? PaintingStyle.fill : PaintingStyle.stroke
      ..color = color.withOpacity(opacity);

    final path = Path()
      ..addOval(
        Rect.fromCircle(
          center: Offset(radius, radius),
          radius: radius,
        ),
      );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

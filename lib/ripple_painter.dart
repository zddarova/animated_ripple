part of 'animated_ripple.dart';

class _RipplePainter extends CustomPainter {
  final Size size;
  final Color color;
  final double opacity;
  final bool fill;

  _RipplePainter({
    required this.size,
    required this.opacity,
    required this.color,
    this.fill = false,
  });

  @override
  void paint(Canvas canvas, _) {
    final paint = Paint()
      ..style = fill ? PaintingStyle.fill : PaintingStyle.stroke
      ..color = color.withOpacity(opacity);

    final h = size.height;
    final w = size.width;

    var path = Path();

    path.moveTo(w * 0.83, h / 5);
    path.cubicTo(w * 0.75, h * 0.1, w * 0.64, h * 0.01, w * 0.51, 0);
    path.cubicTo(w * 0.38, 0, w * 0.26, h * 0.08, w * 0.17, h * 0.19);
    path.cubicTo(w * 0.12, h * 0.26, w * 0.07, h / 3, w * 0.04, h * 0.4);
    path.cubicTo(w * 0.01, h * 0.48, -0.01, h * 0.56, w * 0.01, h * 0.64);
    path.cubicTo(w * 0.03, h * 0.73, w * 0.07, h * 0.79, w * 0.13, h * 0.84);
    path.cubicTo(w * 0.19, h * 0.89, w * 0.26, h * 0.92, w / 3, h * 0.95);
    path.cubicTo(w * 0.45, h, w * 0.58, h * 1.02, w * 0.7, h * 0.97);
    path.cubicTo(w * 0.77, h * 0.93, w * 0.83, h * 0.89, w * 0.89, h * 0.84);
    path.cubicTo(w * 0.94, h * 0.79, w * 0.98, h * 0.72, w, h * 0.64);
    path.cubicTo(w, h * 0.56, w, h * 0.48, w * 0.96, h * 0.41);
    path.cubicTo(w * 0.93, h * 0.34, w * 0.88, h * 0.27, w * 0.83, h / 5);
    path.cubicTo(w * 0.83, h / 5, w * 0.83, h / 5, w * 0.83, h / 5);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

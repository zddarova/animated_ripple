library animated_ripple;

import 'package:flutter/material.dart';

class AnimatedRipple extends StatefulWidget {
  const AnimatedRipple({Key? key}) : super(key: key);

  @override
  State<AnimatedRipple> createState() => _AnimatedRippleState();
}

class _AnimatedRippleState extends State<AnimatedRipple> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(300, 300),
      painter: _RipplePainter(
        size: const Size.fromRadius(150),
        color: Colors.red,
      ),
    );
  }
}

class _RipplePainter extends CustomPainter {
  final Size size;
  final Color color;

  _RipplePainter({
    required this.size,
    this.color = Colors.transparent,
  });

  @override
  void paint(Canvas canvas, _) {
    Paint paint = Paint();
    Path path = Path();

    paint.color = color;
    path = Path();
    path.lineTo(size.width * 0.83, size.height / 5);
    path.cubicTo(size.width * 0.75, size.height * 0.1, size.width * 0.64, size.height * 0.01, size.width * 0.51, 0);
    path.cubicTo(size.width * 0.38, 0, size.width * 0.26, size.height * 0.08, size.width * 0.17, size.height * 0.19);
    path.cubicTo(size.width * 0.12, size.height * 0.26, size.width * 0.07, size.height / 3, size.width * 0.04,
        size.height * 0.4);
    path.cubicTo(
        size.width * 0.01, size.height * 0.48, -0.01, size.height * 0.56, size.width * 0.01, size.height * 0.64);
    path.cubicTo(size.width * 0.03, size.height * 0.73, size.width * 0.07, size.height * 0.79, size.width * 0.13,
        size.height * 0.84);
    path.cubicTo(size.width * 0.19, size.height * 0.89, size.width * 0.26, size.height * 0.92, size.width / 3,
        size.height * 0.95);
    path.cubicTo(
        size.width * 0.45, size.height, size.width * 0.58, size.height * 1.02, size.width * 0.7, size.height * 0.97);
    path.cubicTo(size.width * 0.77, size.height * 0.93, size.width * 0.83, size.height * 0.89, size.width * 0.89,
        size.height * 0.84);
    path.cubicTo(
        size.width * 0.94, size.height * 0.79, size.width * 0.98, size.height * 0.72, size.width, size.height * 0.64);
    path.cubicTo(size.width, size.height * 0.56, size.width, size.height * 0.48, size.width * 0.96, size.height * 0.41);
    path.cubicTo(size.width * 0.93, size.height * 0.34, size.width * 0.88, size.height * 0.27, size.width * 0.83,
        size.height / 5);
    path.cubicTo(
        size.width * 0.83, size.height / 5, size.width * 0.83, size.height / 5, size.width * 0.83, size.height / 5);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

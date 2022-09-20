part of 'animated_ripple.dart';

class _RippleButton extends StatelessWidget {
  static const _opacity = 1.0;
  static const _fill = true;

  const _RippleButton({
    Key? key,
    required this.size,
    required this.color,
    this.onPressed,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final Size size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: CustomPaint(
        size: size,
        painter: _RipplePainter(
          size: size,
          opacity: _opacity,
          color: color,
          fill: _fill,
        ),
      ),
    );
  }
}

part of 'animated_ripple.dart';

class _RippleButton extends StatefulWidget {
  const _RippleButton({
    Key? key,
    required this.size,
    required this.color,
    required this.secondaryColor,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;
  final Size size;
  final Color color;
  final Color secondaryColor;

  @override
  State<_RippleButton> createState() => _RippleButtonState();
}

class _RippleButtonState extends State<_RippleButton> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  // TODO (andreyK): Make it as much configurable as possible
  static const duration = Duration(milliseconds: 300);

  static const curve = Curves.bounceIn;
  static const initialSize = 1.0;
  static const sizeIncrease = 1.2;

  static const _opacity = 1.0;
  static const _fill = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: duration,
      lowerBound: initialSize,
      upperBound: sizeIncrease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await _controller.forward();
        await _controller.reverse();
        widget.onPressed();
      },
      splashColor: widget.secondaryColor,
      highlightColor: widget.secondaryColor,
      focusColor: widget.secondaryColor,
      hoverColor: widget.secondaryColor,
      child: AnimatedSize(
        curve: curve,
        duration: duration,
        child: CustomPaint(
          size: widget.size * _controller.value,
          painter: _RipplePainter(
            size: widget.size * _controller.value,
            opacity: _opacity,
            color: widget.color,
            fill: _fill,
          ),
        ),
      ),
    );
  }
}

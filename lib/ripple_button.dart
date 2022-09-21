part of 'animated_ripple.dart';

class _RippleButton extends StatefulWidget {
  static const _opacity = 1.0;
  static const _fill = true;

  const _RippleButton({
    Key? key,
    required this.size,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;
  final Size size;
  final Color color;

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
      splashColor: Colors.white,
      highlightColor: Colors.white,
      focusColor: Colors.white,
      hoverColor: Colors.white,
      child: AnimatedSize(
        curve: curve,
        duration: duration,
        child: CustomPaint(
          size: widget.size * _controller.value,
          painter: _RipplePainter(
            size: widget.size * _controller.value,
            opacity: _RippleButton._opacity,
            color: widget.color,
            fill: _RippleButton._fill,
          ),
        ),
      ),
    );
  }
}

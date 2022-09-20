library animated_ripple;

import 'package:flutter/material.dart';

part 'ripple_painter.dart';

part 'ripple_button.dart';

class AnimatedRipple extends StatefulWidget {
  const AnimatedRipple({
    Key? key,
    required this.size,
    required this.numberOfRipples,
    required this.duration,
    required this.color,
    this.onPressed,
    // todo (andreyK): replace with enum
    required this.loopAnimation,
  }) : super(key: key);

  final int numberOfRipples;
  final Size size;
  final Duration duration;
  final Color color;
  final VoidCallback? onPressed;
  final bool loopAnimation;

  @override
  State<AnimatedRipple> createState() => _AnimatedRippleState();
}

class _AnimatedRippleState extends State<AnimatedRipple> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    if (widget.loopAnimation) _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        final paints = <CustomPaint>[];

        for (var i = 1; i < widget.numberOfRipples + 1; i++) {
          final iCoefficient = i.toDouble() / widget.numberOfRipples.toDouble();
          final nextCoefficient = (i + 1).toDouble() / widget.numberOfRipples.toDouble();

          final iSize = widget.size * iCoefficient;
          final nextSize = widget.size * nextCoefficient;

          final h = iSize.height + (nextSize.height - iSize.height) * _controller.value;
          final w = iSize.width + (nextSize.width - iSize.width) * _controller.value;

          final result = Size(h, w);

          // TODO (andreyK): fix issue with opacity assert
          var opacity = 1 - nextCoefficient - (nextCoefficient - iCoefficient) * _controller.value;
          if (opacity < 0) opacity = 0;
          if (opacity > 1) opacity = 1;

//           if (false) {
//             print('''\n\n
// iCoefficient:\t\t\t$iCoefficient
// nextCoefficient:\t\t$nextCoefficient
// iSize:\t\t\t\t\t$iSize
// nextSize:\t\t\t\t$nextSize
// h:\t\t\t\t\t\t$h
// w:\t\t\t\t\t\t$w
// _controller.value:\t\t${_controller.value}
// result:\t\t\t\t\t$result
// opacity:\t\t\t\t\t$opacity
// \n\n''');
//           }

          paints.add(
            CustomPaint(
              size: result,
              painter: _RipplePainter(
                size: result,
                opacity: opacity,
                color: widget.color,
              ),
            ),
          );
        }

        return Stack(
          alignment: Alignment.center,
          children: [
            ...paints,
            _RippleButton(
              onPressed: () {
                if (!widget.loopAnimation) _controller.forward().then((_) => _controller.reset());
                widget.onPressed?.call();
              },
              color: widget.color,
              size: widget.size / widget.numberOfRipples.toDouble(),
            ),
          ],
        );
      },
    );
  }
}

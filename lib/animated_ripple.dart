library animated_ripple;

import 'package:flutter/material.dart';

part 'ripple_button.dart';
part 'ripple_painter.dart';

enum RippleEffect { looped, animateOnTap, speedUpOnTap }

class AnimatedRipple extends StatefulWidget {
  const AnimatedRipple({
    Key? key,
    required this.size,
    required this.numberOfRipples,
    required this.duration,
    required this.color,
    required this.secondaryColor,
    required this.rippleEffect,
    this.onPressed,
    this.icon,
  }) : super(key: key);

  final int numberOfRipples;
  final Size size;
  final Duration duration;
  final Color color;
  final Color secondaryColor;
  final VoidCallback? onPressed;
  final RippleEffect rippleEffect;
  final Widget? icon;

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
      animationBehavior: AnimationBehavior.preserve,
    );
    if (widget.rippleEffect == RippleEffect.looped || widget.rippleEffect == RippleEffect.speedUpOnTap) {
      _controller.repeat();
    }
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
              color: widget.color,
              secondaryColor: widget.secondaryColor,
              size: widget.size / widget.numberOfRipples.toDouble(),
              icon: widget.icon,
              onPressed: () async {
                widget.onPressed?.call();
                if (widget.rippleEffect == RippleEffect.animateOnTap) {
                  await _controller.forward();
                  _controller.reset();
                } else if (widget.rippleEffect == RippleEffect.speedUpOnTap) {
                  // TODO (andreyK): this is actually works, but need to do it better - with configuration and etc

                  await _controller.fling(velocity: 1.5);
                  _controller.reset();
                  _controller.repeat();
                }
              },
            ),
          ],
        );
      },
    );
  }
}

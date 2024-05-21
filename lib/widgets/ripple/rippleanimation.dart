import 'package:flutter/material.dart';
import 'package:listenbox/widgets/curvewave.dart';
import 'package:listenbox/widgets/ripple/circlepainter.dart';

class RippleAnimation extends StatefulWidget {
  final double size;
  final Color color;
  final Widget child;
  final VoidCallback? onPressed;
  const RippleAnimation(
      {super.key,
      this.size = 80.0,
      this.color = Colors.red,
      this.onPressed,
      required this.child});

  @override
  State<RippleAnimation> createState() => RippleAnimationState();
}

class RippleAnimationState extends State<RippleAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _button() {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.size),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: <Color>[
                widget.color,
                Color.lerp(widget.color, Colors.black, .05)!
              ],
            ),
          ),
          child: ScaleTransition(
              scale: Tween(begin: 0.95, end: 1.0).animate(
                CurvedAnimation(
                  parent: _controller,
                  curve: const CurveWave(),
                ),
              ),
              child: widget.child),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CirclePainter(
        _controller,
        color: widget.color,
      ),
      child: SizedBox(
        width: widget.size * 4.125,
        height: widget.size * 4.125,
        child: _button(),
      ),
    );
  }
}

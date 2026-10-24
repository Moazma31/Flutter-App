import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/app_theme.dart';

class FloatingBackground extends StatefulWidget {
  final Color color;
  final Widget child;

  const FloatingBackground({
    super.key,
    required this.color,
    required this.child,
  });

  @override
  State<FloatingBackground> createState() => _FloatingBackgroundState();
}

class _FloatingBackgroundState extends State<FloatingBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _bubble(BoxConstraints box, double t, double size, double x,
      double y, double phase, int alpha) {
    return Positioned(
      left: box.maxWidth * x + math.sin(t + phase) * 24,
      top: box.maxHeight * y + math.cos(t + phase) * 32,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.color.withAlpha(alpha),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [widget.color.withAlpha(60), AppColors.background],
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: LayoutBuilder(
            builder: (context, box) {
              return AnimatedBuilder(
                animation: _controller,
                builder: (context, _) {
                  final t = _controller.value * 2 * math.pi;
                  return Stack(
                    children: [
                      _bubble(box, t, 140, 0.05, 0.08, 0.0, 40),
                      _bubble(box, t, 90, 0.70, 0.15, 1.5, 50),
                      _bubble(box, t, 60, 0.15, 0.55, 3.0, 45),
                      _bubble(box, t, 120, 0.65, 0.65, 4.5, 35),
                      _bubble(box, t, 50, 0.45, 0.35, 2.2, 55),
                    ],
                  );
                },
              );
            },
          ),
        ),
        Positioned.fill(child: widget.child),
      ],
    );
  }
}
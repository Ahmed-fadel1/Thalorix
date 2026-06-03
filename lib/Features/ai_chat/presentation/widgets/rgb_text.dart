import 'package:flutter/material.dart';

/// Animated RGB glow text that sweeps colors left-to-right across "THALORIX"
class RgbAnimatedText extends StatefulWidget {
  const RgbAnimatedText({super.key});

  @override
  State<RgbAnimatedText> createState() => _RgbAnimatedTextState();
}

class _RgbAnimatedTextState extends State<RgbAnimatedText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
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
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              begin: Alignment(-1.0 + 2.0 * _controller.value, 0),
              end: Alignment(1.0 + 2.0 * _controller.value, 0),
              colors: const [
                Color(0xFFFF0000), // Red
                Color(0xFFFF7F00), // Orange
                Color(0xFFFFFF00), // Yellow
                Color(0xFF00FF00), // Green
                Color(0xFF0000FF), // Blue
                Color(0xFF4B0082), // Indigo
                Color(0xFF9400D3), // Violet
                Color(0xFFFF0000), // Red again for seamless loop
              ],
              tileMode: TileMode.mirror,
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcIn,
          child: const Text(
            'THALORIX',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              letterSpacing: 3.0,
            ),
          ),
        );
      },
    );
  }
}

/// Helper widget — Flutter doesn't have "AnimatedBuilder" by default,
/// so we use AnimatedBuilder which IS the correct name in Flutter.
/// The above code uses AnimatedBuilder correctly.

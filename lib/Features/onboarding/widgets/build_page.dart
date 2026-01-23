import 'package:flutter/material.dart';

Widget buildPage({
  required String title,
  required String desc,
  required String image,
  Widget? button,
}) {
  return Column(
    children: [
      Stack(
        children: [
          ShaderMask(
            shaderCallback: (rect) {
              return const LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.transparent, Color(0xFF083333)],
                stops: [0.1, 0.7],
              ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
            },
            blendMode: BlendMode.dstIn,
            child: Image.asset(
              image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),

          // Skip Button
          button ?? Container(),
        ],
      ),
      const SizedBox(height: 60),
      Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
      const SizedBox(height: 20),
      Text(
        desc,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      const SizedBox(height: 100),
    ],
  );
}

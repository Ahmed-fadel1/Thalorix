import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

Widget dotinticator(PageController _controller) {
  return Container(
    alignment: const Alignment(0, 0.85),
    child: SmoothPageIndicator(
      controller: _controller,
      count: 3,
      effect: const ExpandingDotsEffect(
        activeDotColor: Colors.white,
        dotColor: Colors.grey,
        dotHeight: 8,
        dotWidth: 8,
        expansionFactor: 4,
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:thalorix_app/Features/onboarding/widgets/build_page.dart';
import 'package:thalorix_app/Features/onboarding/widgets/skipbutton.dart';

class OnBoardingView extends StatefulWidget {
  @override
  _OnBoardingViewState createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF083333),
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            children: [
              buildPage(
                image: "assets/images/first_onboarding_image.png",
                title: "Turn ideas into working code",
                desc:
                    "Generate real, executable code from\n text, images, or designs  instantly",
                button: skipButton(context),
              ),
              buildPage(
                image: "assets/images/second_onboarding_image.png",
                title: " Build, preview, and manage\n in one place",
                desc:
                    " Edit code, see live previews, manage\n projects, and ship faster  all from one\n dashboard.",
                button: skipButton(context),
              ),
              buildPage(
                image: "assets/images/first_onboarding_image.png",
                title: "Code, preview, manage",
                desc: "Everything in one flow.",
              ),
            ],
          ),

          Container(
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
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:thalorix_app/Features/onboarding/presentation/onboarding_view.dart';
import 'package:thalorix_app/core/utils/Colors/app_colors.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OnBoardingView()),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.splashPrimary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Center(child: Image.asset("assets/images/splash_logo.png")),
          Column(
            children: [
              Image.asset("assets/images/splash_loading.png"),
              SizedBox(height: 8),
              Text("Loading...", style: TextStyle(color: Colors.white)),
            ],
          ),
        ],
      ),
    );
  }
}

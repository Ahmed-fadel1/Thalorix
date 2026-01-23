import 'package:flutter/material.dart';
import 'package:thalorix_app/Features/splash/splash_view.dart';

void main() {
  runApp(const Thalorix());
}

class Thalorix extends StatelessWidget {
  const Thalorix({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: SplashView());
  }
}

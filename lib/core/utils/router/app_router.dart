import 'package:flutter/material.dart';
import 'package:thalorix_app/Features/auth/Login/login_view.dart';
import 'package:thalorix_app/Features/auth/SignUp/signup_view.dart';
import 'package:thalorix_app/Features/splash/splash_view.dart';

class Routes {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String splash = '/splash';
}

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.signup:
        return MaterialPageRoute(builder: (_) => const SignupView());
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashView());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}

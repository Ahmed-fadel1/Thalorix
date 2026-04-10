import 'package:flutter/material.dart';
import 'package:thalorix_app/Features/auth/presentation/pages/forgot_password/forgot_password.dart';
import 'package:thalorix_app/Features/auth/presentation/pages/login/login_view.dart';
import 'package:thalorix_app/Features/auth/presentation/pages/SignUp/signup_view.dart';
import 'package:thalorix_app/Features/auth/presentation/pages/verifiction/Verifiction.dart';
import 'package:thalorix_app/Features/home/presentation/home_view.dart';
import 'package:thalorix_app/Features/splash/presentation/splash_view.dart';
import 'package:thalorix_app/Features/profile/presentation/edit_profile_screen.dart';

class Routes {
  static const String login = '/login';
  static const String codeGenerate = '/codeGenerate';
  static const String codeGenerateprogress = '/codeGenerateprogress';
  static const String home = '/';
  static const String signup = '/signup';
  static const String splash = '/splash';
  static const String verification = '/verifiction';
  static const String forgotPassword = '/forgotPassword';
  static const String editProfile = '/editProfile';
  static const String ChatsScreen = '/ChatsScreen';
}

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        return MaterialPageRoute(builder: (_) => LoginView());
      case Routes.home:
        return MaterialPageRoute(builder: (_) => HomeView());
      case Routes.signup:
        return MaterialPageRoute(builder: (_) => const SignupView());
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.verification:
        return MaterialPageRoute(builder: (_) => const Verifiction());
      case Routes.forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:thalorix_app/Features/auth/presentation/pages/forgot_password/forgot_password.dart';
import 'package:thalorix_app/Features/auth/presentation/pages/login/login_view.dart';
import 'package:thalorix_app/Features/auth/presentation/pages/SignUp/signup_view.dart';
import 'package:thalorix_app/Features/auth/presentation/pages/verifiction/Verifiction.dart';
import 'package:thalorix_app/Features/chats/presentation/chats_screen.dart';
import 'package:thalorix_app/Features/community/presentation/views/community_view.dart';
import 'package:thalorix_app/Features/home/presentation/home_view.dart';
import 'package:thalorix_app/Features/home/presentation/widgets/bottom_nav_bar.dart';
import 'package:thalorix_app/Features/marketplace/presentation/pages/market_Place_view.dart';
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
  static const String marketPlace = '/marketPlace';
  static const String community = '/community';
}

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        return MaterialPageRoute(builder: (_) => LoginView());
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case Routes.signup:
        return MaterialPageRoute(builder: (_) => const SignupView());
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.verification:
        return MaterialPageRoute(builder: (_) => const Verifiction());
      case Routes.forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordScreen());
      case Routes.marketPlace:
        return MaterialPageRoute(builder: (_) => const MarketPlaceView());
      case Routes.editProfile:
        return MaterialPageRoute(builder: (_) => const EditProfileScreen());
        case Routes.ChatsScreen:
        return MaterialPageRoute(builder: (_) => const ChatsScreen());
        case Routes.community:
        return MaterialPageRoute(builder: (_) =>const CommunityView());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}

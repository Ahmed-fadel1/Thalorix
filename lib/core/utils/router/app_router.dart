import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thalorix_app/Features/auth/presentation/cubit/otp_cubit/otp_cubit.dart';
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
import 'package:thalorix_app/Features/auth/data/data_sources/otp_remote_data_source.dart';
import 'package:thalorix_app/Features/auth/data/repositories/otp_repository_impl.dart';
import 'package:thalorix_app/Features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:thalorix_app/Features/auth/domain/usecases/resend_otp_usecase.dart';

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
        return MaterialPageRoute(settings: settings, builder: (_) => LoginView());
      case Routes.home:
        return MaterialPageRoute(settings: settings, builder: (_) => const HomeView());
      case Routes.signup:
        return MaterialPageRoute(settings: settings, builder: (_) => const SignupView());
      case Routes.splash:
        return MaterialPageRoute(settings: settings, builder: (_) => const SplashView());
      case Routes.verification:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            final otpRepo = OtpRepositoryImpl(OtpRemoteDataSource());
            return BlocProvider(
              create: (context) => OtpCubit(
                VerifyOtpUseCase(otpRepo),
                ResendOtpUseCase(otpRepo),
              )..startTimer(),
              child: const Verifiction(),
            );
          },
        );
      case Routes.forgotPassword:
        return MaterialPageRoute(settings: settings, builder: (_) => const ForgetPasswordScreen());
      case Routes.marketPlace:
        return MaterialPageRoute(settings: settings, builder: (_) => const MarketPlaceView());
      case Routes.editProfile:
        return MaterialPageRoute(settings: settings, builder: (_) => const EditProfileScreen());
        case Routes.ChatsScreen:
        return MaterialPageRoute(settings: settings, builder: (_) => const ChatsScreen());
        case Routes.community:
        return MaterialPageRoute(settings: settings, builder: (_) =>const CommunityView());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}

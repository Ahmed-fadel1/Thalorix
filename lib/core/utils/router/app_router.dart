import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thalorix_app/Features/ai_chat/data/data_sources/ai_chat_local_data_source.dart';
import 'package:thalorix_app/Features/ai_chat/data/data_sources/ai_chat_remote_data_source.dart';
import 'package:thalorix_app/Features/ai_chat/data/repositories/ai_chat_repository_impl.dart';
import 'package:thalorix_app/Features/ai_chat/domain/usecases/create_project_usecase.dart';
import 'package:thalorix_app/Features/ai_chat/domain/usecases/edit_project_usecase.dart';
import 'package:thalorix_app/Features/ai_chat/domain/usecases/get_project_usecase.dart';
import 'package:thalorix_app/Features/ai_chat/domain/usecases/upload_file_usecase.dart';
import 'package:thalorix_app/Features/ai_chat/presentation/cubit/ai_chat_cubit.dart';
import 'package:thalorix_app/Features/ai_chat/presentation/views/ai_chat_view.dart';
import 'package:thalorix_app/Features/auth/presentation/cubit/otp_cubit/otp_cubit.dart';
import 'package:thalorix_app/Features/auth/presentation/pages/forgot_password/forgot_password.dart';
import 'package:thalorix_app/Features/auth/presentation/pages/login/login_view.dart';
import 'package:thalorix_app/Features/auth/presentation/pages/SignUp/signup_view.dart';
import 'package:thalorix_app/Features/auth/presentation/pages/verifiction/Verifiction.dart';
import 'package:thalorix_app/Features/chats/presentation/chats_screen.dart';
import 'package:thalorix_app/Features/code_generation/presentation/code_generation_progress_page.dart';
import 'package:thalorix_app/Features/code_generation/presentation/code_generation_view.dart';
import 'package:thalorix_app/Features/community/data/data_sources/community_remote_data_source.dart';
import 'package:thalorix_app/Features/community/data/models/post_model.dart';
import 'package:thalorix_app/Features/community/data/repositories/community_repository_impl.dart';
import 'package:thalorix_app/Features/community/domain/usecases/create_post_usecase.dart';
import 'package:thalorix_app/Features/community/domain/usecases/delete_post_usecase.dart';
import 'package:thalorix_app/Features/community/domain/usecases/get_feed_usecase.dart';
import 'package:thalorix_app/Features/community/domain/usecases/update_post_usecase.dart';
import 'package:thalorix_app/Features/community/presentation/cubit/community_cubit.dart';
import 'package:thalorix_app/Features/community/presentation/views/community_view.dart';
import 'package:thalorix_app/Features/community/presentation/views/create_post_view.dart';
import 'package:thalorix_app/Features/community/presentation/views/post_details_view.dart';
import 'package:thalorix_app/Features/home/presentation/widgets/bottom_nav_bar.dart';
import 'package:thalorix_app/Features/marketplace/presentation/pages/market_Place_view.dart';
import 'package:thalorix_app/Features/profile/domain/repo/user_repo.dart';
import 'package:thalorix_app/Features/profile/presentation/cubit/cubit/user_update_cubit.dart';
import 'package:thalorix_app/Features/security/domain/security_repo.dart';
import 'package:thalorix_app/Features/security/presentation/bloc/cubit/security_settings_cubit.dart';
import 'package:thalorix_app/Features/security/presentation/security_settings_screen.dart';
import 'package:thalorix_app/Features/splash/presentation/splash_view.dart';
import 'package:thalorix_app/Features/profile/presentation/edit_profile_screen.dart';
import 'package:thalorix_app/Features/auth/data/data_sources/otp_remote_data_source.dart';
import 'package:thalorix_app/Features/auth/data/repositories/otp_repository_impl.dart';
import 'package:thalorix_app/Features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:thalorix_app/Features/auth/domain/usecases/resend_otp_usecase.dart';
import 'package:thalorix_app/Features/cart/presentation/pages/cart_screen.dart';
import 'package:thalorix_app/Features/cart/presentation/pages/check_my_order_screen.dart';
import 'package:thalorix_app/Features/cart/domain/entities/order_entity.dart';
import 'package:thalorix_app/core/cache/cache_helper.dart';

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
  static const String chatsScreen = '/ChatsScreen';
  static const String marketPlace = '/marketPlace';
  static const String community = '/community';
  static const String cart = '/cart';
  static const String checkMyOrder = '/checkMyOrder';
  static const String security = '/security';
  static const String createPost = '/createPost';
  static const String postDetails = '/postDetails';
  static const String aiChat = '/aiChat';
}

CommunityCubit _createCommunityCubit() {
  final repo = CommunityRepositoryImpl(CommunityRemoteDataSource());
  return CommunityCubit(
    getFeedUseCase: GetFeedUseCase(repo),
    createPostUseCase: CreatePostUseCase(repo),
    updatePostUseCase: UpdatePostUseCase(repo),
    deletePostUseCase: DeletePostUseCase(repo),
  );
}

/// Helper to create AiChatCubit with all dependencies
AiChatCubit _createAiChatCubit() {
  final remoteDataSource = AiChatRemoteDataSource();
  final localDataSource = AiChatLocalDataSource(CacheHelper.prefs);
  final repo = AiChatRepositoryImpl(remoteDataSource, localDataSource);
  return AiChatCubit(
    createProjectUseCase: CreateProjectUseCase(repo),
    getProjectUseCase: GetProjectUseCase(repo),
    editProjectUseCase: EditProjectUseCase(repo),
    uploadFileUseCase: UploadFileUseCase(repo),
    localDataSource: localDataSource,
  );
}

class AppRouter {
  static String? userId = CacheHelper.getUserId();
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => LoginView(),
        );
      case Routes.home:
        final int initialIndex = (settings.arguments as int?) ?? 0;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => HomeView(initialIndex: initialIndex),
        );
      case Routes.signup:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const SignupView(),
        );
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.verification:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            final otpRepo = OtpRepositoryImpl(OtpRemoteDataSource());
            return BlocProvider(
              create: (context) =>
                  OtpCubit(VerifyOtpUseCase(otpRepo), ResendOtpUseCase(otpRepo))
                    ..startTimer(),
              child: const Verifiction(),
            );
          },
        );
      case Routes.forgotPassword:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const ForgetPasswordScreen(),
        );
      case Routes.marketPlace:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const MarketPlaceView(),
        );
      case Routes.codeGenerate:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const CodeGenerationView(),
        );
      case Routes.codeGenerateprogress:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const CodeGenerationProgressPage(),
        );
      case Routes.editProfile:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => UserCubit(UserRepository()),
            child: EditProfileScreen(userId: userId ?? " "),
          ),
        );
      case Routes.chatsScreen:
        return MaterialPageRoute(builder: (_) => ChatsScreen());
      case Routes.community:
        return MaterialPageRoute(builder: (_) => const CommunityView());
      case Routes.security:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => UserCubit(UserRepository())),
              BlocProvider(
                create: (_) => SecuritySettingsCubit(SecurityRepo()),
              ),
            ],

            child: SecuritySettingsScreen(userId: userId ?? " "),
          ),
        );
      // ==================== Community Routes ====================

      case Routes.createPost:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => _createCommunityCubit(),
            child: const CreatePostView(),
          ),
        );

      case Routes.postDetails:
        final post = settings.arguments as PostModel;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => PostDetailsView(post: post),
        );

      // ==================== AI Chat Route ====================
      case Routes.aiChat:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => _createAiChatCubit(),
            child: const AiChatView(),
          ),
        );

      case Routes.cart:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const CartScreen(),
        );
      case Routes.checkMyOrder:
        final order = settings.arguments as OrderEntity;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => CheckMyOrderScreen(order: order),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}

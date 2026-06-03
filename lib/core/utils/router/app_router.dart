import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thalorix_app/Features/auth/presentation/cubit/otp_cubit/otp_cubit.dart';
import 'package:thalorix_app/Features/auth/presentation/pages/forgot_password/forgot_password.dart';
import 'package:thalorix_app/Features/auth/presentation/pages/login/login_view.dart';
import 'package:thalorix_app/Features/auth/presentation/pages/SignUp/signup_view.dart';
import 'package:thalorix_app/Features/auth/presentation/pages/verifiction/Verifiction.dart';
import 'package:thalorix_app/Features/chats/presentation/chats_screen.dart';
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
import 'package:thalorix_app/Features/splash/presentation/splash_view.dart';
import 'package:thalorix_app/Features/profile/presentation/edit_profile_screen.dart';
import 'package:thalorix_app/Features/auth/data/data_sources/otp_remote_data_source.dart';
import 'package:thalorix_app/Features/auth/data/repositories/otp_repository_impl.dart';
import 'package:thalorix_app/Features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:thalorix_app/Features/auth/domain/usecases/resend_otp_usecase.dart';
import 'package:thalorix_app/Features/ai_chat/data/data_sources/ai_chat_remote_data_source.dart';
import 'package:thalorix_app/Features/ai_chat/data/data_sources/ai_chat_local_data_source.dart';
import 'package:thalorix_app/Features/ai_chat/data/repositories/ai_chat_repository_impl.dart';
import 'package:thalorix_app/Features/ai_chat/domain/usecases/create_project_usecase.dart';
import 'package:thalorix_app/Features/ai_chat/domain/usecases/edit_project_usecase.dart';
import 'package:thalorix_app/Features/ai_chat/domain/usecases/get_project_usecase.dart';
import 'package:thalorix_app/Features/ai_chat/domain/usecases/upload_file_usecase.dart';
import 'package:thalorix_app/Features/ai_chat/presentation/cubit/ai_chat_cubit.dart';
import 'package:thalorix_app/Features/ai_chat/presentation/views/ai_chat_view.dart';
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
  static const String ChatsScreen = '/ChatsScreen';
  static const String marketPlace = '/marketPlace';
  static const String community = '/community';
  static const String createPost = '/createPost';
  static const String postDetails = '/postDetails';
  static const String aiChat = '/aiChat';
}

/// Helper to create CommunityCubit with all dependencies
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

      // ==================== Community Routes ====================
      case Routes.community:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => _createCommunityCubit()..getFeed(),
            child: const CommunityView(),
          ),
        );

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

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}

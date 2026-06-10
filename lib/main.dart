import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:thalorix_app/Features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:thalorix_app/Features/auth/data/repositories/auth_repository_impl.dart';
import 'package:thalorix_app/Features/auth/domain/usecases/login_usecase.dart';
import 'package:thalorix_app/Features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:thalorix_app/Features/auth/presentation/cubit/auth_cubit.dart';
import 'package:thalorix_app/core/cache/cache_helper.dart';
import 'package:thalorix_app/core/utils/constants/supabase_data.dart';
import 'package:thalorix_app/core/utils/router/app_router.dart';
import 'package:thalorix_app/core/network/dio_helper.dart';
import 'package:thalorix_app/Features/cart/presentation/cubit/cart_cubit.dart';
import 'package:thalorix_app/Features/cart/dependency_injection/cart_di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: SupabaseData.url,
    anonKey: SupabaseData.anonKey,
  );
  await CacheHelper.init();
  DioHelper.init();
  final AppRouter myRouter = AppRouter();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) {
            final repo = AuthRepositoryImpl(AuthRemoteDataSource());
            return AuthCubit(SignUpUseCase(repo), LoginUseCase(repo));
          },
        ),
        BlocProvider<CartCubit>(
          create: (context) => CartDI.provideCartCubit()..getMyOrders(),
        ),
      ],
      child: Thalorix(appRouter: myRouter),
    ),
  );
}

class Thalorix extends StatelessWidget {
  final AppRouter appRouter;
  const Thalorix({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.login,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}

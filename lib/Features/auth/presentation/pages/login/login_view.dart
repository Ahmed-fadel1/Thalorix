import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thalorix_app/Features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:thalorix_app/Features/auth/data/repositories/auth_repository_impl.dart';
import 'package:thalorix_app/Features/auth/domain/usecases/login_usecase.dart';
import 'package:thalorix_app/Features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:thalorix_app/Features/auth/presentation/cubit/auth_cubit.dart';
import 'package:thalorix_app/Features/auth/presentation/cubit/auth_state.dart';
import 'package:thalorix_app/Features/auth/presentation/widgets/Icon_Text_Button.dart';
import 'package:thalorix_app/Features/auth/presentation/widgets/auth_text_field.dart';
import 'package:thalorix_app/Features/auth/presentation/widgets/primary_button.dart';
import 'package:thalorix_app/core/utils/Colors/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:thalorix_app/core/utils/router/app_router.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) {
        final repo = AuthRepositoryImpl(AuthRemoteDataSource());
        return AuthCubit(
          SignUpUseCase(repo),
          LoginUseCase(repo),
        );
      },
      child: Builder(
        builder: (context) {
          final cubit = AuthCubit.get(context);
          return BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess && state.process == AuthProcess.login) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message ?? "Login successful"),
                    backgroundColor: Colors.green,
                  ),
                );
                
                Navigator.pushReplacementNamed(context, Routes.home);
              }

              if (state is AuthError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: Scaffold(
              body: Container(
                height: size.height,
                width: size.width,
                color: AppColors.background,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    double localheight = constraints.maxHeight;
                    double localwidth = constraints.maxWidth;
                    return SafeArea(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: localheight * 0.08,
                                  width: localwidth * 0.17,
                                  decoration: BoxDecoration(
                                    color: AppColors.iconbutton,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset("assets/icons/arrow.svg"),
                                  ),
                                ),
                              ),
                              const Text(
                                "Login",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 29,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Welcome back! Please login to continue",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.welcome_text,
                                  height: 1.5,
                                ),
                              ),
                              SizedBox(height: localheight * 0.03),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Email",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              AuthTextField(
                                controller: cubit.emailController,
                                hint: "Enter your email",
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SvgPicture.asset("assets/icons/email.svg"),
                                ),
                                obscureText: false,
                                keyboardType: TextInputType.emailAddress,
                              ),
                              const SizedBox(height: 24),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Password",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              AuthTextField(
                                controller: cubit.passwordController,
                                hint: "Enter your password",
                                obscureText: true,
                                keyboardType: TextInputType.visiblePassword,
                                suffixIcon: const Icon(Icons.lock_outline, color: AppColors.iconbutton),
                              ),
                              SizedBox(height: localheight * 0.01),
                              Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, Routes.forgotPassword);
                                  },
                                  child: Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: AppColors.welcome_text,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              BlocBuilder<AuthCubit, AuthState>(
                                builder: (context, state) {
                                  if (state is AuthLoading && state.process == AuthProcess.login) {
                                    return const Center(child: CircularProgressIndicator());
                                  }
                                  return PrimaryButton(
                                    height: localheight * 0.07,
                                    text: "Login",
                                    backgroundColor: AppColors.iconbutton,
                                    textColor: Colors.white,
                                    onTap: () {
                                      cubit.login();
                                    },
                                  );
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Don't have an account?",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: AppColors.welcome_text,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(context, Routes.signup);
                                      },
                                      child: Text(
                                        " Sign up",
                                        style: TextStyle(
                                          fontSize: 19,
                                          color: AppColors.iconbutton,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 45),
                              Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      color: AppColors.border,
                                      thickness: 1,
                                      height: 1,
                                      indent: 1,
                                      endIndent: 8,
                                    ),
                                  ),
                                  Text(
                                    "OR With",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.welcome_text,
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: AppColors.border,
                                      thickness: 1,
                                      height: 1,
                                      indent: 10,
                                      endIndent: 16,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 40),
                              IconTextButton(
                                height: localheight * 0.06,
                                text: "Sign with Google",
                                iconPath: "assets/icons/google_account.svg",
                                borderColor: AppColors.iconbutton,
                                textColor: AppColors.iconbutton,
                                onTap: () {},
                              ),
                              const SizedBox(height: 12),
                              IconTextButton(
                                height: localheight * 0.06,
                                text: "Sign with Apple",
                                iconPath: "assets/icons/apple_account.svg",
                                borderColor: AppColors.iconbutton,
                                textColor: AppColors.iconbutton,
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

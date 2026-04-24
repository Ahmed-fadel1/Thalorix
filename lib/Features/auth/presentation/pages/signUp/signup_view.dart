import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thalorix_app/Features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:thalorix_app/Features/auth/data/repositories/auth_repository_impl.dart';
import 'package:thalorix_app/Features/auth/domain/usecases/login_usecase.dart';
import 'package:thalorix_app/Features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:thalorix_app/Features/auth/presentation/cubit/auth_cubit.dart';
import 'package:thalorix_app/Features/auth/presentation/cubit/auth_state.dart';
import 'package:thalorix_app/Features/auth/presentation/widgets/auth_text_field.dart';
import 'package:thalorix_app/Features/auth/presentation/widgets/primary_button.dart';
import 'package:thalorix_app/core/utils/Colors/app_colors.dart';
import 'package:thalorix_app/core/utils/router/app_router.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  bool termsAccepted = false;

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
          var cubit = AuthCubit.get(context);
          return BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }

              if (state is AuthSuccess && state.process == AuthProcess.signup) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.green.shade600,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.all(16),
                    content: Row(
                      children: const [
                        Icon(Icons.check_circle, color: Colors.white),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text("Account created successfully"),
                        ),
                      ],
                    ),
                  ),
                );
                Future.delayed(const Duration(milliseconds: 800), () {
                  Navigator.pushReplacementNamed(context, Routes.login);
                });
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
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () => Navigator.pop(context),
                                    child: Container(
                                      height: localwidth * 0.08,
                                      width: localwidth * 0.08,
                                      margin: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.splashPrimary,
                                        ),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Center(
                                        child: SvgPicture.asset(
                                          "assets/icons/arrow_back.svg",
                                          color: AppColors.splashPrimary,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: localwidth * 0.26),
                                  Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      color: AppColors.iconbutton,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: localheight * 0.03),
                              Text(
                                "Full Name",
                                style: TextStyle(
                                  color: AppColors.iconbutton,
                                  fontSize: 20,
                                ),
                              ),
                              AuthTextField(
                                controller: cubit.nameController,
                                hint: "Enter your full name",
                                keyboardType: TextInputType.name,
                                obscureText: false,
                                hintstyle: AppColors.border,
                              ),
                              SizedBox(height: localheight * 0.03),
                              Text(
                                "Email or phone",
                                style: TextStyle(
                                  color: AppColors.iconbutton,
                                  fontSize: 20,
                                ),
                              ),
                              AuthTextField(
                                controller: cubit.emailController,
                                hint: "Enter your email or phone",
                                keyboardType: TextInputType.emailAddress,
                                obscureText: false,
                                hintstyle: AppColors.border,
                              ),
                              SizedBox(height: localheight * 0.03),
                              Text(
                                "Password",
                                style: TextStyle(
                                  color: AppColors.iconbutton,
                                  fontSize: 20,
                                ),
                              ),
                              AuthTextField(
                                controller: cubit.passwordController,
                                prefixIcon: const Icon(Icons.lock_rounded),
                                hint: "Enter your password",
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: true,
                                hintstyle: AppColors.border,
                              ),
                              SizedBox(height: localheight * 0.03),
                              Text(
                                "Confirm Password",
                                style: TextStyle(
                                  color: AppColors.iconbutton,
                                  fontSize: 20,
                                ),
                              ),
                              AuthTextField(
                                controller: cubit.confirmPasswordController,
                                hint: "Confirm your password",
                                hintstyle: AppColors.border,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: true,
                                prefixIcon: const Icon(Icons.lock_rounded),
                                prefixIconColor: AppColors.border,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10.0,
                                ),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "(Complex,8+chars)",
                                    style: TextStyle(
                                      color: AppColors.welcome_text,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                              AuthTextField(
                                controller: cubit.phoneController,
                                hint: "phone number",
                                hintstyle: AppColors.border,
                                keyboardType: TextInputType.phone,
                                obscureText: false,
                                prefixIcon: const Icon(Icons.phone_android_rounded),
                                prefixIconColor: AppColors.border,
                              ),
                              SizedBox(height: localheight * 0.05),
                              Row(
                                children: [
                                  Checkbox(
                                    value: termsAccepted,
                                    onChanged: (value) {
                                      setState(() {
                                        termsAccepted = value ?? false;
                                      });
                                    },
                                    checkColor: Colors.white,
                                    activeColor: AppColors.splashPrimary,
                                  ),
                                  Expanded(
                                    child: Text.rich(
                                      TextSpan(
                                        text: "I agree to the terms of services & privacy policy",
                                        style: TextStyle(
                                          color: AppColors.splashPrimary,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: localheight * 0.03),
                              BlocBuilder<AuthCubit, AuthState>(
                                builder: (context, state) {
                                  if (state is AuthLoading && state.process == AuthProcess.signup) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  return PrimaryButton(
                                    text: "Register",
                                    onTap: () {
                                      if (!termsAccepted) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text("Please accept terms & conditions")),
                                        );
                                        return;
                                      }
                                      cubit.signUp();
                                    },
                                    height: localheight * 0.07,
                                    backgroundColor: AppColors.iconbutton,
                                    textColor: Colors.white,
                                  );
                                },
                              ),
                              SizedBox(height: localheight * 0.05),
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

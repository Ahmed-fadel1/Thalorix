import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thalorix_app/Features/auth/presentation/cubit/auth_cubit.dart';
import 'package:thalorix_app/Features/auth/presentation/cubit/auth_state.dart';
import 'package:thalorix_app/Features/auth/presentation/pages/forgot_password/email_password.dart';
import 'package:thalorix_app/Features/auth/presentation/widgets/auth_text_field.dart';
import 'package:thalorix_app/Features/auth/presentation/widgets/primary_button.dart';
import 'package:thalorix_app/core/utils/Colors/app_colors.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final authCubit = AuthCubit.get(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is AuthSuccess &&
              state.process == AuthProcess.forgotPassword) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message ?? "OTP sent successfully"),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ResetPasswordScreen()),
            );
          }
        },
        builder: (context, state) {
          bool isLoading =
              state is AuthLoading && state.process == AuthProcess.forgotPassword;

          return SizedBox(
            height: size.height,
            width: size.width,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.splashPrimary,
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              "assets/icons/arrow_back.svg",
                              color: AppColors.splashPrimary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Forgot Password',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.splashPrimary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Enter your email address to receive a verification code for password reset.',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.welcome_text,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 30),
                      AuthTextField(
                        hint: "Enter your email",
                        borderColor: AppColors.splashPrimary,
                        controller: authCubit.emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: validateEmail,
                      ),
                      const SizedBox(height: 40),
                      isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.splashPrimary,
                              ),
                            )
                          : PrimaryButton(
                              height: 50,
                              text: "Continue",
                              backgroundColor: AppColors.splashPrimary,
                              textColor: Colors.white,
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  authCubit.forgotPassword();
                                }
                              },
                            ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thalorix_app/Features/auth/presentation/cubit/auth_cubit.dart';
import 'package:thalorix_app/Features/auth/presentation/cubit/auth_state.dart';
import 'package:thalorix_app/Features/auth/presentation/pages/login/login_view.dart';
import 'package:thalorix_app/Features/auth/presentation/widgets/auth_text_field.dart';
import 'package:thalorix_app/Features/auth/presentation/widgets/primary_button.dart';
import 'package:thalorix_app/core/utils/Colors/app_colors.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController codeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? validateCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Verification code is required';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'At least 8 characters';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Add at least one uppercase letter';
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Add at least one lowercase letter';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Add at least one number';
    }
    return null;
  }

  String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
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
              state.process == AuthProcess.resetPassword) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message ?? "Password reset successfully"),
                backgroundColor: Colors.green,
              ),
            );
            // Navigate to Login after success
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginView()),
              (Route<dynamic> route) => false,
            );
          }
        },
        builder: (context, state) {
          bool isLoading =
              state is AuthLoading && state.process == AuthProcess.resetPassword;

          return SizedBox(
            height: size.height,
            width: size.width,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
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
                          'Reset Password',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.splashPrimary,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Enter the verification code sent to ${authCubit.lastEmail ?? "your email"} and your new password.',
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.welcome_text,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 30),
                        AuthTextField(
                          hint: "Verification Code",
                          borderColor: AppColors.splashPrimary,
                          controller: codeController,
                          keyboardType: TextInputType.text,
                          validator: validateCode,
                        ),
                        const SizedBox(height: 16),
                        AuthTextField(
                          hint: "New Password",
                          borderColor: AppColors.splashPrimary,
                          controller: authCubit.passwordController,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          validator: validatePassword,
                        ),
                        const SizedBox(height: 16),
                        AuthTextField(
                          hint: "Confirm Password",
                          borderColor: AppColors.splashPrimary,
                          controller: authCubit.confirmPasswordController,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) => validateConfirmPassword(
                            value,
                            authCubit.passwordController.text,
                          ),
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
                                text: "Reset Password",
                                backgroundColor: AppColors.splashPrimary,
                                textColor: Colors.white,
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    authCubit.resetPassword(
                                        code: codeController.text.trim());
                                  }
                                },
                              ),
                        const SizedBox(height: 16),
                        if (!isLoading)
                          PrimaryButton(
                            height: 50,
                            text: "Cancel",
                            backgroundColor: AppColors.gery,
                            textColor: AppColors.splashPrimary,
                            onTap: () => Navigator.pop(context),
                          ),
                      ],
                    ),
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

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thalorix_app/Features/auth/presentation/widgets/auth_text_field.dart';
import 'package:thalorix_app/Features/auth/presentation/widgets/primary_button.dart';
import 'package:thalorix_app/core/utils/Colors/app_colors.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({super.key});

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// validator method
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
    if (!RegExp(r'[!@#\$&*~%^]').hasMatch(value)) {
      return 'Add at least one special character';
    }
    return null; // valid
  }

  String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null; // valid
  }@override
void dispose() {
  passwordController.dispose();
  confirmPasswordController.dispose();
  super.dispose();
}

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: size.height,
        width: size.width,

        child: LayoutBuilder(
          builder: (context, constraints) {
            double localheight = constraints.maxHeight;
            double localwidth = constraints.maxWidth;
            return SafeArea(
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
                          height: localheight * 0.08,
                          width: localwidth * 0.08,

                          margin: const EdgeInsets.all(8),
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
                      const SizedBox(width: 15),
                      const Text(
                        'Enter Your Email to Reset \nPassword',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.splashPrimary,
                        ),
                      ),
                      const SizedBox(height: 48),
                      AuthTextField(
                        hint: "Enter your password",
                        borderColor: AppColors.splashPrimary,
                        controller: passwordController,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        validator: validatePassword,
                      ),
                      const SizedBox(height: 16),
                      AuthTextField(
                        hint: "Confirm your password",
                        borderColor: AppColors.splashPrimary,
                        controller: confirmPasswordController,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) => validateConfirmPassword(
                          value,
                          passwordController.text,
                        ),
                      ),
                      const SizedBox(height: 107),
                      PrimaryButton(
                        height: 50,
                        text: "Reset Password",
                        backgroundColor: AppColors.splashPrimary,
                        textColor: Colors.white,
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            String password = passwordController.text;

                            log("Password: $password");

                            /// هنا هنبعت OTP أو API
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      PrimaryButton(
                        height: 50,
                        text: "cancel",
                        backgroundColor: AppColors.gery,
                        textColor: AppColors.splashPrimary,
                        onTap: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:thalorix_app/Features/auth/presentation/widgets/Icon_Text_Button.dart';
import 'package:thalorix_app/Features/auth/presentation/widgets/auth_text_field.dart';
import 'package:thalorix_app/Features/auth/presentation/widgets/primary_button.dart';
import 'package:thalorix_app/core/utils/Colors/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:thalorix_app/core/utils/router/app_router.dart';

class LoginView extends StatefulWidget {
  LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
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
                      Text(
                        "Login",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 29,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                        controller: emailController,
                        hint: "Enter your email",
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset("assets/icons/email.svg"),
                        ),
                        obscureText: false,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                        controller: passwordController,

                        hint: "Enter your password",
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                          icon: obscureText
                              ? Icon(
                                  Icons.visibility_off,
                                  color: AppColors.iconbutton,
                                )
                              : Icon(
                                  Icons.visibility,
                                  color: AppColors.iconbutton,
                                ),
                        ),
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
                      SizedBox(height: 16),

                      PrimaryButton(
                        height: localheight * 0.07,
                        text: "Login",
                        backgroundColor: AppColors.iconbutton,
                        textColor: Colors.white,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Routes.login,
                          ); // login action
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
                      SizedBox(height: 45),
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
                      SizedBox(height: 40),

                      IconTextButton(
                        height: localheight * 0.06,
                        text: "Sign with Google",
                        iconPath: "assets/icons/google_account.svg",
                        borderColor: AppColors.iconbutton, // نفس اللون
                        textColor: AppColors.iconbutton, // نفس اللون
                        onTap: () {},
                      ),

                      SizedBox(height: 12),
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
    );
  }
}

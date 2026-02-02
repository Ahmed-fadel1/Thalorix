import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thalorix_app/Features/auth/presentation/widgets/auth_text_field.dart';
import 'package:thalorix_app/Features/auth/presentation/widgets/primary_button.dart';
import 'package:thalorix_app/core/utils/Colors/app_colors.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

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
                                border: BoxBorder.all(
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
                        hint: "Confirm your password",
                        hintstyle: AppColors.border,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        prefixIcon: Icon(Icons.lock_rounded),
                        prefixIconColor: AppColors.border,
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
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
                      SizedBox(height: localheight * 0.1),

                  
                      Row(
                        children: [
                          Checkbox(
                            value: false,
                            onChanged: (value) {},
                            checkColor: AppColors.splashPrimary,
                            activeColor: AppColors.splashPrimary,
                          ),
                          Text.rich(
                            TextSpan(
                              text:
                                  "\nI agree to the \nterms of services & privacy policy",
                              style: TextStyle(
                                color: AppColors.splashPrimary,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: localheight * 0.01),

                      PrimaryButton(
                        text: "Register",
                        onTap: () {},
                        height: localheight * 0.07,
                        backgroundColor: AppColors.iconbutton,
                        textColor: Colors.white,
                      ),
                      SizedBox(height: localheight * 0.1),
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

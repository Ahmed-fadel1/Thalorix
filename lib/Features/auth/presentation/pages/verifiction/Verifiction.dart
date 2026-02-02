import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thalorix_app/Features/auth/presentation/pages/forgot_password/forgot_password.dart';
import 'package:thalorix_app/Features/auth/presentation/widgets/otp_input.dart';
import 'package:thalorix_app/Features/auth/presentation/widgets/primary_button.dart';
import 'package:thalorix_app/core/utils/Colors/app_colors.dart';
import 'package:thalorix_app/core/utils/router/app_router.dart';

class Verifiction extends StatefulWidget {
  const Verifiction({super.key});

  @override
  State<Verifiction> createState() => _VerifictionState();
}

class _VerifictionState extends State<Verifiction> {
  String _otpCode = "";
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
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              height: localwidth * 0.08,
                              width: localwidth * 0.08,
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.background,
                  
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
                        ],
                      ),
                  
                      const Text(
                        "Verification Email",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1C3A3E),
                        ),
                      ),
                  
                      const SizedBox(height: 8),
                  
                      /// Subtitle
                      const Text(
                        "please enter the code we just sent to email",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                  
                      const SizedBox(height: 4),
                  
                      const Text(
                        "rigggyyxxx@gmail.com",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF1C3A3E),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                  
                      const SizedBox(height: 30),
                  
                      OtpInputWidget(
                        activeBorderColor: Color.fromARGB(255, 86, 124, 129),
                        onCodeChanged: (code) {
                          setState(() {
                            _otpCode = code;
                          });
                          print("the code is: $code");
                        },
                        onCompleted: (code) {
                          print("the end code is: $code");
                         
                        },
                      ),
                      SizedBox(height: localheight * 0.08),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "if you didn't receive a code? ",
                            style: TextStyle(color: Colors.grey),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              "Resend",
                              style: TextStyle(
                                color: Color(0xFF1C3A3E),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Text(
                        "Code expires in 01:56",
                        style: TextStyle(fontSize: 13, color: Colors.red),
                      ),
                  
                      const SizedBox(height: 30),
                      PrimaryButton(
                        height: localheight * 0.07,
                        text: "Continue",
                        backgroundColor: AppColors.splashPrimary,
                        textColor: AppColors.background,
                        onTap: () => Navigator.pushNamed(context,Routes.forgotPassword,),
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thalorix_app/Features/auth/presentation/cubit/otp_cubit/otp_cubit.dart';
import 'package:thalorix_app/Features/auth/presentation/cubit/otp_cubit/otp_state.dart';
import 'package:thalorix_app/Features/auth/presentation/widgets/otp_input.dart';
import 'package:thalorix_app/Features/auth/presentation/widgets/primary_button.dart';
import 'package:thalorix_app/core/utils/Colors/app_colors.dart';
import 'package:thalorix_app/core/utils/router/app_router.dart';

class Verifiction extends StatelessWidget {
  const Verifiction({super.key});

  @override
  Widget build(BuildContext context) {
    final email =
        ModalRoute.of(context)?.settings.arguments as String? ?? "No Email";
    var size = MediaQuery.of(context).size;
    final cubit = OtpCubit.get(context);

    return BlocConsumer<OtpCubit, OtpState>(
      listener: (context, state) {
        if (state is OtpError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        } else if (state is OtpSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Email verified successfully!"),
              backgroundColor: Colors.green,
            ),
          );
          
          Navigator.pushNamed(context, Routes.login);
        }
      },
      builder: (context, state) {
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
                          const Text(
                            "please enter the code we just sent to email",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            email,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF1C3A3E),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 30),
                          OtpInputWidget(
                            length: 6,
                            activeBorderColor: const Color.fromARGB(
                              255,
                              86,
                              124,
                              129,
                            ),
                            onCodeChanged: (code) {
                              cubit.setOtp(code);
                            },
                            onCompleted: (code) {
                              cubit.verifyOtp(email: email, code: code);
                            },
                          ),
                          SizedBox(height: localheight * 0.08),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "if you didn't receive a code? ",
                                style: TextStyle(color: Colors.grey),
                              ),
                              InkWell(
                                onTap: cubit.seconds == 0
                                    ? () => cubit.resendOtp(email)
                                    : null,
                                child: Text(
                                  "Resend",
                                  style: TextStyle(
                                    color: cubit.seconds == 0
                                        ? const Color(0xFF1C3A3E)
                                        : Colors.grey,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Code expires in ${cubit.formattedTime}",
                            style: TextStyle(
                              fontSize: 13,
                              color: cubit.seconds == 0
                                  ? Colors.grey
                                  : Colors.red,
                            ),
                          ),
                          const SizedBox(height: 30),
                          PrimaryButton(
                            height: localheight * 0.07,
                            text: state is OtpLoading
                                ? "Verifying..."
                                : "Continue",
                            backgroundColor: state is OtpLoading
                                ? Colors.grey
                                : AppColors.splashPrimary,
                            textColor: AppColors.background,
                            onTap: (state is OtpLoading || !cubit.isOtpComplete)
                                ? null
                                : () => cubit.verifyOtp(
                                    email: email,
                                    code: cubit.otpCode,
                                  ),
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
      },
    );
  }
}

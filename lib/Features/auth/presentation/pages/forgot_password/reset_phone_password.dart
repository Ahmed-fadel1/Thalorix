import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thalorix_app/Features/auth/presentation/widgets/auth_text_field.dart';
import 'package:thalorix_app/Features/auth/presentation/widgets/primary_button.dart';
import 'package:thalorix_app/core/utils/Colors/app_colors.dart';

class ResetPhonePassword extends StatefulWidget {
  const ResetPhonePassword({super.key});

  @override
  State<ResetPhonePassword> createState() => _ResetPhonePasswordState();
}

class _ResetPhonePasswordState extends State<ResetPhonePassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController phonenumberController = TextEditingController();
  String? validatePhoneNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Phone number is required';
  }
  if (!RegExp(r'^\+?[0-9]{7,15}$').hasMatch(value)) {
    return 'Enter a valid phone number';
  }
  return null; 
}
void dispose() {
  phonenumberController.dispose();
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
                        hint: "Add your phone number",
                        borderColor: AppColors.splashPrimary,
                        controller: phonenumberController,
                        obscureText: true,
                        keyboardType: TextInputType.phone,
                        validator: validatePhoneNumber

                        
                      ),
                      
                      const SizedBox(height: 107),
                      PrimaryButton(
                        height: 50,
                        text: "continue",
                        backgroundColor: AppColors.splashPrimary,
                        textColor: Colors.white,
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            String phone = phonenumberController.text;
                           log("Phone number is valid: $phone");
                            

                           
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
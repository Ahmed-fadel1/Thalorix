import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thalorix_app/Features/auth/presentation/pages/forgot_password/email_password.dart';
import 'package:thalorix_app/Features/auth/presentation/pages/forgot_password/reset_phone_password.dart';
import 'package:thalorix_app/core/utils/Colors/app_colors.dart';
import 'package:thalorix_app/core/utils/router/app_router.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
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
                      'Forgot Password',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.splashPrimary,
                      ),
                    ),
                    Text(
                      'Select which contact details should we use to\n reset your password',

                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.welcome_text,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 30),
                    _buildOptionCard(
                      value: 'Email',
                      icon: Icons.email_outlined,
                      title: 'Email',
                      subtitle: 'Send to yor email',
                    ),
                    const SizedBox(height: 16),
                    _buildOptionCard(
                      value: 'phone',
                      icon: Icons.phone_outlined,
                      title: 'Phone Number',
                      subtitle: 'Send to yor phone number',
                    ),
                    const SizedBox(height: 30),
                    _buildContinueButton(context),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildOptionCard({
    required String value,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final bool isSelected = _selectedOption == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedOption = value;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.splashPrimary : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.splashPrimary : Colors.grey.shade200,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF2ecc71)
                    : Colors.grey.shade200,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : Colors.grey.shade600,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isSelected
                          ? const Color(0xFF2ecc71)
                          : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),

            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: Color(0xFF2ecc71),
                size: 24,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          if (_selectedOption == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Please select an option'),
                backgroundColor: Colors.red,
              ),
            );
          } else {
            if (_selectedOption == 'Email') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const EmailScreen()),
              );
            } else if (_selectedOption == 'phone') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ResetPhonePassword(),
                ),
              );
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.splashPrimary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: const Text(
          'Continue',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

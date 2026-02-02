import 'package:flutter/material.dart';
import 'package:thalorix_app/core/utils/Colors/app_colors.dart';

class AuthTextField extends StatelessWidget {
  final String hint;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final Color? hintstyle;
  final Color ?suffixIconColor;
  final Color ?prefixIconColor;
  const AuthTextField({
    super.key,
    required this.hint,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.hintstyle,
    this.suffixIconColor,
    this.prefixIconColor

  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: hintstyle,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 13,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
            borderSide:  BorderSide(
        color: AppColors.border, 
        width: 1,
      ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
            borderSide:  BorderSide(
              
            
              color: Color(0xFF2F6F73),
        width: 1,
      ),
        ),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        suffixIconColor: suffixIconColor,
        prefixIconColor: prefixIconColor
      ),
    );
  }
}

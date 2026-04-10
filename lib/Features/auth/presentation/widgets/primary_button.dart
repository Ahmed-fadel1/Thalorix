import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final double height;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback? onTap;
  

  const PrimaryButton({
    super.key,
    required this.height,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    this.onTap,

  
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(

              color: textColor,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

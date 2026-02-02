

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpBox extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Color activeBorderColor;
  final Color boxColor;
  final Function(String) onChanged;

  const OtpBox({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.activeBorderColor,
    required this.boxColor,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 65,
      height: 70,
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
        
          color: focusNode.hasFocus ? activeBorderColor : Colors.transparent,
          width: 2,
        ),
      ),
      child: Center(
        child: TextField(
         
          controller: controller,
          focusNode: focusNode,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          keyboardType: TextInputType.number,
          maxLength: 1,
          cursorColor: activeBorderColor,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: const InputDecoration(
            counterText: "",
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
          ),
         
          onChanged: onChanged,
        ),
      ),
    );
  }
}
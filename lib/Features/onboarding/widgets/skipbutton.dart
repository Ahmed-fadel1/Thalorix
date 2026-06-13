import 'package:flutter/material.dart';
import 'package:thalorix_app/core/utils/router/app_router.dart';

Widget skipButton(BuildContext context) {
  return Positioned(
    top: 50,
    right: 20,
    child: GestureDetector(
      onTap: () => Navigator.pushNamed(context, Routes.login),

      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: Color(0xffE0E0E0),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Text(
          'skip',
          style: TextStyle(color: Colors.black, fontSize: 14),
        ),
      ),
    ),
  );
}

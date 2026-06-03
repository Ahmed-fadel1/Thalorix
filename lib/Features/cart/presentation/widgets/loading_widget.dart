import 'package:flutter/material.dart';
import 'package:thalorix_app/core/utils/Colors/app_colors.dart';

class CartLoadingWidget extends StatelessWidget {
  const CartLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: AppColors.teal,
          ),
          SizedBox(height: 16),
          Text(
            'Loading your cart...',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

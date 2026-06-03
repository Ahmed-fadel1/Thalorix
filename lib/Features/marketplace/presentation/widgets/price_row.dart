
  import 'package:flutter/material.dart';
import 'package:thalorix_app/core/utils/Colors/app_colors.dart';

Widget priceRow({
    required String label,
    required String amount,
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 14 : 13,
            fontWeight: isTotal ? FontWeight.w500 : FontWeight.normal,
            color: isTotal ? Colors.black87 : AppColors.textSecondary,
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontSize: isTotal ? 15 : 13,
            fontWeight: isTotal ? FontWeight.w500 : FontWeight.normal,
            color: isTotal ? AppColors.teal : Colors.black87,
          ),
        ),
      ],
    );
  }
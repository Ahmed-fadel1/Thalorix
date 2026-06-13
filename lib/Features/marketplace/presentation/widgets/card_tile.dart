import 'package:flutter/material.dart';
import 'package:thalorix_app/Features/marketplace/presentation/widgets/radio_dot.dart';
import 'package:thalorix_app/core/utils/Colors/app_colors.dart';

Widget cardTile({
  required int index,
  required String brand,
  required Color brandColor,
  required String last4,
  required String expires,
  required bool isSelected,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? AppColors.teal : AppColors.border,
          width: isSelected ? 1.5 : 0.5,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          RadioDot(selected: isSelected),

          const SizedBox(width: 12),

          Container(
            width: 36,
            height: 22,
            decoration: BoxDecoration(
              color: brandColor,
              borderRadius: BorderRadius.circular(4),
            ),
            alignment: Alignment.center,
            child: Text(
              brand,
              style: const TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),

          const SizedBox(width: 12),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '•••• $last4',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Expires $expires',
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
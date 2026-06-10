import 'package:flutter/material.dart';
import 'package:thalorix_app/Features/security/presentation/widgets/custom_label.dart';
import 'package:thalorix_app/Features/security/presentation/widgets/custom_password_field.dart';
import 'package:thalorix_app/Features/security/presentation/widgets/requirement_item.dart';

class PasswordTab extends StatelessWidget {
  final TextEditingController currentPasswordController;
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;
  final bool obscureCurrentPassword;
  final bool obscureNewPassword;
  final bool obscureConfirmPassword;
  final VoidCallback onToggleCurrentPassword;
  final VoidCallback onToggleNewPassword;
  final VoidCallback onToggleConfirmPassword;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const PasswordTab({
    super.key,
    required this.currentPasswordController,
    required this.newPasswordController,
    required this.confirmPasswordController,
    required this.obscureCurrentPassword,
    required this.obscureNewPassword,
    required this.obscureConfirmPassword,
    required this.onToggleCurrentPassword,
    required this.onToggleNewPassword,
    required this.onToggleConfirmPassword,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: 'Current Password', required: true),
          const SizedBox(height: 8),
          CustomPasswordField(
            controller: currentPasswordController,
            hint: 'Enter your current password',
            obscure: obscureCurrentPassword,
            onToggle: onToggleCurrentPassword,
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.info_outline, size: 14, color: Colors.grey.shade500),
              const SizedBox(width: 4),
              Text(
                'Required to verify your identity',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
              ),
            ],
          ),
          const SizedBox(height: 20),
          CustomLabel(label: 'New Password', required: true),
          const SizedBox(height: 8),
          CustomPasswordField(
            controller: newPasswordController,
            hint: 'Enter your new password',
            obscure: obscureNewPassword,
            onToggle: onToggleNewPassword,
          ),
          const SizedBox(height: 20),
          CustomLabel(label: 'Confirm New Password', required: true),
          const SizedBox(height: 8),
          CustomPasswordField(
            controller: confirmPasswordController,
            hint: 'Confirm your new password',
            obscure: obscureConfirmPassword,
            onToggle: onToggleConfirmPassword,
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Password Requirements:',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                RequirementItem(text: 'At least 8 characters'),
                const SizedBox(height: 4),
                RequirementItem(text: 'Contains uppercase and lowercase'),
                const SizedBox(height: 4),
                RequirementItem(text: 'Contains at least one number'),
              ],
            ),
          ),
          const SizedBox(height: 32),
          _buildButtons(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onCancel,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300, width: 1.5),
              ),
              child: const Center(
                child: Text(
                  'cancel',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: GestureDetector(
            onTap: onSave,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF1B3A3A),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  'save changes',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thalorix_app/Features/profile/presentation/cubit/cubit/user_update_cubit.dart';
import 'package:thalorix_app/Features/profile/presentation/cubit/cubit/user_update_state.dart';
import 'package:thalorix_app/Features/security/presentation/bloc/cubit/security_settings_cubit.dart';
import 'package:thalorix_app/Features/security/presentation/widgets/build_buttons.dart';
import 'package:thalorix_app/Features/security/presentation/widgets/email_tab.dart';
import 'package:thalorix_app/Features/security/presentation/widgets/password_tab.dart';

class SecuritySettingsScreen extends StatefulWidget {
  final String userId;

  const SecuritySettingsScreen({super.key, required this.userId});

  @override
  State<SecuritySettingsScreen> createState() => _SecuritySettingsScreenState();
}

class _SecuritySettingsScreenState extends State<SecuritySettingsScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  final _currentPasswordForEmailController = TextEditingController();
  final _newEmailController = TextEditingController();

  final _currentPasswordForPassController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureCurrentForEmail = true;
  bool _obscureCurrentForPass = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  static const Color _primaryColor = Color(0xFF1B3A3A);
  static const Color _backgroundColor = Color(0xFFF5F5F5);
  static const Color _headerBgColor = Color(0xFFD6E4E4);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    _currentPasswordForEmailController.dispose();
    _newEmailController.dispose();
    _currentPasswordForPassController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UserUpdateSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.white),
                  SizedBox(width: 10),
                  Text("Profile updated successfully"),
                ],
              ),
              backgroundColor: Colors.greenAccent[700],
              duration: const Duration(seconds: 3),
            ),
          );
        }
        if (state is UserError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },

      builder: (context, state) {
        return Scaffold(
          backgroundColor: _backgroundColor,
          appBar: AppBar(
            backgroundColor: _backgroundColor,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade300, width: 1.5),
                  ),
                  child: const Icon(
                    Icons.chevron_left,
                    color: Colors.black,
                    size: 22,
                  ),
                ),
              ),
            ),
            title: const Text(
              'Security Settings',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              // Header Card
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _headerBgColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: _primaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.security,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Security Verification Required',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Verify your current password before updating sensitive information.',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // TabBar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      color: _primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black54,
                    labelStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    dividerColor: Colors.transparent,
                    tabs: const [
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.email_outlined, size: 16),
                            SizedBox(width: 6),
                            Text('Update Email'),
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.lock_outline, size: 16),
                            SizedBox(width: 6),
                            Text('Update Pass'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 8),

              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    EmailTab(
                      currentPasswordController:
                          _currentPasswordForEmailController,
                      newEmailController: _newEmailController,
                      obscureCurrentPassword: _obscureCurrentForEmail,
                      onToggleCurrentPassword: () => setState(
                        () =>
                            _obscureCurrentForEmail = !_obscureCurrentForEmail,
                      ),
                      onSave: _onSaveEmail,
                      onCancel: () => Navigator.pop(context),
                    ),
                    BlocConsumer<SecuritySettingsCubit, SecuritySettingsState>(
                      listener: (context, state) {
                        if (state is SecurityUpdatePasswordError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.message),
                              backgroundColor: Colors.redAccent,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                        if (state is SecurityUpdatePasswordSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Password updated successfully!'),
                              backgroundColor: Colors.green,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        return PasswordTab(
                          currentPasswordController:
                              _currentPasswordForPassController,
                          newPasswordController: _newPasswordController,
                          confirmPasswordController: _confirmPasswordController,
                          obscureCurrentPassword: _obscureCurrentForPass,
                          obscureNewPassword: _obscureNewPassword,
                          obscureConfirmPassword: _obscureConfirmPassword,
                          onToggleCurrentPassword: () => setState(
                            () => _obscureCurrentForPass =
                                !_obscureCurrentForPass,
                          ),
                          onToggleNewPassword: () => setState(
                            () => _obscureNewPassword = !_obscureNewPassword,
                          ),
                          onToggleConfirmPassword: () => setState(
                            () => _obscureConfirmPassword =
                                !_obscureConfirmPassword,
                          ),
                          onSave: _onSavePassword,
                          onCancel: () => Navigator.pop(context),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildButtons({required VoidCallback onSave}) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
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
                color: _primaryColor,
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

  void _onSaveEmail() {
    final currentPassword = _currentPasswordForEmailController.text.trim();
    final newEmail = _newEmailController.text.trim();

    if (currentPassword.isEmpty) {
      _showSnackBar('Please enter your current password');
      return;
    }
    if (newEmail.isEmpty) {
      _showSnackBar('Please enter your new email');
      return;
    }
    context.read<UserCubit>().updateUser(
      userId: widget.userId,
      email: newEmail,
    );
  }

  void _onSavePassword() {
    final currentPassword = _currentPasswordForPassController.text.trim();
    final newPassword = _newPasswordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (currentPassword.isEmpty) {
      _showSnackBar('Please enter your current password');
      return;
    }
    if (newPassword.isEmpty) {
      _showSnackBar('Please enter your new password');
      return;
    }
    if (newPassword != confirmPassword) {
      _showSnackBar('Passwords do not match');
      return;
    }

    context.read<SecuritySettingsCubit>().updatePassword(
      userId: widget.userId,
      oldPassword: currentPassword,
      newPassword: newPassword,
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}

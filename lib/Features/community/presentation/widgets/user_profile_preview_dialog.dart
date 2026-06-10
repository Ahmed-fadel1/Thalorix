import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:thalorix_app/core/utils/Colors/app_colors.dart';

/// Shows a beautiful profile preview dialog with the user's avatar and name
/// centered on screen with a blurred backdrop.
void showUserProfilePreview(
  BuildContext context, {
  required String userName,
  String? userAvatar,
  String? userRole,
}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Profile Preview',
    barrierColor: Colors.black.withValues(alpha: 0.5),
    transitionDuration: const Duration(milliseconds: 350),
    pageBuilder: (context, animation, secondaryAnimation) {
      return const SizedBox.shrink();
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutBack,
        reverseCurve: Curves.easeInCubic,
      );

      return BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 6 * animation.value,
          sigmaY: 6 * animation.value,
        ),
        child: ScaleTransition(
          scale: curvedAnimation,
          child: FadeTransition(
            opacity: animation,
            child: Center(
              child: Material(
                color: Colors.transparent,
                child: _ProfilePreviewContent(
                  userName: userName,
                  userAvatar: userAvatar,
                  userRole: userRole,
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

class _ProfilePreviewContent extends StatelessWidget {
  final String userName;
  final String? userAvatar;
  final String? userRole;

  const _ProfilePreviewContent({
    required this.userName,
    this.userAvatar,
    this.userRole,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final avatarSize = screenWidth * 0.4; // 40% of screen width

    return Container(
      width: screenWidth * 0.75,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColors.splashPrimary.withValues(alpha: 0.15),
            blurRadius: 30,
            spreadRadius: 5,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Close button at top right
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.close,
                  size: 20,
                  color: Colors.grey.shade500,
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Avatar - Large circular with border
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.splashPrimary.withValues(alpha: 0.2),
                width: 4,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.splashPrimary.withValues(alpha: 0.15),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: userAvatar != null && userAvatar!.isNotEmpty
                ? CircleAvatar(
                    radius: avatarSize / 2,
                    backgroundImage: NetworkImage(
                      userAvatar!,
                      headers: const {
                        'User-Agent':
                            'Mozilla/5.0 (Linux; Android 13) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Mobile Safari/537.36',
                      },
                    ),
                    onBackgroundImageError: (_, __) {},
                    backgroundColor:
                        AppColors.splashPrimary.withValues(alpha: 0.1),
                  )
                : CircleAvatar(
                    radius: avatarSize / 2,
                    backgroundColor:
                        AppColors.splashPrimary.withValues(alpha: 0.15),
                    child: Text(
                      userName.isNotEmpty ? userName[0].toUpperCase() : '?',
                      style: TextStyle(
                        fontSize: avatarSize * 0.4,
                        fontWeight: FontWeight.bold,
                        color: AppColors.splashPrimary,
                      ),
                    ),
                  ),
          ),

          const SizedBox(height: 20),

          // User Name
          Text(
            userName,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D3B40),
              letterSpacing: 0.3,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          // Role Badge
          if (userRole != null && userRole!.isNotEmpty) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.splashPrimary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.splashPrimary.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Text(
                userRole!,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.splashPrimary,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],

          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

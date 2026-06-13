import 'package:flutter/material.dart';
import 'package:thalorix_app/Features/ai_chat/data/models/ai_message_model.dart';
import 'package:thalorix_app/core/utils/Colors/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:thalorix_app/core/cache/cache_helper.dart';

class MessageBubble extends StatelessWidget {
  final AiMessageModel message;

  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;
    final profilePic = CacheHelper.getProfilePic();

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // AI avatar
          if (!isUser) ...[
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFF00BFA5), Color(0xFF00E5FF)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF00BFA5).withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.auto_awesome,
                  size: 16, color: Colors.white),
            ),
            const SizedBox(width: 8),
          ],

          // Message bubble
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isUser ? const Color(0xFF386B72) : const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18),
                  topRight: const Radius.circular(18),
                  bottomLeft: Radius.circular(isUser ? 18 : 4),
                  bottomRight: Radius.circular(isUser ? 4 : 18),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Loading indicator
                  if (message.isLoading)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: isUser
                                ? Colors.white70
                                : AppColors.splashPrimary,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          message.content,
                          style: TextStyle(
                            color: isUser
                                ? Colors.white70
                                : const Color(0xFF616161),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    )
                  else
                    Text(
                      message.content,
                      style: TextStyle(
                        color: isUser ? Colors.white : const Color(0xFF212121),
                        fontSize: 14.5,
                        height: 1.45,
                      ),
                    ),

                  // Preview URL
                  if (message.previewUrl != null &&
                      message.previewUrl!.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () async {
                        final url = Uri.parse(message.previewUrl!);
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url,
                              mode: LaunchMode.externalApplication);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: AppColors.splashPrimary.withValues(alpha: 0.3)),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.open_in_new,
                                color: AppColors.splashPrimary, size: 18),
                            SizedBox(width: 8),
                            Text(
                              'Open Preview',
                              style: TextStyle(
                                color: AppColors.splashPrimary,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],

                  // Attachments indicator
                  if (message.attachments.isNotEmpty && !message.isLoading) ...[
                    const SizedBox(height: 6),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.attach_file,
                            size: 14,
                            color: isUser
                                ? Colors.white54
                                : const Color(0xFF9E9E9E)),
                        const SizedBox(width: 4),
                        Text(
                          '${message.attachments.length} file(s)',
                          style: TextStyle(
                            fontSize: 11,
                            color: isUser
                                ? Colors.white54
                                : const Color(0xFF9E9E9E),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),

          // User avatar
          if (isUser) ...[
            const SizedBox(width: 8),
            profilePic != null && profilePic.isNotEmpty
                ? CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(profilePic),
                    backgroundColor: Colors.grey[200],
                    onBackgroundImageError: (_, __) {},
                  )
                : Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF386B72),
                    ),
                    child: const Icon(Icons.person, size: 16, color: Colors.white),
                  ),
          ],
        ],
      ),
    );
  }
}

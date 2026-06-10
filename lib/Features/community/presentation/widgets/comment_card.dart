import 'package:flutter/material.dart';
import 'package:thalorix_app/Features/community/data/models/comment_model.dart';
import 'package:thalorix_app/core/utils/Colors/app_colors.dart';

class CommentCard extends StatelessWidget {
  final CommentModel comment;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  const CommentCard({
    super.key,
    required this.comment,
    this.onDelete,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Comment header
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: AppColors.welcome_text.withValues(alpha: 0.3),
                child: Text(
                  comment.authorName.isNotEmpty
                      ? comment.authorName[0].toUpperCase()
                      : '?',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.splashPrimary,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  comment.authorName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: Color(0xFF0D3B40),
                  ),
                ),
              ),
              Text(
                comment.timeAgo,
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
              if (onDelete != null || onEdit != null)
                PopupMenuButton<String>(
                  icon:
                      const Icon(Icons.more_vert, size: 16, color: Colors.grey),
                  onSelected: (value) {
                    if (value == 'edit' && onEdit != null) onEdit!();
                    if (value == 'delete' && onDelete != null) onDelete!();
                  },
                  itemBuilder: (context) => [
                    if (onEdit != null)
                      const PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(Icons.edit, size: 16),
                            SizedBox(width: 8),
                            Text('Edit'),
                          ],
                        ),
                      ),
                    if (onDelete != null)
                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete, size: 16, color: Colors.red),
                            SizedBox(width: 8),
                            Text('Delete',
                                style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                  ],
                ),
            ],
          ),

          const SizedBox(height: 8),

          // Comment content
          Text(
            comment.content,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF0D3B40),
            ),
          ),
        ],
      ),
    );
  }
}

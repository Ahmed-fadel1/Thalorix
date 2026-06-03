import 'package:flutter/material.dart';
import 'package:thalorix_app/Features/community/data/models/post_model.dart';
import 'package:thalorix_app/Features/community/presentation/widgets/user_profile_preview_dialog.dart';
import 'package:thalorix_app/core/cache/cache_helper.dart';
import 'package:thalorix_app/core/utils/Colors/app_colors.dart';

class PostCard extends StatefulWidget {
  final PostModel post;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;
  final int? overrideCommentsCount;

  const PostCard({
    super.key,
    required this.post,
    this.onTap,
    this.onDelete,
    this.onEdit,
    this.overrideCommentsCount,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late bool _isLiked;
  late int _likesCount;

  @override
  void initState() {
    super.initState();
    // Load persisted like state
    _isLiked = CacheHelper.isPostLiked(widget.post.id);
    _likesCount = widget.post.likesCount + (_isLiked ? 1 : 0);
  }

  void _toggleLike() {
    CacheHelper.toggleLike(widget.post.id);
    setState(() {
      if (_isLiked) {
        _isLiked = false;
        _likesCount--;
      } else {
        _isLiked = true;
        _likesCount++;
      }
    });
  }

  /// Opens the profile preview dialog with the post author's info
  void _showProfilePreview() {
    showUserProfilePreview(
      context,
      userName: widget.post.authorName,
      userAvatar: widget.post.authorAvatar,
      userRole: widget.post.authorRole,
    );
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [BoxShadow(color: Colors.grey.shade100, blurRadius: 8)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Info Row
            Row(
              children: [
                // Author Avatar - Tappable
                GestureDetector(
                  onTap: _showProfilePreview,
                  child: post.authorAvatar != null &&
                          post.authorAvatar!.isNotEmpty
                      ? CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(
                            post.authorAvatar!,
                            headers: const {
                              'User-Agent':
                                  'Mozilla/5.0 (Linux; Android 13) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Mobile Safari/537.36',
                            },
                          ),
                          onBackgroundImageError: (_, __) {},
                          backgroundColor:
                              AppColors.splashPrimary.withValues(alpha: 0.2),
                        )
                      : CircleAvatar(
                          radius: 25,
                          backgroundColor:
                              AppColors.splashPrimary.withValues(alpha: 0.2),
                          child: Text(
                            post.authorName.isNotEmpty
                                ? post.authorName[0].toUpperCase()
                                : '?',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.splashPrimary,
                            ),
                          ),
                        ),
                ),

                const SizedBox(width: 10),

                // Author Name + Role Badge
                Expanded(
                  child: Row(
                    children: [
                      // Author Name - Tappable
                      Flexible(
                        child: GestureDetector(
                          onTap: _showProfilePreview,
                          child: Text(
                            post.authorName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Color(0xFF0D3B40),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),

                      // Role Badge (styled like the screenshot)
                      if (post.authorRole != null &&
                          post.authorRole!.isNotEmpty) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppColors.splashPrimary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            post.authorRole!,
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                const SizedBox(width: 6),

                // Time
                Text(
                  post.timeAgo,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),

                // Three dots menu (Edit/Delete)
                if (widget.onDelete != null || widget.onEdit != null)
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert,
                        size: 20, color: Colors.grey),
                    padding: EdgeInsets.zero,
                    onSelected: (value) {
                      if (value == 'edit' && widget.onEdit != null) {
                        widget.onEdit!();
                      }
                      if (value == 'delete' && widget.onDelete != null) {
                        widget.onDelete!();
                      }
                    },
                    itemBuilder: (context) => [
                      if (widget.onEdit != null)
                        const PopupMenuItem(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(Icons.edit_outlined,
                                  size: 18, color: AppColors.splashPrimary),
                              SizedBox(width: 8),
                              Text('Edit'),
                            ],
                          ),
                        ),
                      if (widget.onDelete != null)
                        const PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete_outline,
                                  size: 18, color: Colors.red),
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

            const SizedBox(height: 12),

            // Post Content
            Text(
              post.content,
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF0D3B40),
              ),
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),

            // Post Image
            if (post.image != null && post.image!.isNotEmpty) ...[
              const SizedBox(height: 12),
              Builder(
                builder: (context) {
                  debugPrint('📷 Loading post image URL: ${post.image}');
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.network(
                      post.image!,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          height: 180,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                              color: AppColors.splashPrimary,
                              strokeWidth: 2,
                            ),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        debugPrint('❌ Image load FAILED for URL: ${post.image}');
                        debugPrint('❌ Error: $error');
                        return Container(
                          height: 180,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.broken_image, size: 40, color: Colors.grey),
                              const SizedBox(height: 8),
                              const Text(
                                'Image could not be loaded',
                                style: TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                              const SizedBox(height: 4),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  '${post.image}',
                                  style: const TextStyle(fontSize: 9, color: Colors.grey),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],

            const SizedBox(height: 12),

            // Reactions Row
            Row(
              children: [
                // Like Button (tappable + persisted)
                GestureDetector(
                  onTap: _toggleLike,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    transitionBuilder: (child, animation) =>
                        ScaleTransition(scale: animation, child: child),
                    child: Icon(
                      _isLiked ? Icons.favorite : Icons.favorite_border,
                      key: ValueKey(_isLiked),
                      size: 22,
                      color: _isLiked ? Colors.red : Colors.grey.shade600,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  '$_likesCount',
                  style: TextStyle(
                    fontSize: 13,
                    color: _isLiked ? Colors.red : Colors.grey,
                    fontWeight:
                        _isLiked ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
                const SizedBox(width: 20),
                Icon(Icons.chat_bubble_outline,
                    size: 20, color: Colors.grey.shade600),
                const SizedBox(width: 6),
                Text(
                  '${widget.overrideCommentsCount ?? post.commentsCount}',
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
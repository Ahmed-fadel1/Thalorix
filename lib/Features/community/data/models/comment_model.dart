import 'package:thalorix_app/core/cache/cache_helper.dart';

class CommentModel {
  final String id;
  final String postId;
  final String content;
  final String userId;
  final String authorName;
  final String? authorAvatar;
  final DateTime createdAt;
  final DateTime updatedAt;

  CommentModel({
    required this.id,
    required this.postId,
    required this.content,
    required this.userId,
    required this.authorName,
    this.authorAvatar,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    // Handle nested user object if present
    final user = json['userId'] is Map<String, dynamic> ? json['userId'] : null;

    // Extract the raw userId string
    final rawUserId = user != null
        ? user['_id']?.toString() ?? ''
        : json['userId']?.toString() ?? '';

    // Determine author name:
    // 1. If backend returns populated user object → use user.name
    // 2. If userId matches current logged-in user → use cached name
    // 3. Fallback → "User XXXX" (last 4 chars of userId)
    String resolvedName;
    String? resolvedAvatar;

    if (user != null && user['name'] != null) {
      // Backend populated the user object
      resolvedName = user['name'];
      resolvedAvatar = user['avatar'];
    } else {
      // Backend returned userId as plain string
      final currentUserId = CacheHelper.getUserId();
      if (currentUserId != null && currentUserId == rawUserId) {
        // This is the current user's comment → show their name from cache
        resolvedName = CacheHelper.getName() ?? 'Me';
        resolvedAvatar = null;
      } else {
        // Another user's comment → show User + short ID
        resolvedName =
            'User ${rawUserId.length > 4 ? rawUserId.substring(rawUserId.length - 4) : rawUserId}';
        resolvedAvatar = null;
      }
    }

    return CommentModel(
      id: json['_id']?.toString() ?? json['id']?.toString() ?? '',
      postId: json['postId']?.toString() ?? '',
      content: json['content'] ?? '',
      userId: rawUserId,
      authorName: resolvedName,
      authorAvatar: resolvedAvatar ?? json['authorAvatar'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'userId': userId,
    };
  }

  /// Returns a human-readable time difference
  String get timeAgo {
    final difference = DateTime.now().difference(createdAt);
    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()}y';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()}mo';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return 'now';
    }
  }
}
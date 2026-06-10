import 'package:thalorix_app/core/cache/cache_helper.dart';

class PostModel {
  final String id;
  final String content;
  final String? image;
  final String userId;
  final String authorName;
  final String? authorRole;
  final String? authorAvatar;
  final int likesCount;
  final int commentsCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  PostModel({
    required this.id,
    required this.content,
    this.image,
    required this.userId,
    required this.authorName,
    this.authorRole,
    this.authorAvatar,
    this.likesCount = 0,
    this.commentsCount = 0,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    // Handle nested user object if present (when backend populates userId)
    final user = json['userId'] is Map<String, dynamic> ? json['userId'] : null;

    // Extract the raw userId string
    final rawUserId = user != null
        ? user['_id']?.toString() ?? ''
        : json['userId']?.toString() ?? '';

    // Determine author name:
    // 1. If backend returns populated user object → use user.name
    // 2. If userId matches current logged-in user → use cached name
    // 3. Fallback → "User"
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
        // This is the current user's post → show their name from cache
        resolvedName = CacheHelper.getName() ?? 'Me';
        resolvedAvatar = null; // Will use initial letter
      } else {
        // Another user's post → show User + short ID
        resolvedName = 'User ${rawUserId.length > 4 ? rawUserId.substring(rawUserId.length - 4) : rawUserId}';
        resolvedAvatar = null;
      }
    }

    return PostModel(
      id: json['_id']?.toString() ?? json['id']?.toString() ?? '',
      content: json['content'] ?? '',
      image: json['image'],
      userId: rawUserId,
      authorName: resolvedName,
      authorRole: user?['role'] ?? json['authorRole'],
      authorAvatar: resolvedAvatar ?? json['authorAvatar'],
      likesCount: json['likesCount'] ?? json['likes'] ?? 0,
      commentsCount: json['commentsCount'] ?? json['comments']?.length ?? 0,
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
      if (image != null) 'image': image,
    };
  }

  /// Returns a human-readable time difference (e.g., "2h", "3d")
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

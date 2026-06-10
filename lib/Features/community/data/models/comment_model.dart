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

    return CommentModel(
      id: json['_id']?.toString() ?? json['id']?.toString() ?? '',
      postId: json['postId']?.toString() ?? '',
      content: json['content'] ?? '',
      userId: user != null
          ? user['_id']?.toString() ?? ''
          : json['userId']?.toString() ?? '',
      authorName: user?['name'] ?? json['authorName'] ?? 'Unknown',
      authorAvatar: user?['avatar'] ?? json['authorAvatar'],
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

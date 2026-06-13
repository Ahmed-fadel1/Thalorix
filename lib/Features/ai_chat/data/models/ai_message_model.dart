class AiMessageModel {
  final String id;
  final String content;
  final bool isUser;
  final String? previewUrl;
  final bool isLoading;
  final List<String> attachments;
  final DateTime timestamp;

  AiMessageModel({
    required this.id,
    required this.content,
    required this.isUser,
    this.previewUrl,
    this.isLoading = false,
    this.attachments = const [],
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  AiMessageModel copyWith({
    String? id,
    String? content,
    bool? isUser,
    String? previewUrl,
    bool? isLoading,
    List<String>? attachments,
    DateTime? timestamp,
  }) {
    return AiMessageModel(
      id: id ?? this.id,
      content: content ?? this.content,
      isUser: isUser ?? this.isUser,
      previewUrl: previewUrl ?? this.previewUrl,
      isLoading: isLoading ?? this.isLoading,
      attachments: attachments ?? this.attachments,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'isUser': isUser,
      'previewUrl': previewUrl,
      'isLoading': isLoading,
      'attachments': attachments,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory AiMessageModel.fromJson(Map<String, dynamic> json) {
    return AiMessageModel(
      id: json['id'] ?? '',
      content: json['content'] ?? '',
      isUser: json['isUser'] ?? false,
      previewUrl: json['previewUrl'],
      isLoading: json['isLoading'] ?? false,
      attachments: List<String>.from(json['attachments'] ?? []),
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'])
          : DateTime.now(),
    );
  }
}

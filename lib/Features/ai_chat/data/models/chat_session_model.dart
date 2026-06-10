import 'package:thalorix_app/Features/ai_chat/data/models/ai_message_model.dart';

class ChatSessionModel {
  final String id;
  final String title;
  final DateTime createdAt;
  final String? projectId;
  final String? sessionId;
  final List<AiMessageModel> messages;

  ChatSessionModel({
    required this.id,
    required this.title,
    DateTime? createdAt,
    this.projectId,
    this.sessionId,
    this.messages = const [],
  }) : createdAt = createdAt ?? DateTime.now();

  ChatSessionModel copyWith({
    String? id,
    String? title,
    DateTime? createdAt,
    String? projectId,
    String? sessionId,
    List<AiMessageModel>? messages,
  }) {
    return ChatSessionModel(
      id: id ?? this.id,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      projectId: projectId ?? this.projectId,
      sessionId: sessionId ?? this.sessionId,
      messages: messages ?? this.messages,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'createdAt': createdAt.toIso8601String(),
      'projectId': projectId,
      'sessionId': sessionId,
      'messages': messages.map((m) => m.toJson()).toList(),
    };
  }

  factory ChatSessionModel.fromJson(Map<String, dynamic> json) {
    return ChatSessionModel(
      id: json['id'] ?? '',
      title: json['title'] ?? 'New Chat',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      projectId: json['projectId'],
      sessionId: json['sessionId'],
      messages: (json['messages'] as List?)
              ?.map((m) => AiMessageModel.fromJson(m))
              .toList() ??
          [],
    );
  }
}

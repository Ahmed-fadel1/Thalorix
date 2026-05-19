import 'dart:convert';

class MessageModel {
  final String recevierId;
  final String content;
  final String createdAt;

  MessageModel({
    required this.recevierId,
    required this.content,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'recevierId': recevierId,
      'content': content,
      'createdAt': createdAt,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      recevierId: map['recevierId'] as String,
      content: map['content'] as String,
      createdAt: map['createdAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

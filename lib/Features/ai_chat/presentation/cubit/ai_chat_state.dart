import 'package:thalorix_app/Features/ai_chat/data/models/ai_message_model.dart';
import 'package:thalorix_app/Features/ai_chat/data/models/chat_session_model.dart';

abstract class AiChatState {
  const AiChatState();
}

class AiChatInitial extends AiChatState {}

class AiChatLoaded extends AiChatState {
  final List<AiMessageModel> messages;
  final String? currentSessionId;
  final String? currentProjectId;
  final List<ChatSessionModel> sessions;
  final bool isSending;

  const AiChatLoaded({
    required this.messages,
    this.currentSessionId,
    this.currentProjectId,
    required this.sessions,
    this.isSending = false,
  });

  AiChatLoaded copyWith({
    List<AiMessageModel>? messages,
    String? currentSessionId,
    String? currentProjectId,
    List<ChatSessionModel>? sessions,
    bool? isSending,
  }) {
    return AiChatLoaded(
      messages: messages ?? this.messages,
      currentSessionId: currentSessionId ?? this.currentSessionId,
      currentProjectId: currentProjectId ?? this.currentProjectId,
      sessions: sessions ?? this.sessions,
      isSending: isSending ?? this.isSending,
    );
  }
}

class AiChatError extends AiChatState {
  final String message;

  const AiChatError(this.message);
}

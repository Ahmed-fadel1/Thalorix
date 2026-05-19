import 'package:supabase_flutter/supabase_flutter.dart';

class ChatService {
  final _supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> fetchConversation({
    required String myId,
    required String otherUserId,
  }) async {
    final response = await _supabase
        .from('messages')
        .select()
        .or(
          'and(sender_id.eq.$myId,receiver_id.eq.$otherUserId),'
          'and(sender_id.eq.$otherUserId,receiver_id.eq.$myId)',
        )
        .order('created_at', ascending: true)
        .limit(50);

    return List<Map<String, dynamic>>.from(response);
  }

  Future<void> sendMessage({
    required String senderId,
    required String receiverId,
    required String content,
  }) async {
    await _supabase.from('messages').insert({
      'sender_id': senderId,
      'receiver_id': receiverId,
      'content': content,
    });
  }

  RealtimeChannel subscribeToMessages({
    required String myId,
    required String otherUserId,
    required void Function(Map<String, dynamic>) onNewMessage,
  }) {
    return _supabase
        .channel('chat_${myId}_$otherUserId')
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'messages',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'receiver_id',
            value: myId,
          ),
          callback: (payload) {
            final msg = payload.newRecord;
            if (msg['sender_id'] == otherUserId) {
              onNewMessage(msg);
            }
          },
        )
        .subscribe();
  }
}

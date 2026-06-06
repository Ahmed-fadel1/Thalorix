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
    // ✅ channel خاص بكل محادثة
    final ids = [myId, otherUserId]..sort();
    final channelName = 'chat_${ids[0]}_${ids[1]}';

    return _supabase
        .channel(channelName)
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'messages',
          // ✅ فلترة على السيرفر — بس الرسايل اللي receiver_id = myId
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq, // ✅ كده
            column: 'receiver_id',
            value: myId,
          ),
          callback: (payload) {
            final msg = payload.newRecord;

            // ✅ تأكيد إضافي إن الرسالة من الشخص ده بالتحديد
            if (msg['sender_id'] == otherUserId) {
              onNewMessage(msg);
            }
          },
        )
        .subscribe();
  }
}

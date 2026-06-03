import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thalorix_app/Features/ai_chat/data/models/chat_session_model.dart';

class AiChatLocalDataSource {
  static const String _sessionsKey = 'ai_chat_sessions';

  final SharedPreferences _prefs;

  AiChatLocalDataSource(this._prefs);

  /// Load all saved chat sessions
  List<ChatSessionModel> getSessions() {
    final raw = _prefs.getString(_sessionsKey);
    if (raw == null || raw.isEmpty) return [];
    try {
      final List<dynamic> list = jsonDecode(raw);
      return list.map((e) => ChatSessionModel.fromJson(e)).toList();
    } catch (_) {
      return [];
    }
  }

  /// Save all sessions
  Future<void> saveSessions(List<ChatSessionModel> sessions) async {
    final json = jsonEncode(sessions.map((s) => s.toJson()).toList());
    await _prefs.setString(_sessionsKey, json);
  }

  /// Save or update a single session
  Future<void> saveSession(ChatSessionModel session) async {
    final sessions = getSessions();
    final index = sessions.indexWhere((s) => s.id == session.id);
    if (index >= 0) {
      sessions[index] = session;
    } else {
      sessions.insert(0, session);
    }
    await saveSessions(sessions);
  }

  /// Delete a session by ID
  Future<void> deleteSession(String sessionId) async {
    final sessions = getSessions();
    sessions.removeWhere((s) => s.id == sessionId);
    await saveSessions(sessions);
  }

  /// Clear all sessions
  Future<void> clearAll() async {
    await _prefs.remove(_sessionsKey);
  }
}

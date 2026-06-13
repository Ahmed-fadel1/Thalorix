import 'package:flutter/material.dart';
import 'package:thalorix_app/Features/ai_chat/data/models/chat_session_model.dart';
import 'package:thalorix_app/core/utils/Colors/app_colors.dart';

class ChatDrawer extends StatelessWidget {
  final List<ChatSessionModel> sessions;
  final String? currentSessionId;
  final VoidCallback onNewChat;
  final ValueChanged<String> onSelectSession;
  final ValueChanged<String> onDeleteSession;

  const ChatDrawer({
    super.key,
    required this.sessions,
    required this.currentSessionId,
    required this.onNewChat,
    required this.onSelectSession,
    required this.onDeleteSession,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            // ─── Header ──────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
              child: Row(
                children: [
                  const Icon(Icons.chat_bubble_outline,
                      color: AppColors.splashPrimary, size: 22),
                  const SizedBox(width: 10),
                  const Text(
                    'Chat History',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0D3B40),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close,
                        color: Color(0xFF0D3B40), size: 22),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),

            // ─── New Chat Button ─────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Material(
                color: AppColors.splashPrimary,
                borderRadius: BorderRadius.circular(14),
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () {
                    Navigator.of(context).pop();
                    onNewChat();
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, color: Colors.white, size: 20),
                        SizedBox(width: 8),
                        Text(
                          'New Chat',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const Divider(height: 1),

            // ─── Sessions List ───────────────────────────
            Expanded(
              child: sessions.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.forum_outlined,
                              size: 48, color: Color(0xFFBDBDBD)),
                          SizedBox(height: 12),
                          Text(
                            'No chats yet',
                            style: TextStyle(
                              color: Color(0xFF9E9E9E),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: sessions.length,
                      itemBuilder: (context, index) {
                        final session = sessions[index];
                        final isSelected =
                            session.id == currentSessionId;

                        return Dismissible(
                          key: Key(session.id),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            color: Colors.red.shade400,
                            child: const Icon(Icons.delete_outline,
                                color: Colors.white),
                          ),
                          onDismissed: (_) =>
                              onDeleteSession(session.id),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 4),
                            selected: isSelected,
                            selectedTileColor:
                                AppColors.splashPrimary.withValues(alpha: 0.08),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            leading: Icon(
                              Icons.chat_outlined,
                              size: 20,
                              color: isSelected
                                  ? AppColors.splashPrimary
                                  : const Color(0xFF9E9E9E),
                            ),
                            title: Text(
                              session.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                                color: isSelected
                                    ? AppColors.splashPrimary
                                    : const Color(0xFF424242),
                              ),
                            ),
                            subtitle: Text(
                              _formatDate(session.createdAt),
                              style: const TextStyle(
                                fontSize: 11,
                                color: Color(0xFF9E9E9E),
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).pop();
                              onSelectSession(session.id);
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${date.day}/${date.month}/${date.year}';
  }
}

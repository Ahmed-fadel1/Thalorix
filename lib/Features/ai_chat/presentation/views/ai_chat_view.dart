import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:thalorix_app/Features/ai_chat/presentation/cubit/ai_chat_cubit.dart';
import 'package:thalorix_app/Features/ai_chat/presentation/cubit/ai_chat_state.dart';
import 'package:thalorix_app/Features/ai_chat/presentation/widgets/rgb_text.dart';
import 'package:thalorix_app/Features/ai_chat/presentation/widgets/chat_drawer.dart';
import 'package:thalorix_app/Features/ai_chat/presentation/widgets/message_bubble.dart';
import 'package:thalorix_app/Features/ai_chat/presentation/widgets/chat_input_bar.dart';
import 'package:thalorix_app/core/cache/cache_helper.dart';

class AiChatView extends StatefulWidget {
  const AiChatView({super.key});

  @override
  State<AiChatView> createState() => _AiChatViewState();
}

class _AiChatViewState extends State<AiChatView> {
  final TextEditingController _promptController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  void _sendMessage() {
    final text = _promptController.text.trim();
    if (text.isEmpty) return;

    final userId = CacheHelper.getUserId() ?? '';
    context.read<AiChatCubit>().sendPrompt(text, userId);
    _promptController.clear();
    _scrollToBottom();
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'gif', 'pdf', 'webp'],
    );
    if (result != null && result.files.single.path != null) {
      if (!mounted) return;
      context.read<AiChatCubit>().uploadFile(result.files.single.path!);
      _scrollToBottom();
    }
  }

  @override
  void dispose() {
    _promptController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AiChatCubit, AiChatState>(
      listener: (context, state) {
        if (state is AiChatLoaded) {
          _scrollToBottom();
        }
      },
      builder: (context, state) {
        final cubit = context.read<AiChatCubit>();

        // Get sessions for drawer
        final sessions =
            state is AiChatLoaded ? state.sessions : [];
        final currentSessionId =
            state is AiChatLoaded ? state.currentSessionId : null;

        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.white,

          // ─── Drawer ──────────────────────────────────
          drawer: ChatDrawer(
            sessions: sessions.cast(),
            currentSessionId: currentSessionId,
            onNewChat: () => cubit.startNewChat(),
            onSelectSession: (id) => cubit.loadSession(id),
            onDeleteSession: (id) => cubit.deleteSession(id),
          ),

          // ─── AppBar ──────────────────────────────────
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            scrolledUnderElevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.menu,
                  color: Color(0xFF0D3B40), size: 26),
              onPressed: () =>
                  _scaffoldKey.currentState?.openDrawer(),
            ),
            title: const RgbAnimatedText(),
            centerTitle: true,
          ),

          // ─── Body ────────────────────────────────────
          body: SafeArea(
            child: Column(
              children: [
                // Chat messages area
                Expanded(
                  child: _buildChatArea(state),
                ),

                // Input bar
                ChatInputBar(
                  controller: _promptController,
                  onSend: _sendMessage,
                  onAttach: _pickFile,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildChatArea(AiChatState state) {
    if (state is AiChatLoaded && state.messages.isNotEmpty) {
      return ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        itemCount: state.messages.length,
        itemBuilder: (context, index) {
          return MessageBubble(message: state.messages[index]);
        },
      );
    }

    // Empty state — show welcome
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xFF00BFA5), Color(0xFF00E5FF)],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF00BFA5).withValues(alpha: 0.25),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: const Icon(Icons.auto_awesome,
                size: 30, color: Colors.white),
          ),
          const SizedBox(height: 20),
          const Text(
            'How can I help you today?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF424242),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Ask me to build anything you can imagine',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF9E9E9E),
            ),
          ),
        ],
      ),
    );
  }
}

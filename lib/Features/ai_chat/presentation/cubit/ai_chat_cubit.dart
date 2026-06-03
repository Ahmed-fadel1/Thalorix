import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thalorix_app/Features/ai_chat/data/data_sources/ai_chat_local_data_source.dart';
import 'package:thalorix_app/Features/ai_chat/data/models/ai_message_model.dart';
import 'package:thalorix_app/Features/ai_chat/data/models/chat_session_model.dart';
import 'package:thalorix_app/Features/ai_chat/domain/usecases/create_project_usecase.dart';
import 'package:thalorix_app/Features/ai_chat/domain/usecases/edit_project_usecase.dart';
import 'package:thalorix_app/Features/ai_chat/domain/usecases/get_project_usecase.dart';
import 'package:thalorix_app/Features/ai_chat/domain/usecases/upload_file_usecase.dart';
import 'package:thalorix_app/Features/ai_chat/presentation/cubit/ai_chat_state.dart';

class AiChatCubit extends Cubit<AiChatState> {
  final CreateProjectUseCase createProjectUseCase;
  final GetProjectUseCase getProjectUseCase;
  final EditProjectUseCase editProjectUseCase;
  final UploadFileUseCase uploadFileUseCase;
  final AiChatLocalDataSource localDataSource;

  List<AiMessageModel> _messages = [];
  List<ChatSessionModel> _sessions = [];
  String? _currentSessionId;
  String? _currentProjectId;
  String? _currentBackendSessionId;
  Timer? _pollingTimer;

  AiChatCubit({
    required this.createProjectUseCase,
    required this.getProjectUseCase,
    required this.editProjectUseCase,
    required this.uploadFileUseCase,
    required this.localDataSource,
  }) : super(AiChatInitial()) {
    _loadSessions();
  }

  // ─── Init ────────────────────────────────────────────────────

  void _loadSessions() {
    _sessions = localDataSource.getSessions();
    _messages = [];
    _currentSessionId = null;
    _currentProjectId = null;
    _currentBackendSessionId = null;
    _emitLoaded();
  }

  void _emitLoaded({bool isSending = false}) {
    emit(AiChatLoaded(
      messages: List.from(_messages),
      currentSessionId: _currentSessionId,
      currentProjectId: _currentProjectId,
      sessions: List.from(_sessions),
      isSending: isSending,
    ));
  }

  // ─── Session Management ──────────────────────────────────────

  void startNewChat() {
    _saveCurrentSession();
    _pollingTimer?.cancel();
    _messages = [];
    _currentSessionId = null;
    _currentProjectId = null;
    _currentBackendSessionId = null;
    _emitLoaded();
  }

  void loadSession(String sessionId) {
    _saveCurrentSession();
    _pollingTimer?.cancel();

    final session = _sessions.firstWhere(
      (s) => s.id == sessionId,
      orElse: () => ChatSessionModel(id: sessionId, title: 'Chat'),
    );

    _currentSessionId = session.id;
    _currentProjectId = session.projectId;
    _currentBackendSessionId = session.sessionId;
    _messages = List.from(session.messages);
    _emitLoaded();
  }

  void deleteSession(String sessionId) {
    _sessions.removeWhere((s) => s.id == sessionId);
    localDataSource.deleteSession(sessionId);

    if (_currentSessionId == sessionId) {
      _messages = [];
      _currentSessionId = null;
      _currentProjectId = null;
      _currentBackendSessionId = null;
    }
    _emitLoaded();
  }

  void _saveCurrentSession() {
    if (_currentSessionId == null && _messages.isEmpty) return;

    final id = _currentSessionId ??
        'session_${DateTime.now().millisecondsSinceEpoch}';
    _currentSessionId = id;

    // Derive title from first user message
    String title = 'New Chat';
    for (final msg in _messages) {
      if (msg.isUser && msg.content.isNotEmpty) {
        title = msg.content.length > 40
            ? '${msg.content.substring(0, 40)}...'
            : msg.content;
        break;
      }
    }

    final session = ChatSessionModel(
      id: id,
      title: title,
      projectId: _currentProjectId,
      sessionId: _currentBackendSessionId,
      messages: _messages.where((m) => !m.isLoading).toList(),
    );

    final idx = _sessions.indexWhere((s) => s.id == id);
    if (idx >= 0) {
      _sessions[idx] = session;
    } else {
      _sessions.insert(0, session);
    }

    localDataSource.saveSession(session);
  }

  // ─── Send Message ────────────────────────────────────────────

  Future<void> sendPrompt(String prompt, String userId) async {
    // Create session if needed
    _currentSessionId ??=
        'session_${DateTime.now().millisecondsSinceEpoch}';

    // Add user message
    _messages.add(AiMessageModel(
      id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
      content: prompt,
      isUser: true,
    ));

    // Add AI loading message
    _messages.add(AiMessageModel(
      id: 'loading_${DateTime.now().millisecondsSinceEpoch}',
      content: 'Building your project...',
      isUser: false,
      isLoading: true,
    ));
    _emitLoaded(isSending: true);

    if (_currentProjectId == null) {
      // Create new project
      final result = await createProjectUseCase(
        prompt: prompt,
        userId: userId,
      );

      result.fold(
        (failure) => _removeLoadingAndShowError(failure.message),
        (project) {
          _currentProjectId = project.id;
          _currentBackendSessionId = project.sessionId;
          _startPolling();
        },
      );
    } else {
      // Edit existing project
      final result = await editProjectUseCase(
        projectId: _currentProjectId!,
        prompt: prompt,
      );

      result.fold(
        (failure) => _removeLoadingAndShowError(failure.message),
        (project) => _startPolling(),
      );
    }
  }

  void _removeLoadingAndShowError(String errorMsg) {
    if (_messages.isNotEmpty && _messages.last.isLoading) {
      _messages.removeLast();
    }
    _messages.add(AiMessageModel(
      id: 'err_${DateTime.now().millisecondsSinceEpoch}',
      content: 'Error: $errorMsg',
      isUser: false,
    ));
    _saveCurrentSession();
    _emitLoaded();
  }

  void _startPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = Timer.periodic(const Duration(seconds: 4), (timer) async {
      if (_currentProjectId == null) {
        timer.cancel();
        return;
      }

      final result =
          await getProjectUseCase(projectId: _currentProjectId!);
      result.fold(
        (failure) {
          timer.cancel();
          _removeLoadingAndShowError(failure.message);
        },
        (project) {
          if (project.status == 'completed' || project.status == 'failed') {
            timer.cancel();

            // Remove loading message
            if (_messages.isNotEmpty && _messages.last.isLoading) {
              _messages.removeLast();
            }

            if (project.status == 'completed') {
              _messages.add(AiMessageModel(
                id: 'ai_${DateTime.now().millisecondsSinceEpoch}',
                content: 'Your project is ready! Check it out below:',
                isUser: false,
                previewUrl: project.previewUrl,
              ));
            } else {
              _messages.add(AiMessageModel(
                id: 'ai_${DateTime.now().millisecondsSinceEpoch}',
                content: 'Project build failed. Please try again.',
                isUser: false,
              ));
            }
            _saveCurrentSession();
            _emitLoaded();
          }
        },
      );
    });
  }

  // ─── File Upload ─────────────────────────────────────────────

  Future<void> uploadFile(String filePath) async {
    _currentSessionId ??=
        'session_${DateTime.now().millisecondsSinceEpoch}';

    final fileName = filePath.split('/').last.split('\\').last;

    _messages.add(AiMessageModel(
      id: 'upload_${DateTime.now().millisecondsSinceEpoch}',
      content: '📎 Uploading: $fileName',
      isUser: true,
      isLoading: true,
      attachments: [filePath],
    ));
    _emitLoaded(isSending: true);

    final result = await uploadFileUseCase(
      filePath: filePath,
      sessionId: _currentBackendSessionId,
    );

    result.fold(
      (failure) {
        if (_messages.isNotEmpty && _messages.last.isLoading) {
          _messages.removeLast();
        }
        _messages.add(AiMessageModel(
          id: 'err_${DateTime.now().millisecondsSinceEpoch}',
          content: 'Upload failed: ${failure.message}',
          isUser: false,
        ));
        _emitLoaded();
      },
      (successMessage) {
        if (_messages.isNotEmpty && _messages.last.isLoading) {
          _messages.removeLast();
        }
        _messages.add(AiMessageModel(
          id: 'file_${DateTime.now().millisecondsSinceEpoch}',
          content: '📎 $fileName uploaded successfully',
          isUser: true,
          attachments: [filePath],
        ));
        _saveCurrentSession();
        _emitLoaded();
      },
    );
  }

  // ─── Cleanup ─────────────────────────────────────────────────

  @override
  Future<void> close() {
    _saveCurrentSession();
    _pollingTimer?.cancel();
    return super.close();
  }
}

import 'package:dartz/dartz.dart';
import 'package:thalorix_app/Features/ai_chat/data/models/ai_project_model.dart';
import 'package:thalorix_app/Features/ai_chat/data/models/chat_session_model.dart';
import 'package:thalorix_app/core/errors/failures.dart';

abstract class AiChatRepository {
  // ─── Remote API ───────────────────────────────────────────────

  Future<Either<Failure, bool>> healthCheck();

  Future<Either<Failure, bool>> readyCheck();

  Future<Either<Failure, AiProjectModel>> createProject({
    required String prompt,
    String? userId,
    String? stack,
  });

  Future<Either<Failure, String>> uploadFile({
    required String filePath,
    String? sessionId,
  });

  Future<Either<Failure, List<AiProjectModel>>> getDeployedProjects();

  Future<Either<Failure, AiProjectModel>> getProject({
    required String projectId,
  });

  Future<Either<Failure, AiProjectModel>> editProject({
    required String projectId,
    required String prompt,
  });

  Future<Either<Failure, Map<String, dynamic>>> getManifest({
    required String sessionId,
    required String projectName,
  });

  Future<Either<Failure, Map<String, dynamic>>> getProjectStatus({
    required String sessionId,
    required String projectName,
  });

  Future<Either<Failure, String>> getProjectFile({
    required String sessionId,
    required String projectName,
    required String filePath,
  });

  Future<Either<Failure, Map<String, dynamic>>> getPreview({
    required String sessionId,
    required String projectName,
  });

  // ─── Local Sessions ──────────────────────────────────────────

  List<ChatSessionModel> getSessions();

  Future<void> saveSession(ChatSessionModel session);

  Future<void> deleteSession(String sessionId);
}

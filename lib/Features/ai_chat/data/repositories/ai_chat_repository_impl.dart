import 'package:dartz/dartz.dart';
import 'package:thalorix_app/Features/ai_chat/data/data_sources/ai_chat_local_data_source.dart';
import 'package:thalorix_app/Features/ai_chat/data/data_sources/ai_chat_remote_data_source.dart';
import 'package:thalorix_app/Features/ai_chat/data/models/ai_project_model.dart';
import 'package:thalorix_app/Features/ai_chat/data/models/chat_session_model.dart';
import 'package:thalorix_app/Features/ai_chat/domain/repositories/ai_chat_repository.dart';
import 'package:thalorix_app/core/errors/failures.dart';

class AiChatRepositoryImpl implements AiChatRepository {
  final AiChatRemoteDataSource remoteDataSource;
  final AiChatLocalDataSource localDataSource;

  AiChatRepositoryImpl(this.remoteDataSource, this.localDataSource);

  // ─── Helper ──────────────────────────────────────────────────

  Either<Failure, AiProjectModel> _parseProject(dynamic data) {
    if (data is Map<String, dynamic>) {
      if (data['ok'] == false) {
        return Left(ServerFailure(data['error']?.toString() ?? 'API Error'));
      }
      final projectData = data['data'] ?? data;
      if (projectData is Map<String, dynamic>) {
        return Right(AiProjectModel.fromJson(projectData));
      }
    }
    return Left(ServerFailure('Invalid response format'));
  }

  // ─── Remote API ──────────────────────────────────────────────

  @override
  Future<Either<Failure, bool>> healthCheck() async {
    try {
      await remoteDataSource.healthCheck();
      return const Right(true);
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> readyCheck() async {
    try {
      final response = await remoteDataSource.readyCheck();
      return Right(response.statusCode == 200);
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AiProjectModel>> createProject({
    required String prompt,
    String? userId,
    String? stack,
  }) async {
    try {
      final response = await remoteDataSource.createProject(
        prompt: prompt,
        userId: userId,
        stack: stack,
      );
      return _parseProject(response.data);
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadFile({
    required String filePath,
    String? sessionId,
  }) async {
    try {
      final response = await remoteDataSource.uploadFile(
        filePath: filePath,
        sessionId: sessionId,
      );
      final data = response.data;
      if (response.statusCode == 201 ||
          (data is Map && data['ok'] == true)) {
        return const Right('File uploaded successfully');
      }
      return Left(
          ServerFailure('Upload failed: ${data is Map ? data['error'] ?? data : data}'));
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AiProjectModel>>> getDeployedProjects() async {
    try {
      final response = await remoteDataSource.getDeployedProjects();
      final data = response.data;
      if (data is Map<String, dynamic>) {
        if (data['ok'] == false) {
          return Left(ServerFailure(data['error']?.toString() ?? 'API Error'));
        }
        final list = data['data'] ?? [];
        if (list is List) {
          return Right(
              list.map((e) => AiProjectModel.fromJson(e)).toList());
        }
      }
      if (data is List) {
        return Right(data.map((e) => AiProjectModel.fromJson(e)).toList());
      }
      return Left(ServerFailure('Invalid response format'));
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AiProjectModel>> getProject({
    required String projectId,
  }) async {
    try {
      final response =
          await remoteDataSource.getProject(projectId: projectId);
      return _parseProject(response.data);
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AiProjectModel>> editProject({
    required String projectId,
    required String prompt,
  }) async {
    try {
      final response = await remoteDataSource.editProject(
        projectId: projectId,
        prompt: prompt,
      );
      return _parseProject(response.data);
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getManifest({
    required String sessionId,
    required String projectName,
  }) async {
    try {
      final response = await remoteDataSource.getManifest(
        sessionId: sessionId,
        projectName: projectName,
      );
      final data = response.data;
      if (data is Map<String, dynamic>) return Right(data);
      return Left(ServerFailure('Invalid response format'));
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getProjectStatus({
    required String sessionId,
    required String projectName,
  }) async {
    try {
      final response = await remoteDataSource.getProjectStatus(
        sessionId: sessionId,
        projectName: projectName,
      );
      final data = response.data;
      if (data is Map<String, dynamic>) return Right(data);
      return Left(ServerFailure('Invalid response format'));
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> getProjectFile({
    required String sessionId,
    required String projectName,
    required String filePath,
  }) async {
    try {
      final response = await remoteDataSource.getProjectFile(
        sessionId: sessionId,
        projectName: projectName,
        filePath: filePath,
      );
      return Right(response.data.toString());
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getPreview({
    required String sessionId,
    required String projectName,
  }) async {
    try {
      final response = await remoteDataSource.getPreview(
        sessionId: sessionId,
        projectName: projectName,
      );
      final data = response.data;
      if (data is Map<String, dynamic>) return Right(data);
      return Right({'preview': data.toString()});
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(ServerFailure(e.toString()));
    }
  }

  // ─── Local Sessions ──────────────────────────────────────────

  @override
  List<ChatSessionModel> getSessions() {
    return localDataSource.getSessions();
  }

  @override
  Future<void> saveSession(ChatSessionModel session) async {
    await localDataSource.saveSession(session);
  }

  @override
  Future<void> deleteSession(String sessionId) async {
    await localDataSource.deleteSession(sessionId);
  }
}

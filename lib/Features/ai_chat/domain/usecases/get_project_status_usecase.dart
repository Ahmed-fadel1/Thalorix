import 'package:dartz/dartz.dart';
import 'package:thalorix_app/Features/ai_chat/domain/repositories/ai_chat_repository.dart';
import 'package:thalorix_app/core/errors/failures.dart';

class GetProjectStatusUseCase {
  final AiChatRepository repository;

  GetProjectStatusUseCase(this.repository);

  Future<Either<Failure, Map<String, dynamic>>> call({
    required String sessionId,
    required String projectName,
  }) {
    return repository.getProjectStatus(
      sessionId: sessionId,
      projectName: projectName,
    );
  }
}

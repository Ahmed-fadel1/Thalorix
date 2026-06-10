import 'package:dartz/dartz.dart';
import 'package:thalorix_app/Features/ai_chat/data/models/ai_project_model.dart';
import 'package:thalorix_app/Features/ai_chat/domain/repositories/ai_chat_repository.dart';
import 'package:thalorix_app/core/errors/failures.dart';

class GetProjectUseCase {
  final AiChatRepository repository;

  GetProjectUseCase(this.repository);

  Future<Either<Failure, AiProjectModel>> call({required String projectId}) {
    return repository.getProject(projectId: projectId);
  }
}

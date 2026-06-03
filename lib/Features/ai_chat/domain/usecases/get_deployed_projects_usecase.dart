import 'package:dartz/dartz.dart';
import 'package:thalorix_app/Features/ai_chat/data/models/ai_project_model.dart';
import 'package:thalorix_app/Features/ai_chat/domain/repositories/ai_chat_repository.dart';
import 'package:thalorix_app/core/errors/failures.dart';

class GetDeployedProjectsUseCase {
  final AiChatRepository repository;

  GetDeployedProjectsUseCase(this.repository);

  Future<Either<Failure, List<AiProjectModel>>> call() {
    return repository.getDeployedProjects();
  }
}

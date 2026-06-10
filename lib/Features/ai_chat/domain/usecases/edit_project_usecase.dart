import 'package:dartz/dartz.dart';
import 'package:thalorix_app/Features/ai_chat/data/models/ai_project_model.dart';
import 'package:thalorix_app/Features/ai_chat/domain/repositories/ai_chat_repository.dart';
import 'package:thalorix_app/core/errors/failures.dart';

class EditProjectUseCase {
  final AiChatRepository repository;

  EditProjectUseCase(this.repository);

  Future<Either<Failure, AiProjectModel>> call({
    required String projectId,
    required String prompt,
  }) {
    return repository.editProject(projectId: projectId, prompt: prompt);
  }
}

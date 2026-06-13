import 'package:dartz/dartz.dart';
import 'package:thalorix_app/Features/ai_chat/data/models/ai_project_model.dart';
import 'package:thalorix_app/Features/ai_chat/domain/repositories/ai_chat_repository.dart';
import 'package:thalorix_app/core/errors/failures.dart';

class CreateProjectUseCase {
  final AiChatRepository repository;

  CreateProjectUseCase(this.repository);

  Future<Either<Failure, AiProjectModel>> call({
    required String prompt,
    String? userId,
    String? stack,
  }) {
    return repository.createProject(
        prompt: prompt, userId: userId, stack: stack);
  }
}

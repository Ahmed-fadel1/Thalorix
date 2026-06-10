import 'package:dartz/dartz.dart';
import 'package:thalorix_app/Features/ai_chat/domain/repositories/ai_chat_repository.dart';
import 'package:thalorix_app/core/errors/failures.dart';

class UploadFileUseCase {
  final AiChatRepository repository;

  UploadFileUseCase(this.repository);

  Future<Either<Failure, String>> call({
    required String filePath,
    String? sessionId,
  }) {
    return repository.uploadFile(filePath: filePath, sessionId: sessionId);
  }
}

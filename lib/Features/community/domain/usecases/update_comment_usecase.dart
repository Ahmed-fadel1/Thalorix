import 'package:dartz/dartz.dart';
import 'package:thalorix_app/Features/community/domain/repositories/community_repository.dart';
import 'package:thalorix_app/core/errors/failures.dart';

class UpdateCommentUseCase {
  final CommunityRepository repo;

  UpdateCommentUseCase(this.repo);

  Future<Either<Failure, String>> call({
    required String id,
    required String content,
    required String userId,
  }) {
    return repo.updateComment(
      id: id,
      content: content,
      userId: userId,
    );
  }
}

import 'package:dartz/dartz.dart';
import 'package:thalorix_app/Features/community/domain/repositories/community_repository.dart';
import 'package:thalorix_app/core/errors/failures.dart';

class AddCommentUseCase {
  final CommunityRepository repo;

  AddCommentUseCase(this.repo);

  Future<Either<Failure, String>> call({
    required String postId,
    required String content,
    required String userId,
  }) {
    return repo.addComment(
      postId: postId,
      content: content,
      userId: userId,
    );
  }
}

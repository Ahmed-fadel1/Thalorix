import 'package:dartz/dartz.dart';
import 'package:thalorix_app/Features/community/data/models/comment_model.dart';
import 'package:thalorix_app/Features/community/domain/repositories/community_repository.dart';
import 'package:thalorix_app/core/errors/failures.dart';

class GetCommentsUseCase {
  final CommunityRepository repo;

  GetCommentsUseCase(this.repo);

  Future<Either<Failure, List<CommentModel>>> call({
    required String postId,
  }) {
    return repo.getComments(postId: postId);
  }
}

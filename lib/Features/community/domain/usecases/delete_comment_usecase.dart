import 'package:dartz/dartz.dart';
import 'package:thalorix_app/Features/community/domain/repositories/community_repository.dart';
import 'package:thalorix_app/core/errors/failures.dart';

class DeleteCommentUseCase {
  final CommunityRepository repo;

  DeleteCommentUseCase(this.repo);

  Future<Either<Failure, String>> call({required String id}) {
    return repo.deleteComment(id: id);
  }
}

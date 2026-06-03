import 'package:dartz/dartz.dart';
import 'package:thalorix_app/Features/community/domain/repositories/community_repository.dart';
import 'package:thalorix_app/core/errors/failures.dart';

class UpdatePostUseCase {
  final CommunityRepository repo;

  UpdatePostUseCase(this.repo);

  Future<Either<Failure, String>> call({
    required String id,
    required String content,
    required String userId,
    String? image,
  }) {
    return repo.updatePost(
      id: id,
      content: content,
      userId: userId,
      image: image,
    );
  }
}

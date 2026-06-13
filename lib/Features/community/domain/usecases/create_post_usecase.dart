import 'package:dartz/dartz.dart';
import 'package:thalorix_app/Features/community/domain/repositories/community_repository.dart';
import 'package:thalorix_app/core/errors/failures.dart';

class CreatePostUseCase {
  final CommunityRepository repo;

  CreatePostUseCase(this.repo);

  Future<Either<Failure, String>> call({
    required String content,
    required String userId,
    String? image,
  }) {
    return repo.createPost(
      content: content,
      userId: userId,
      image: image,
    );
  }
}

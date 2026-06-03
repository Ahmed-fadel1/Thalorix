import 'package:dartz/dartz.dart';
import 'package:thalorix_app/Features/community/data/models/post_model.dart';
import 'package:thalorix_app/Features/community/domain/repositories/community_repository.dart';
import 'package:thalorix_app/core/errors/failures.dart';

class GetFeedUseCase {
  final CommunityRepository repo;

  GetFeedUseCase(this.repo);

  Future<Either<Failure, List<PostModel>>> call() {
    return repo.getFeed();
  }
}

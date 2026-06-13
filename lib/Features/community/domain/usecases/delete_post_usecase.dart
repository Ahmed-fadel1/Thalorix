import 'package:dartz/dartz.dart';
import 'package:thalorix_app/Features/community/domain/repositories/community_repository.dart';
import 'package:thalorix_app/core/errors/failures.dart';

class DeletePostUseCase {
  final CommunityRepository repo;

  DeletePostUseCase(this.repo);

  Future<Either<Failure, String>> call({required String id}) {
    return repo.deletePost(id: id);
  }
}

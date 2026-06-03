import 'package:dartz/dartz.dart';
import 'package:thalorix_app/Features/community/data/models/comment_model.dart';
import 'package:thalorix_app/Features/community/data/models/post_model.dart';
import 'package:thalorix_app/core/errors/failures.dart';

abstract class CommunityRepository {
  // Posts
  Future<Either<Failure, List<PostModel>>> getFeed();
  Future<Either<Failure, String>> createPost({
    required String content,
    required String userId,
    String? image,
  });
  Future<Either<Failure, String>> updatePost({
    required String id,
    required String content,
    required String userId,
    String? image,
  });
  Future<Either<Failure, String>> deletePost({required String id});

  // Comments
  Future<Either<Failure, String>> addComment({
    required String postId,
    required String content,
    required String userId,
  });
  Future<Either<Failure, List<CommentModel>>> getComments({
    required String postId,
  });
  Future<Either<Failure, String>> updateComment({
    required String id,
    required String content,
    required String userId,
  });
  Future<Either<Failure, String>> deleteComment({required String id});
}

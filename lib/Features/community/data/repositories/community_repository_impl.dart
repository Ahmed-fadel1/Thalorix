import 'package:dartz/dartz.dart';
import 'package:thalorix_app/Features/community/data/data_sources/community_remote_data_source.dart';
import 'package:thalorix_app/Features/community/data/models/comment_model.dart';
import 'package:thalorix_app/Features/community/data/models/post_model.dart';
import 'package:thalorix_app/Features/community/domain/repositories/community_repository.dart';
import 'package:thalorix_app/core/errors/failures.dart';

class CommunityRepositoryImpl implements CommunityRepository {
  final CommunityRemoteDataSource remote;

  CommunityRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, List<PostModel>>> getFeed() async {
    try {
      final response = await remote.getFeed();
      final data = response.data;

      if (data is Map<String, dynamic>) {
        // Handle: { "data": [...] } or { "posts": [...] } or direct list
        final List<dynamic> postsList =
            data['data'] ?? data['posts'] ?? data['feed'] ?? [];
        final posts = postsList
            .map((json) => PostModel.fromJson(json as Map<String, dynamic>))
            .toList();
        return Right(posts);
      } else if (data is List) {
        final posts = data
            .map((json) => PostModel.fromJson(json as Map<String, dynamic>))
            .toList();
        return Right(posts);
      }

      return Right([]);
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> createPost({
    required String content,
    required String userId,
    String? image,
  }) async {
    try {
      final response = await remote.createPost(
        content: content,
        userId: userId,
        image: image,
      );
      final data = response.data;

      if (data is Map<String, dynamic>) {
        // Check if the response indicates an error
        if (response.statusCode != null && response.statusCode! >= 400) {
          final errorMsg = data['message'] is List
              ? (data['message'] as List).join('\n')
              : data['message']?.toString() ?? 'Server error';
          return Left(ServerFailure(errorMsg));
        }
        if (data['message'] is List) {
          return Left(ServerFailure((data['message'] as List).join('\n')));
        }
        return Right(data['message'] ?? 'Post created successfully');
      }
      return const Right('Post created successfully');
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> updatePost({
    required String id,
    required String content,
    required String userId,
    String? image,
  }) async {
    try {
      final response = await remote.updatePost(
        id: id,
        content: content,
        userId: userId,
        image: image,
      );
      final data = response.data;

      if (data is Map<String, dynamic>) {
        if (data['message'] is List) {
          return Left(ServerFailure((data['message'] as List).join('\n')));
        }
        return Right(data['message'] ?? 'Post updated successfully');
      }
      return const Right('Post updated successfully');
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> deletePost({required String id}) async {
    try {
      final response = await remote.deletePost(id: id);
      final data = response.data;

      if (data is Map<String, dynamic>) {
        return Right(data['message'] ?? 'Post deleted successfully');
      }
      return const Right('Post deleted successfully');
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> addComment({
    required String postId,
    required String content,
    required String userId,
  }) async {
    try {
      final response = await remote.addComment(
        postId: postId,
        content: content,
        userId: userId,
      );
      final data = response.data;

      if (data is Map<String, dynamic>) {
        if (data['message'] is List) {
          return Left(ServerFailure((data['message'] as List).join('\n')));
        }
        return Right(data['message'] ?? 'Comment added successfully');
      }
      return const Right('Comment added successfully');
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CommentModel>>> getComments({
    required String postId,
  }) async {
    try {
      final response = await remote.getComments(postId: postId);
      final data = response.data;

      if (data is Map<String, dynamic>) {
        final List<dynamic> commentsList =
            data['data'] ?? data['comments'] ?? [];
        final comments = commentsList
            .map(
                (json) => CommentModel.fromJson(json as Map<String, dynamic>))
            .toList();
        return Right(comments);
      } else if (data is List) {
        final comments = data
            .map(
                (json) => CommentModel.fromJson(json as Map<String, dynamic>))
            .toList();
        return Right(comments);
      }

      return Right([]);
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> updateComment({
    required String id,
    required String content,
    required String userId,
  }) async {
    try {
      final response = await remote.updateComment(
        id: id,
        content: content,
        userId: userId,
      );
      final data = response.data;

      if (data is Map<String, dynamic>) {
        if (data['message'] is List) {
          return Left(ServerFailure((data['message'] as List).join('\n')));
        }
        return Right(data['message'] ?? 'Comment updated successfully');
      }
      return const Right('Comment updated successfully');
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> deleteComment({required String id}) async {
    try {
      final response = await remote.deleteComment(id: id);
      final data = response.data;

      if (data is Map<String, dynamic>) {
        return Right(data['message'] ?? 'Comment deleted successfully');
      }
      return const Right('Comment deleted successfully');
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(ServerFailure(e.toString()));
    }
  }
}
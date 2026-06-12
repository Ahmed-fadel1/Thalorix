import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:thalorix_app/core/network/dio_helper.dart';
import 'package:thalorix_app/core/network/end_point.dart';

class CommunityRemoteDataSource {
  // ==================== Posts ====================

  Future<Response> getFeed() async {
    return await DioHelper.getData(
      url: ApiEndpoints.communityFeed,
    );
  }

  Future<Response> createPost({
    required String content,
    required String userId,
    String? image,
  }) async {
    final body = {
      'content': content,
      'userId': userId,
      if (image != null && image.isNotEmpty) 'image': image,
    };
    debugPrint('📤 CREATE POST - URL: ${ApiEndpoints.communityPost}');
    debugPrint('📤 CREATE POST - Body: $body');

    try {
      final response = await DioHelper.postData(
        url: ApiEndpoints.communityPost,
        data: body,
      );
      debugPrint('✅ CREATE POST - Response status: ${response.statusCode}');
      debugPrint('✅ CREATE POST - Response data: ${response.data}');
      return response;
    } catch (e) {
      debugPrint('❌ CREATE POST - Error: $e');
      rethrow;
    }
  }

  Future<Response> updatePost({
    required String id,
    required String content,
    required String userId,
    String? image,
  }) async {
    return await DioHelper.patchData(
      url: ApiEndpoints.communityPostById(id),
      data: {
        'content': content,
        'userId': userId,
        if (image != null) 'image': image,
      },
    );
  }

  Future<Response> deletePost({required String id}) async {
    return await DioHelper.deleteData(
      url: ApiEndpoints.communityPostById(id),
    );
  }

  // ==================== Comments ====================

  Future<Response> addComment({
    required String postId,
    required String content,
    required String userId,
  }) async {
    final body = {
      'content': content,
      'userId': userId,
    };
    debugPrint(
        '📤 ADD COMMENT - URL: ${ApiEndpoints.communityAddComment(postId)}');
    debugPrint('📤 ADD COMMENT - Body: $body');

    try {
      final response = await DioHelper.postData(
        url: ApiEndpoints.communityAddComment(postId),
        data: body,
      );
      debugPrint('✅ ADD COMMENT - Response status: ${response.statusCode}');
      debugPrint('✅ ADD COMMENT - Response data: ${response.data}');
      return response;
    } catch (e) {
      debugPrint('❌ ADD COMMENT - Error: $e');
      rethrow;
    }
  }

  Future<Response> getComments({required String postId}) async {
    return await DioHelper.getData(
      url: ApiEndpoints.communityGetComments(postId),
    );
  }

  Future<Response> updateComment({
    required String id,
    required String content,
    required String userId,
  }) async {
    return await DioHelper.patchData(
      url: ApiEndpoints.communityCommentById(id),
      data: {
        'content': content,
        'userId': userId,
      },
    );
  }

  Future<Response> deleteComment({required String id}) async {
    return await DioHelper.deleteData(
      url: ApiEndpoints.communityCommentById(id),
    );
  }
}
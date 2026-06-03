import 'package:dio/dio.dart';
import 'package:thalorix_app/core/network/dio_helper.dart';
import 'package:thalorix_app/core/network/end_point.dart';

class AiChatRemoteDataSource {
  /// GET /ai/health
  Future<Response> healthCheck() async {
    return await DioHelper.getData(url: ApiEndpoints.aiHealth);
  }

  /// GET /ai/ready
  Future<Response> readyCheck() async {
    return await DioHelper.getData(url: ApiEndpoints.aiReady);
  }

  /// POST /ai/chat — Generate a new project
  Future<Response> createProject({
    required String prompt,
    String? userId,
    String? stack,
  }) async {
    return await DioHelper.postData(
      url: ApiEndpoints.aiChat,
      data: {
        'prompt': prompt,
        if (userId != null) 'userId': userId,
        if (stack != null) 'stack': stack,
      },
    );
  }

  /// POST /ai/upload — Upload file (multipart)
  Future<Response> uploadFile({
    required String filePath,
    String? sessionId,
  }) async {
    final fileName = filePath.split('/').last.split('\\').last;
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath, filename: fileName),
      if (sessionId != null) 'session_id': sessionId,
    });
    return await DioHelper.postData(
      url: ApiEndpoints.aiUpload,
      data: formData,
      headers: {'Content-Type': 'multipart/form-data'},
    );
  }

  /// GET /ai/projects/deployed
  Future<Response> getDeployedProjects() async {
    return await DioHelper.getData(url: ApiEndpoints.aiDeployedProjects);
  }

  /// GET /ai/projects/{id}
  Future<Response> getProject({required String projectId}) async {
    return await DioHelper.getData(
      url: ApiEndpoints.aiProjectById(projectId),
    );
  }

  /// PATCH /ai/projects/{id}/edit
  Future<Response> editProject({
    required String projectId,
    required String prompt,
  }) async {
    return await DioHelper.patchData(
      url: ApiEndpoints.editAiProject(projectId),
      data: {'prompt': prompt},
    );
  }

  /// GET /ai/project/{sessionId}/{projectName}/manifest
  Future<Response> getManifest({
    required String sessionId,
    required String projectName,
  }) async {
    return await DioHelper.getData(
      url: ApiEndpoints.aiProjectManifest(sessionId, projectName),
    );
  }

  /// GET /ai/project/{sessionId}/{projectName}/status
  Future<Response> getProjectStatus({
    required String sessionId,
    required String projectName,
  }) async {
    return await DioHelper.getData(
      url: ApiEndpoints.aiProjectStatus(sessionId, projectName),
    );
  }

  /// GET /ai/project/{sessionId}/{projectName}/file?path=...
  Future<Response> getProjectFile({
    required String sessionId,
    required String projectName,
    required String filePath,
  }) async {
    return await DioHelper.getData(
      url: ApiEndpoints.aiProjectFile(sessionId, projectName),
      query: {'path': filePath},
    );
  }

  /// GET /ai/project/{sessionId}/{projectName}/dist.zip
  Future<Response> getDistZip({
    required String sessionId,
    required String projectName,
  }) async {
    return await DioHelper.getData(
      url: ApiEndpoints.aiProjectDistZip(sessionId, projectName),
    );
  }

  /// GET /ai/project/{sessionId}/{projectName}/source.zip
  Future<Response> getSourceZip({
    required String sessionId,
    required String projectName,
  }) async {
    return await DioHelper.getData(
      url: ApiEndpoints.aiProjectSourceZip(sessionId, projectName),
    );
  }

  /// GET /ai/project/{sessionId}/{projectName}/preview
  Future<Response> getPreview({
    required String sessionId,
    required String projectName,
  }) async {
    return await DioHelper.getData(
      url: ApiEndpoints.aiProjectPreview(sessionId, projectName),
    );
  }
}

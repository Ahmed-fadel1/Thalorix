class ApiEndpoints {
  // Auth
  static const String signUp = 'auth/mob/register';
  static const String login = 'auth/mob/login';
  static const String verifyOtp = 'otp/verify';
  static const String resendOtp = 'otp/request';

  // Community - Posts
  static const String communityPost = 'community/post';
  static const String communityFeed = 'community/feed';
  static String communityPostById(String id) => 'community/post/$id';

  // Community - Comments
  static String communityAddComment(String postId) =>
      'community/$postId/comment';
  static String communityGetComments(String postId) =>
      'community/$postId/comments';
  static String communityCommentById(String id) => 'community/comment/$id';

  // AI Builder
  static const String aiHealth = 'ai/health';
  static const String aiReady = 'ai/ready';
  static const String aiChat = 'ai/chat';
  static const String aiUpload = 'ai/upload';
  static const String aiDeployedProjects = 'ai/projects/deployed';
  static String aiProjectById(String id) => 'ai/projects/$id';
  static String editAiProject(String id) => 'ai/projects/$id/edit';
  static String aiProjectManifest(String sessionId, String projectName) =>
      'ai/project/$sessionId/$projectName/manifest';
  static String aiProjectStatus(String sessionId, String projectName) =>
      'ai/project/$sessionId/$projectName/status';
  static String aiProjectFile(String sessionId, String projectName) =>
      'ai/project/$sessionId/$projectName/file';
  static String aiProjectDistZip(String sessionId, String projectName) =>
      'ai/project/$sessionId/$projectName/dist.zip';
  static String aiProjectSourceZip(String sessionId, String projectName) =>
      'ai/project/$sessionId/$projectName/source.zip';
  static String aiProjectPreview(String sessionId, String projectName) =>
      'ai/project/$sessionId/$projectName/preview';
}

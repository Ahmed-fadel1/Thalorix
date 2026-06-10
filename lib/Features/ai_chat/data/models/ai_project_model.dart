class AiProjectModel {
  final String id;
  final String? sessionId;
  final String? jobId;
  final String status;
  final String? stack;
  final String? previewUrl;
  final String? projectName;
  final String? prompt;
  final String? userId;
  final DateTime? createdAt;

  AiProjectModel({
    required this.id,
    this.sessionId,
    this.jobId,
    required this.status,
    this.stack,
    this.previewUrl,
    this.projectName,
    this.prompt,
    this.userId,
    this.createdAt,
  });

  factory AiProjectModel.fromJson(Map<String, dynamic> json) {
    return AiProjectModel(
      id: json['_id'] ?? json['projectId'] ?? '',
      sessionId: json['sessionId'] ?? json['session_id'],
      jobId: json['jobId'],
      status: json['status'] ?? 'unknown',
      stack: json['stack'],
      previewUrl: json['previewUrl'],
      projectName: json['projectName'] ?? json['name'],
      prompt: json['prompt'],
      userId: json['userId'],
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'sessionId': sessionId,
      'jobId': jobId,
      'status': status,
      'stack': stack,
      'previewUrl': previewUrl,
      'projectName': projectName,
      'prompt': prompt,
      'userId': userId,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}

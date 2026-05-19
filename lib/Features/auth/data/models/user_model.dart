class UserModel {
  final String id;
  final String name;
  final String email;

  final String role;
  final String accessToken;
  final String refreshToken;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.accessToken,
    required this.refreshToken,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> data = json['data'] ?? json['user'] ?? json;

    return UserModel(
      id: (data['_id'] ?? data['id'] ?? '').toString(),
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      role: data['role'] ?? 'user',
      accessToken: json['accessToken'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
    );
  }
}


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
    final user = json['user'];

    return UserModel(
      id: user['id'],
      name: user['name'],
      email: user['email'],
      role: user['role'],
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }
}
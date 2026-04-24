class User {
  final String name;
  final String email;
  final String phone;
  final String role;
  final String? token;

  User({
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    this.token,
  });
}

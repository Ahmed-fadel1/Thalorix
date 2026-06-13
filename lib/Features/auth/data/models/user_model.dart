class UserModel {
  final String id;
  final String name;
  final String email;
  final String role;
  final bool isVerified;
  final String? phone;
  final String? bio;
  final String? profilePic;

  UserModel({
    this.bio,
    this.phone,
    this.profilePic,
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.isVerified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: (json['_id'] ?? json['id'])?.toString() ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      isVerified: json['isVerified'] ?? false,
      phone: json['phone'] ?? null,
      bio: json['bio'] ?? null,
      profilePic: json['profilePic'] ?? json['avatar'] ?? json['photo'] ?? json['image'] ?? json['profilePicture'] ?? null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email, 
      'role': role,
      'isVerified': isVerified,
      'phone': phone,
      'bio': bio,
      'profilePic': profilePic,
    };
  }
}

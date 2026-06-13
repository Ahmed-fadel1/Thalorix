import 'package:thalorix_app/Features/auth/data/models/user_model.dart';
import 'package:thalorix_app/core/network/dio_helper.dart';
import 'package:dio/dio.dart';

class UserRepository {
  Future<void> updateUser({
    required String userId,
    String? name,
    String? email,
    String? phone,
    String? bio,
    String? profilePic,
  }) async {
    final body = <String, dynamic>{};

    print('👤 USER ID: $userId');

    if (name != null && name.isNotEmpty) body['name'] = name;
    if (email != null && email.isNotEmpty) body['email'] = email;
    if (phone != null && phone.isNotEmpty) body['phone'] = phone;
    if (bio != null) body['bio'] = bio;
    if (profilePic != null && profilePic.isNotEmpty) {
      body['profilePic'] = profilePic;
      body['avatar'] = profilePic; 
      body['photo'] = profilePic;
      body['image'] = profilePic;
      body['profilePicture'] = profilePic;
    }

    print('📦 BODY: $body');
    await DioHelper.patchData(url: 'users/$userId', data: body);
  }

  // Get Data From API
  Future<UserModel> getUserData({required String userId}) async {
    if (userId.isEmpty) {
      throw Exception("User ID is empty!");
    }

    print('👤 REQUESTING USER ID: $userId');

    try {
      final response = await DioHelper.getData(url: 'users/$userId');

      return UserModel.fromJson(response.data);
    } catch (e) {
      print("❌ ERROR FETCHING DATA: $e");
      rethrow;
    }
  }

  static Future<List<UserModel>> getAllUsers() async {
    final response = await DioHelper.getData(url: 'users');
    final List data = response.data['data'];
    return data.map((user) => UserModel.fromJson(user)).toList();
  }

  Future<String> uploadProfileImage({required String imagePath, required String slug}) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(imagePath),
    });

    final response = await DioHelper.postData(
      url: 'cloudinary/upload/$slug',
      data: formData,
    );

    // Assuming response contains { "url": "..." } or { "data": { "url": "..." } }
    final imageUrl = response.data['url'] ?? response.data['data']?['url'];
    if (imageUrl == null) throw Exception("Failed to upload image");
    return imageUrl;
  }
}

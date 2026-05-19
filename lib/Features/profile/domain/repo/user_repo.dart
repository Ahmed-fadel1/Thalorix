import 'package:thalorix_app/Features/auth/data/models/user_model.dart';
import 'package:thalorix_app/core/network/dio_helper.dart';

class UserRepository {
  Future<void> updateUser({
    required String userId,
    String? name,
    String? email,
    String? phone,
    String? bio,
  }) async {
    final body = <String, dynamic>{};

    print('👤 USER ID: $userId');
    print('📦 BODY: $body');

    if (name != null && name.isNotEmpty) body['name'] = name;
    if (email != null && email.isNotEmpty) body['email'] = email;
    if (phone != null && phone.isNotEmpty) body['phone'] = phone;
    if (bio != null && bio.isNotEmpty) body['bio'] = bio;

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
}

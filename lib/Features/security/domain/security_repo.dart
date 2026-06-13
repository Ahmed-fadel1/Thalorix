import 'package:thalorix_app/core/network/dio_helper.dart';

class SecurityRepo {
  Future<void> updatePassword({
    required String userId,
    required String oldPassword,
    required String newPassword,
  }) async {
    final body = <String, dynamic>{};
    if (oldPassword.isNotEmpty) body['oldPassword'] = oldPassword;
    if (newPassword.isNotEmpty) body['newPassword'] = newPassword;

    await DioHelper.patchData(url: "users/$userId/change-password", data: body);
    print('📦 BODY: $body');
  }
}

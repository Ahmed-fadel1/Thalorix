
import 'package:dio/dio.dart';

import 'package:thalorix_app/core/network/dio_helper.dart';
import 'package:thalorix_app/core/network/end_point.dart';

class AuthRemoteDataSource {
  Future<Response> signUp({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
    required String role,
  }) async {
    return await DioHelper.postData(
      url: ApiEndpoints.signUp,
      data: {
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
        "cPassword": confirmPassword,
      },
    );
  }
    Future<Response> login({
      required String email,
      required String password,
    }) async {
      return await DioHelper.postData(
        url: ApiEndpoints.login,
        data: {"email": email, "password": password},
      );
    }

  Future<Response> forgotPassword(String email) async {
    return await DioHelper.postData(
      url: ApiEndpoints.forgotPassword,
      data: {"email": email},
    );
  }

  Future<Response> resetPassword({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    return await DioHelper.postData(
      url: ApiEndpoints.resetPassword,
      data: {
        "email": email,
        "code": code,
        "newPassword": newPassword,
      },
    );
  }
}


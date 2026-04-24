
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
        "role": role,
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
  }


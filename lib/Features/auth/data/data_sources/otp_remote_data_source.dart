import 'package:dio/dio.dart';
import 'package:thalorix_app/core/network/dio_helper.dart';
import 'package:thalorix_app/core/network/end_point.dart';

class OtpRemoteDataSource {
  Future<Response> verifyOtp({
    required String email,
    required String code,
  }) async {
    return await DioHelper.postData(
      url: ApiEndpoints.verifyOtp,
      data: {
        "email": email, "code": code.toString(),
        //"type": "phone_verification",
      },

      headers: {'Content-Type': 'application/json'},
    );
  }

  Future<Response> resendOtp({required String email}) async {
    return await DioHelper.postData(
      url: ApiEndpoints.resendOtp,
      data: {"email": email, "type": "email_verification"},

      headers: {'Content-Type': 'application/json'},
    );
  }
}

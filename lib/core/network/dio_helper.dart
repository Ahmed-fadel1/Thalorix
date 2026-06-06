import 'package:dio/dio.dart';
import 'package:thalorix_app/core/cache/cache_helper.dart';
import 'package:thalorix_app/core/errors/error_handler.dart';

class DioHelper {
  static late Dio dio;

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: "http://10.0.2.2:5000/api/v1/",
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        headers: _headers(),
      ),
    );

    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) async {
    try {
      return await dio.get(
        url,
        queryParameters: query,
        options: Options(headers: headers ?? _headers()),
      );
    } on DioException catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) async {
    try {
      return await dio.post(
        url,
        data: data,
        queryParameters: query,
        options: Options(headers: headers ?? _headers()),
      );
    } on DioException catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  static Future<Response> patchData({
    required String url,
    Map<String, dynamic>? data,
  }) async {
    try {
      final headers = _headers();
      return await dio.patch(
        url,
        data: data,
        options: Options(headers: headers),
      );
    } on DioException catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  static Map<String, String> _headers() {
    final token = CacheHelper.getToken();
    return {
      'Content-Type': 'application/json',
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
  }
}

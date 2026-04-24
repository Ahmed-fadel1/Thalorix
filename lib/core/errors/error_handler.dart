
import 'package:dio/dio.dart';
import 'package:thalorix_app/core/errors/failures.dart';

class ErrorHandler {
  static Failure handle(dynamic error) {
    if (error is DioException) {
 
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return ServerFailure('Connection timeout');
        case DioExceptionType.receiveTimeout:
          return ServerFailure('Server took too long to respond');
        case DioExceptionType.badCertificate:
          return ServerFailure('Bad certificate');
        case DioExceptionType.connectionError:
          return NetworkFailure('No internet connection');
        default:
          break;
      }

      final response = error.response;

      if (response != null && response.data is Map) {
        final map = response.data as Map;

        if (map['message'] is List) {
          return ServerFailure((map['message'] as List).join('\n'));
        }

        if (map['message'] != null) {
          return ServerFailure(map['message'].toString());
        }
      }

      return ServerFailure('Server error');
    }

    return ServerFailure('Unexpected error occurred');
  }
}
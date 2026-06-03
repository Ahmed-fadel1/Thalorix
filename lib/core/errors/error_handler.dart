
import 'package:dio/dio.dart';
import 'package:thalorix_app/core/errors/failures.dart';

class ErrorHandler {
  static Failure handle(dynamic error) {
    if (error is DioException) {
      return _handleDioError(error);
    }
    return ServerFailure('Unexpected error occurred');
  }

  static Failure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Timeout error: Please check your connection');
      case DioExceptionType.badResponse:
        return _handleResponseError(error.response);
      case DioExceptionType.cancel:
        return ServerFailure('Request was cancelled');
      case DioExceptionType.connectionError:
        return NetworkFailure('No internet connection');
      default:
        return ServerFailure('Something went wrong. Please try again.');
    }
  }

  static Failure _handleResponseError(Response? response) {
    if (response != null && response.data != null) {
      final data = response.data;
      
      // Extract message from common API response formats
      String? message;
      if (data is Map) {
        message = data['message']?.toString() ?? data['error']?.toString();
        
        // Handle list of messages (common in validation errors)
        if (data['message'] is List) {
          message = (data['message'] as List).join('\n');
        }
      } else if (data is String) {
        message = data;
      }

      if (message != null && message.isNotEmpty) {
        return ServerFailure(message);
      }
    }

    return ServerFailure('Server returned an error (${response?.statusCode})');
  }
}
import 'package:dartz/dartz.dart';
import 'package:thalorix_app/core/errors/failures.dart';
import '../../data/models/login_response_model.dart';
import '../../data/models/user_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> signUp({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
    required String role,
  });

  Future<Either<Failure, LoginResponseModel>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, String>> forgotPassword(String email);

  Future<Either<Failure, String>> resetPassword({
    required String email,
    required String code,
    required String newPassword,
  });
}

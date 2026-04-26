
import 'package:dartz/dartz.dart';
import 'package:thalorix_app/core/errors/failures.dart';
import '../../data/models/user_model.dart';

abstract class AuthRepository {

  // SIGN UP 
  Future<Either<Failure, String>> signUp({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
    required String role,
  });

  // LOGIN 
  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  });
}
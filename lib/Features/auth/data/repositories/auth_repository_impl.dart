
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:thalorix_app/Features/auth/data/models/user_model.dart';
import 'package:thalorix_app/core/errors/failures.dart';
import 'package:thalorix_app/Features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:thalorix_app/Features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;

  AuthRepositoryImpl(this.remote);


  @override
  Future<Either<Failure, String>> signUp({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
    required String role,
  }) async {
    try {
      final response = await remote.signUp(
        name: name,
        email: email,
        phone: phone,
        password: password,
        confirmPassword: confirmPassword,
        role: role,
      );

      final data = response.data;

      if (data is! Map<String, dynamic>) {
        return Left(ServerFailure("Invalid response format"));
      }

   
      if (data['message'] is List) {
        return Left(ServerFailure(
          (data['message'] as List).join('\n'),
        ));
      }

    
      return Right(data['message'] ?? "Account created successfully");

    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return Left(ServerFailure(e.toString()));
    }
  }
  
@override
Future<Either<Failure, UserModel>> login({
  required String email,
  required String password,
}) async {
  try {
    final response = await remote.login(
      email: email,
      password: password,
    );

    final data = response.data;

    if (data is! Map<String, dynamic>) {
      return Left(ServerFailure("Invalid response format"));
    }


    if (data['message'] is List) {
      return Left(ServerFailure(
        (data['message'] as List).join('\n'),
      ));
    }


    final user = UserModel.fromJson(data);

    return Right(user);

    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return Left(ServerFailure(e.toString()));
    }
}
}
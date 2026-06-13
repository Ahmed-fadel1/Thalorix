import 'package:dartz/dartz.dart';
import 'package:thalorix_app/core/errors/failures.dart';
import 'package:thalorix_app/Features/auth/data/models/login_response_model.dart';
import 'package:thalorix_app/Features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repo;

  LoginUseCase(this.repo);

  Future<Either<Failure, LoginResponseModel>> call({
    required String email,
    required String password,
  }) {
    return repo.login(
      email: email,
      password: password,
    );
  }
}
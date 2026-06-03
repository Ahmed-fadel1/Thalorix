
import 'package:thalorix_app/Features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:thalorix_app/core/errors/failures.dart';

class SignUpUseCase {
  final AuthRepository repo;

  SignUpUseCase(this.repo);

  Future<Either<Failure, String>> call({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
    required String role,
  }) {
    return repo.signUp(
      name: name,
      email: email,
      phone: phone,
      password: password,
      confirmPassword: confirmPassword,
      role: role,
    );
  }
}

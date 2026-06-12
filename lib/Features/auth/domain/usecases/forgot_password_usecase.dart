import 'package:dartz/dartz.dart';
import 'package:thalorix_app/core/errors/failures.dart';
import 'package:thalorix_app/Features/auth/domain/repositories/auth_repository.dart';

class ForgotPasswordUseCase {
  final AuthRepository repository;

  ForgotPasswordUseCase(this.repository);

  Future<Either<Failure, String>> call(String email) async {
    return await repository.forgotPassword(email);
  }
}

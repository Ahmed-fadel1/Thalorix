import 'package:dartz/dartz.dart';
import 'package:thalorix_app/core/errors/failures.dart';
import 'package:thalorix_app/Features/auth/domain/repositories/auth_repository.dart';

class ResetPasswordUseCase {
  final AuthRepository repository;

  ResetPasswordUseCase(this.repository);

  Future<Either<Failure, String>> call({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    return await repository.resetPassword(
      email: email,
      code: code,
      newPassword: newPassword,
    );
  }
}

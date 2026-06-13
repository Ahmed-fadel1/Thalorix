import 'package:dartz/dartz.dart';
import 'package:thalorix_app/core/errors/failures.dart';
import 'package:thalorix_app/Features/auth/domain/repositories/otp_repository.dart';

class VerifyOtpUseCase {
  final OtpRepository repository;

  VerifyOtpUseCase(this.repository);

  Future<Either<Failure, bool>> call({
    required String email,
    required String code,
   
  }) async {
    return await repository.verifyOtp(email: email, code: code);
  }
}

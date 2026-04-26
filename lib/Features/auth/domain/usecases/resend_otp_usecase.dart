import 'package:dartz/dartz.dart';
import 'package:thalorix_app/core/errors/failures.dart';
import 'package:thalorix_app/Features/auth/domain/repositories/otp_repository.dart';

class ResendOtpUseCase {
  final OtpRepository repository;

  ResendOtpUseCase(this.repository);

  Future<Either<Failure, bool>> call({
    required String email,
  }) async {
    return await repository.resendOtp(email: email);
  }
}

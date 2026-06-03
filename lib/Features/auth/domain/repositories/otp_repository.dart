import 'package:dartz/dartz.dart';
import 'package:thalorix_app/core/errors/failures.dart';

abstract class OtpRepository {
  Future<Either<Failure, bool>> verifyOtp({
    required String email,
    required String code,
  
  });

  Future<Either<Failure, bool>> resendOtp({
    required String email,
  });
}

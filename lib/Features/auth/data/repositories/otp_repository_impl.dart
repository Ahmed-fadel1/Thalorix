import 'package:dartz/dartz.dart';
import 'package:thalorix_app/Features/auth/data/data_sources/otp_remote_data_source.dart';
import 'package:thalorix_app/Features/auth/domain/repositories/otp_repository.dart';
import 'package:thalorix_app/core/errors/failures.dart';

class OtpRepositoryImpl implements OtpRepository {
  final OtpRemoteDataSource remoteDataSource;

  OtpRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, bool>> verifyOtp({
    required String email,
    required String code,
    
  }) async {
    try {
      final response = await remoteDataSource.verifyOtp(email: email, code: code);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return const Right(true);
      } else {
        return Left(ServerFailure(response.data['message'] ?? "Verification failed"));
      }
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> resendOtp({required String email}) async {
    try {
      final response = await remoteDataSource.resendOtp(email: email);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return const Right(true);
      } else {
        return Left(ServerFailure(response.data['message'] ?? "Resend failed"));
      }
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(ServerFailure(e.toString()));
    }
  }
}

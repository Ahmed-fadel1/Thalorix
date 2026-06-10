import 'package:dartz/dartz.dart';
import 'package:thalorix_app/core/errors/failures.dart';
import '../repositories/cart_repository.dart';

class CreateCheckoutSessionUseCase {
  final CartRepository repository;

  CreateCheckoutSessionUseCase(this.repository);

  Future<Either<Failure, String>> call(String orderId) {
    return repository.createCheckoutSession(orderId);
  }
}

import 'package:dartz/dartz.dart';
import 'package:thalorix_app/core/errors/failures.dart';
import '../repositories/cart_repository.dart';

class CompleteOrderUseCase {
  final CartRepository repository;

  CompleteOrderUseCase(this.repository);

  Future<Either<Failure, void>> call(String orderId) {
    return repository.completeOrder(orderId);
  }
}

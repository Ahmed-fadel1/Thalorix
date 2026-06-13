import 'package:dartz/dartz.dart';
import 'package:thalorix_app/core/errors/failures.dart';
import '../repositories/cart_repository.dart';

class DeleteOrderUseCase {
  final CartRepository repository;

  DeleteOrderUseCase(this.repository);

  Future<Either<Failure, void>> call(String orderId) {
    return repository.deleteOrder(orderId);
  }
}

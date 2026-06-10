import 'package:dartz/dartz.dart';
import 'package:thalorix_app/core/errors/failures.dart';
import '../entities/order_entity.dart';
import '../repositories/cart_repository.dart';

class CreateOrderUseCase {
  final CartRepository repository;

  CreateOrderUseCase(this.repository);

  Future<Either<Failure, OrderEntity>> call({
    required List<CartItemEntity> items,
  }) {
    return repository.createOrder(items: items);
  }
}

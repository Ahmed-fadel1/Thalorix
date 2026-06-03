import 'package:dartz/dartz.dart';
import 'package:thalorix_app/core/errors/failures.dart';
import '../entities/order_entity.dart';
import '../repositories/cart_repository.dart';

class GetMyOrdersUseCase {
  final CartRepository repository;

  GetMyOrdersUseCase(this.repository);

  Future<Either<Failure, List<OrderEntity>>> call() {
    return repository.getMyOrders();
  }
}

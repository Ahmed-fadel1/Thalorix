import 'package:dartz/dartz.dart';
import 'package:thalorix_app/core/errors/failures.dart';
import '../entities/order_entity.dart';
import '../repositories/cart_repository.dart';

class AddToCartUseCase {
  final CartRepository repository;

  AddToCartUseCase(this.repository);

  Future<Either<Failure, OrderEntity>> call({
    required String templateId,
    required int quantity,
  }) {
    return repository.addToCart(templateId: templateId, quantity: quantity);
  }
}

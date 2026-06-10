import 'package:dartz/dartz.dart';
import 'package:thalorix_app/core/errors/failures.dart';
import '../entities/order_entity.dart';

abstract class CartRepository {
  Future<Either<Failure, List<OrderEntity>>> getMyOrders();
  
  Future<Either<Failure, OrderEntity>> addToCart({
    required String templateId,
    required int quantity,
  });
  
  Future<Either<Failure, OrderEntity>> createOrder({
    required List<CartItemEntity> items,
  });

  Future<Either<Failure, void>> deleteOrder(String orderId);
  
  Future<Either<Failure, void>> completeOrder(String orderId);

  Future<Either<Failure, String>> createCheckoutSession(String orderId);
}

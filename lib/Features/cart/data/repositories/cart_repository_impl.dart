import 'package:dartz/dartz.dart';
import 'package:thalorix_app/core/errors/error_handler.dart';
import 'package:thalorix_app/core/errors/failures.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/repositories/cart_repository.dart';
import '../data_source/cart_remote_data_source.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource remoteDataSource;

  CartRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<OrderEntity>>> getMyOrders() async {
    try {
      final result = await remoteDataSource.getMyOrders();
      return Right(result);
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, OrderEntity>> addToCart({
    required String templateId,
    required int quantity,
  }) async {
    try {
      final result = await remoteDataSource.addToCart(
        templateId: templateId,
        quantity: quantity,
      );
      return Right(result);
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, void>> deleteOrder(String orderId) async {
    try {
      await remoteDataSource.deleteOrder(orderId);
      return const Right(null);
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, void>> completeOrder(String orderId) async {
    try {
      await remoteDataSource.completeOrder(orderId);
      return const Right(null);
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(ErrorHandler.handle(e));
    }
  }
}

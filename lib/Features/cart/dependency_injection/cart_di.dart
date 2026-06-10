import '../data/data_source/cart_remote_data_source.dart';
import '../data/repositories/cart_repository_impl.dart';
import '../domain/repositories/cart_repository.dart';
import '../domain/usecases/get_my_orders_usecase.dart';
import '../domain/usecases/add_to_cart_usecase.dart';
import '../domain/usecases/delete_order_usecase.dart';
import '../domain/usecases/complete_order_usecase.dart';
import '../domain/usecases/create_checkout_session_usecase.dart';
import '../domain/usecases/create_order_usecase.dart';
import '../presentation/cubit/cart_cubit.dart';

class CartDI {
  CartDI._();

  static CartRemoteDataSource _remoteDataSource() =>
      CartRemoteDataSourceImpl();

  static CartRepository _repository() =>
      CartRepositoryImpl(_remoteDataSource());

  static GetMyOrdersUseCase _getMyOrdersUseCase() =>
      GetMyOrdersUseCase(_repository());

  static AddToCartUseCase _addToCartUseCase() =>
      AddToCartUseCase(_repository());

  static DeleteOrderUseCase _deleteOrderUseCase() =>
      DeleteOrderUseCase(_repository());

  static CompleteOrderUseCase _completeOrderUseCase() =>
      CompleteOrderUseCase(_repository());

  static CreateCheckoutSessionUseCase _createCheckoutSessionUseCase() =>
      CreateCheckoutSessionUseCase(_repository());

  static CreateOrderUseCase _createOrderUseCase() =>
      CreateOrderUseCase(_repository());

  static CartCubit provideCartCubit() => CartCubit(
        getMyOrdersUseCase: _getMyOrdersUseCase(),
        addToCartUseCase: _addToCartUseCase(),
        deleteOrderUseCase: _deleteOrderUseCase(),
        completeOrderUseCase: _completeOrderUseCase(),
        createCheckoutSessionUseCase: _createCheckoutSessionUseCase(),
        createOrderUseCase: _createOrderUseCase(),
      );
}

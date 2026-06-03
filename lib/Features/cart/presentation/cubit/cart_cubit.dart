import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_my_orders_usecase.dart';
import '../../domain/usecases/add_to_cart_usecase.dart';
import '../../domain/usecases/delete_order_usecase.dart';
import '../../domain/usecases/complete_order_usecase.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final GetMyOrdersUseCase getMyOrdersUseCase;
  final AddToCartUseCase addToCartUseCase;
  final DeleteOrderUseCase deleteOrderUseCase;
  final CompleteOrderUseCase completeOrderUseCase;

  CartCubit({
    required this.getMyOrdersUseCase,
    required this.addToCartUseCase,
    required this.deleteOrderUseCase,
    required this.completeOrderUseCase,
  }) : super(CartInitial());

  Future<void> getMyOrders({bool showLoading = true}) async {
    if (showLoading) emit(CartLoading());
    final result = await getMyOrdersUseCase();
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (orders) {
      
        final double totalPrice = orders.fold(
          0.0,
          (sum, order) => sum + (order.price * order.quantity),
        );
        final int cartCount = orders.length;

        emit(CartLoaded(
          orders: orders,
          totalPrice: totalPrice,
          cartCount: cartCount,
        ));
      },
    );
  }

  Future<void> addToCart(String templateId, {int quantity = 1}) async {
    emit(CartLoading());
    final result = await addToCartUseCase(templateId: templateId, quantity: quantity);
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (order) {
        getMyOrders(); 
      },
    );
  }

  Future<void> deleteOrder(String orderId) async {
    final currentState = state;
    if (currentState is! CartLoaded) return;

    emit(OrderDeleting(
      orders: currentState.orders,
      totalPrice: currentState.totalPrice,
      cartCount: currentState.cartCount,
    ));

    final result = await deleteOrderUseCase(orderId);
    result.fold(
      (failure) => emit(CartActionError(
        message: failure.message,
        orders: currentState.orders,
        totalPrice: currentState.totalPrice,
        cartCount: currentState.cartCount,
      )),
      (_) {
        final newOrders = currentState.orders.where((o) => o.id != orderId).toList();
        final newTotalPrice = newOrders.fold(0.0, (sum, o) => sum + (o.price * o.quantity));
        final newCartCount = newOrders.length;
        
        emit(OrderDeleted(
          orders: newOrders,
          totalPrice: newTotalPrice,
          cartCount: newCartCount,
        ));
        getMyOrders(showLoading: false); 
      },
    );
  }

  Future<void> completeOrder(String orderId) async {
    final currentState = state;
    if (currentState is! CartLoaded) return;

    emit(OrderCompleting(
      orders: currentState.orders,
      totalPrice: currentState.totalPrice,
      cartCount: currentState.cartCount,
    ));

    final result = await completeOrderUseCase(orderId);
    result.fold(
      (failure) => emit(CartActionError(
        message: failure.message,
        orders: currentState.orders,
        totalPrice: currentState.totalPrice,
        cartCount: currentState.cartCount,
      )),
      (_) {
        emit(OrderCompleted(
          orders: currentState.orders,
          totalPrice: currentState.totalPrice,
          cartCount: currentState.cartCount,
        ));
        getMyOrders(showLoading: false); 
      },
    );
  }

  Future<void> clearCart() async {
    final currentState = state;
    if (currentState is! CartLoaded) return;

    final ordersToDelete = currentState.orders;
    if (ordersToDelete.isEmpty) return;

    emit(OrderDeleting(
      orders: currentState.orders,
      totalPrice: currentState.totalPrice,
      cartCount: currentState.cartCount,
    ));

    
    final results = await Future.wait(
      ordersToDelete.map((order) async {
        final res = await deleteOrderUseCase(order.id);
        return MapEntry(order.id, res);
      }),
    );

    final failedIds = <String>[];
    String? firstErrorMessage;
    for (final entry in results) {
      entry.value.fold(
        (failure) {
          failedIds.add(entry.key);
          firstErrorMessage ??= failure.message;
        },
        (_) {},
      );
    }

    if (failedIds.isNotEmpty) {
      emit(CartActionError(
        message: "Failed to remove ${failedIds.length} items from cart. First error: $firstErrorMessage",
        orders: currentState.orders,
        totalPrice: currentState.totalPrice,
        cartCount: currentState.cartCount,
      ));
    } else {
      emit(const OrderDeleted(
        orders: [],
        totalPrice: 0.0,
        cartCount: 0,
      ));
    }
    await getMyOrders(showLoading: false);
  }

  Future<void> completeAllOrders() async {
    final currentState = state;
    if (currentState is! CartLoaded) return;

    final ordersToComplete = currentState.orders;
    if (ordersToComplete.isEmpty) return;

    emit(OrderCompleting(
      orders: currentState.orders,
      totalPrice: currentState.totalPrice,
      cartCount: currentState.cartCount,
    ));

   
    final results = await Future.wait(
      ordersToComplete.map((order) async {
        final res = await completeOrderUseCase(order.id);
        return MapEntry(order.id, res);
      }),
    );

    final failedIds = <String>[];
    String? firstErrorMessage;
    for (final entry in results) {
      entry.value.fold(
        (failure) {
          failedIds.add(entry.key);
          firstErrorMessage ??= failure.message;
        },
        (_) {},
      );
    }

    if (failedIds.isNotEmpty) {
      emit(CartActionError(
        message: "Failed to complete ${failedIds.length} orders. First error: $firstErrorMessage",
        orders: currentState.orders,
        totalPrice: currentState.totalPrice,
        cartCount: currentState.cartCount,
      ));
    } else {
      emit(OrderCompleted(
        orders: currentState.orders,
        totalPrice: currentState.totalPrice,
        cartCount: currentState.cartCount,
      ));
    }
    await getMyOrders(showLoading: false);
  }

  int getCartCount() {
    final currentState = state;
    if (currentState is CartLoaded) {
      return currentState.cartCount;
    }
    return 0;
  }
}

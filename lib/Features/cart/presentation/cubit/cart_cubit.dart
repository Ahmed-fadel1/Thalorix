import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thalorix_app/core/cache/cache_helper.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/usecases/get_my_orders_usecase.dart';
import '../../domain/usecases/add_to_cart_usecase.dart';
import '../../domain/usecases/delete_order_usecase.dart';
import '../../domain/usecases/complete_order_usecase.dart';
import '../../domain/usecases/create_checkout_session_usecase.dart';
import '../../domain/usecases/create_order_usecase.dart';
import '../../data/models/order_model.dart';

import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final GetMyOrdersUseCase getMyOrdersUseCase;
  final AddToCartUseCase addToCartUseCase;
  final DeleteOrderUseCase deleteOrderUseCase;
  final CompleteOrderUseCase completeOrderUseCase;
  final CreateCheckoutSessionUseCase createCheckoutSessionUseCase;
  final CreateOrderUseCase createOrderUseCase;

  final List<CartItemEntity> _localItems = [];

  CartCubit({
    required this.getMyOrdersUseCase,
    required this.addToCartUseCase,
    required this.deleteOrderUseCase,
    required this.completeOrderUseCase,
    required this.createCheckoutSessionUseCase,
    required this.createOrderUseCase,
  }) : super(const CartLoaded(items: [], totalPrice: 0.0, cartCount: 0));

  void _emitLoaded() {
    final double totalPrice = _localItems.fold(
      0.0,
      (sum, item) => sum + (item.price * item.quantity),
    );
    final int cartCount = _localItems.fold(
      0,
      (sum, item) => sum + item.quantity,
    );
    emit(
      CartLoaded(
        items: List.from(_localItems),
        totalPrice: totalPrice,
        cartCount: cartCount,
      ),
    );
  }

  Future<void> getMyOrders({bool showLoading = true}) async {
    // Local cart keeps its local state, so getMyOrders just emits the current local items.
    _emitLoaded();
  }

  void addToCart(CartTemplate template, {int quantity = 1}) {
    final existingIndex = _localItems.indexWhere((item) => item.template.id == template.id);
    if (existingIndex != -1) {
      final existingItem = _localItems[existingIndex];
      _localItems[existingIndex] = CartItemEntity(
        id: existingItem.id,
        template: existingItem.template,
        quantity: existingItem.quantity + quantity,
        price: existingItem.price,
      );
    } else {
      _localItems.add(
        CartItemEntity(
          id: template.id,
          template: template,
          quantity: quantity,
          price: template.price,
        ),
      );
    }
    _emitLoaded();
  }

  void deleteOrder(String itemId) {
    _localItems.removeWhere((item) => item.id == itemId);
    _emitLoaded();
  }

  void clearCart() {
    _localItems.clear();
    _emitLoaded();
  }

  Future<void> createOrderFromLocalCart() async {
    if (_localItems.isEmpty) return;
    emit(CartLoading());
    final result = await createOrderUseCase(items: _localItems);
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (order) {
        _localItems.clear();
        final orderModel = order is OrderModel
            ? order
            : OrderModel(
                id: order.id,
                totalAmount: order.totalAmount,
                orderStatus: order.orderStatus,
                paymentStatus: order.paymentStatus,
                items: order.items,
              );
        CacheHelper.saveLastOrder(orderModel.toJson());
        emit(OrderCreatedFromCart(order: order));
      },
    );
  }

  OrderEntity? get lastSavedOrder {
    final rawJson = CacheHelper.getLastOrder();
    if (rawJson != null) {
      try {
        return OrderModel.fromJson(rawJson);
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  void clearLastSavedOrder() {
    CacheHelper.clearLastOrder();
  }

  Future<OrderEntity?> checkOrderStatus(String orderId) async {
    final result = await getMyOrdersUseCase();
    return result.fold(
      (failure) => null,
      (orders) {
        final matching = orders.where((o) => o.id == orderId);
        if (matching.isNotEmpty) {
          return matching.first;
        }
        return null;
      },
    );
  }

  Future<void> createCheckoutSessionForOrder(String orderId) async {
    emit(CartLoading());
    final result = await createCheckoutSessionUseCase(orderId);
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (sessionUrl) {
        emit(
          StripeCheckoutReady(
            checkoutUrl: sessionUrl,
            items: const [],
            totalPrice: 0.0,
            cartCount: 0,
          ),
        );
      },
    );
  }

  int getCartCount() {
    return _localItems.fold(0, (sum, item) => sum + item.quantity);
  }
}

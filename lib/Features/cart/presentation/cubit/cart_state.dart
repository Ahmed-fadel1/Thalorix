import 'package:equatable/equatable.dart';
import '../../domain/entities/order_entity.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItemEntity> items;
  final double totalPrice;
  final int cartCount;

  const CartLoaded({
    required this.items,
    required this.totalPrice,
    required this.cartCount,
  });

  @override
  List<Object?> get props => [items, totalPrice, cartCount];
}

class CartError extends CartState {
  final String message;

  const CartError(this.message);

  @override
  List<Object?> get props => [message];
}

class CartActionError extends CartLoaded {
  final String message;

  const CartActionError({
    required this.message,
    required super.items,
    required super.totalPrice,
    required super.cartCount,
  });

  @override
  List<Object?> get props => [message, items, totalPrice, cartCount];
}

class OrderDeleting extends CartLoaded {
  const OrderDeleting({
    required super.items,
    required super.totalPrice,
    required super.cartCount,
  });
}

class OrderDeleted extends CartLoaded {
  const OrderDeleted({
    required super.items,
    required super.totalPrice,
    required super.cartCount,
  });
}

class OrderCompleting extends CartLoaded {
  const OrderCompleting({
    required super.items,
    required super.totalPrice,
    required super.cartCount,
  });
}

class OrderCompleted extends CartLoaded {
  const OrderCompleted({
    required super.items,
    required super.totalPrice,
    required super.cartCount,
  });
}

/// Emitted when the Stripe checkout session URL is ready to be opened.
class StripeCheckoutReady extends CartLoaded {
  final String checkoutUrl;

  const StripeCheckoutReady({
    required this.checkoutUrl,
    required super.items,
    required super.totalPrice,
    required super.cartCount,
  });

  @override
  List<Object?> get props => [checkoutUrl, items, totalPrice, cartCount];
}

class OrderCreatedFromCart extends CartState {
  final OrderEntity order;

  const OrderCreatedFromCart({required this.order});

  @override
  List<Object?> get props => [order];
}

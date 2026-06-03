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
  final List<OrderEntity> orders;
  final double totalPrice;
  final int cartCount;

  const CartLoaded({
    required this.orders,
    required this.totalPrice,
    required this.cartCount,
  });

  @override
  List<Object?> get props => [orders, totalPrice, cartCount];
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
    required super.orders,
    required super.totalPrice,
    required super.cartCount,
  });

  @override
  List<Object?> get props => [message, orders, totalPrice, cartCount];
}

class OrderDeleting extends CartLoaded {
  const OrderDeleting({
    required super.orders,
    required super.totalPrice,
    required super.cartCount,
  });
}

class OrderDeleted extends CartLoaded {
  const OrderDeleted({
    required super.orders,
    required super.totalPrice,
    required super.cartCount,
  });
}

class OrderCompleting extends CartLoaded {
  const OrderCompleting({
    required super.orders,
    required super.totalPrice,
    required super.cartCount,
  });
}

class OrderCompleted extends CartLoaded {
  const OrderCompleted({
    required super.orders,
    required super.totalPrice,
    required super.cartCount,
  });
}

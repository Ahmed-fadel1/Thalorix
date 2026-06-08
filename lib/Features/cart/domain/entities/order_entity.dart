import 'package:equatable/equatable.dart';

class CartTemplate extends Equatable {
  final String id;
  final String title;
  final String description;
  final double price;
  final String? thumbnail;

  const CartTemplate({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    this.thumbnail,
  });

  @override
  List<Object?> get props => [id, title, description, price, thumbnail];
}

class CartItemEntity extends Equatable {
  final String id;
  final CartTemplate template;
  final int quantity;
  final double price;

  const CartItemEntity({
    required this.id,
    required this.template,
    required this.quantity,
    required this.price,
  });

  @override
  List<Object?> get props => [id, template, quantity, price];
}

class OrderEntity extends Equatable {
  final String id;
  final double totalAmount;
  final String orderStatus;
  final String paymentStatus;
  final List<CartItemEntity> items;

  const OrderEntity({
    required this.id,
    required this.totalAmount,
    required this.orderStatus,
    required this.paymentStatus,
    required this.items,
  });

  @override
  List<Object?> get props => [
        id,
        totalAmount,
        orderStatus,
        paymentStatus,
        items,
      ];
}

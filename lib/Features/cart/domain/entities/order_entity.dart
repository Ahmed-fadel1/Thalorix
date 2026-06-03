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

class OrderEntity extends Equatable {
  final String id;
  final double price;
  final int quantity;
  final String orderStatus;
  final String paymentStatus;
  final CartTemplate template;

  const OrderEntity({
    required this.id,
    required this.price,
    required this.quantity,
    required this.orderStatus,
    required this.paymentStatus,
    required this.template,
  });

  @override
  List<Object?> get props => [
        id,
        price,
        quantity,
        orderStatus,
        paymentStatus,
        template,
      ];
}

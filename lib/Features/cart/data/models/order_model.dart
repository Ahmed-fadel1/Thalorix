import 'package:thalorix_app/Features/cart/domain/entities/order_entity.dart';

class CartTemplateModel extends CartTemplate {
  const CartTemplateModel({
    required super.id,
    required super.title,
    required super.description,
    required super.price,
    super.thumbnail,
  });

  factory CartTemplateModel.fromJson(Map<String, dynamic> json) {
    return CartTemplateModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      thumbnail: json['image'] ?? json['thumbnail'] ?? json['fileUrl'],
    );
  }
}

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.id,
    required super.price,
    required super.quantity,
    required super.orderStatus,
    required super.paymentStatus,
    required super.template,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    CartTemplateModel templateModel;
    final templateData = json['template'];

    if (templateData is Map<String, dynamic>) {
      templateModel = CartTemplateModel.fromJson(templateData);
    } else if (templateData is String) {
      templateModel = CartTemplateModel(
        id: templateData,
        title: '',
        description: '',
        price: 0.0,
        thumbnail: null,
      );
    } else {
      templateModel = const CartTemplateModel(
        id: '',
        title: '',
        description: '',
        price: 0.0,
        thumbnail: null,
      );
    }

    return OrderModel(
      id: json['_id'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      quantity: json['quantity'] ?? 1,
      orderStatus: json['orderStatus'] ?? 'pending',
      paymentStatus: json['paymentStatus'] ?? 'unpaid',
      template: templateModel,
    );
  }
}

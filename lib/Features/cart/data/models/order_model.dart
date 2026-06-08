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

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'price': price,
      'image': thumbnail,
    };
  }
}

class CartItemModel extends CartItemEntity {
  const CartItemModel({
    required super.id,
    required super.template,
    required super.quantity,
    required super.price,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
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

    return CartItemModel(
      id: json['_id'] ?? '',
      template: templateModel,
      quantity: json['quantity'] ?? 1,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'template': {
        '_id': template.id,
        'title': template.title,
        'description': template.description,
        'price': template.price,
        'image': template.thumbnail,
      },
      'quantity': quantity,
      'price': price,
    };
  }
}

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.id,
    required super.totalAmount,
    required super.orderStatus,
    required super.paymentStatus,
    required super.items,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    List<CartItemModel> itemsList = [];
    if (json['items'] != null && json['items'] is List) {
      itemsList = (json['items'] as List)
          .map((i) => CartItemModel.fromJson(i))
          .toList();
    }

    return OrderModel(
      id: json['_id'] ?? '',
      totalAmount: (json['totalAmount'] as num?)?.toDouble() ?? 0.0,
      orderStatus: json['orderStatus'] ?? 'pending',
      paymentStatus: json['paymentStatus'] ?? 'unpaid',
      items: itemsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'totalAmount': totalAmount,
      'orderStatus': orderStatus,
      'paymentStatus': paymentStatus,
      'items': items.map((item) => {
        '_id': item.id,
        'template': {
          '_id': item.template.id,
          'title': item.template.title,
          'description': item.template.description,
          'price': item.template.price,
          'image': item.template.thumbnail,
        },
        'quantity': item.quantity,
        'price': item.price,
      }).toList(),
    };
  }
}

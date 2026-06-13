import 'package:dio/dio.dart';
import 'package:thalorix_app/core/cache/cache_helper.dart';
import 'package:thalorix_app/core/errors/error_handler.dart';
import 'package:thalorix_app/core/network/dio_helper.dart';
import 'package:thalorix_app/core/network/end_point.dart';
import '../models/order_model.dart';
import '../../domain/entities/order_entity.dart';

abstract class CartRemoteDataSource {
  Future<List<OrderModel>> getMyOrders();

  Future<OrderModel> addToCart({
    required String templateId,
    required int quantity,
  });

  Future<OrderModel> createOrder({
    required List<CartItemEntity> items,
  });

  Future<void> deleteOrder(String orderId);

  Future<void> completeOrder(String orderId);

  Future<String> createCheckoutSession(String orderId);
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  Map<String, String> _headers() {
    final token = CacheHelper.getToken();
    return {
      'Content-Type': 'application/json',
      if (token != null && token.isNotEmpty)
        'Authorization': 'Bearer $token',
    };
  }

  @override
  Future<List<OrderModel>> getMyOrders() async {
    final response = await DioHelper.getData(
      url: ApiEndpoints.myOrders,
    );

    final dynamic responseData = response.data;
    final List data;
    if (responseData is List) {
      data = responseData;
    } else if (responseData is Map && responseData.containsKey('data')) {
      data = responseData['data'] ?? [];
    } else {
      data = [];
    }

    return data.map((e) => OrderModel.fromJson(e)).toList();
  }

  @override
  Future<OrderModel> addToCart({
    required String templateId,
    required int quantity,
  }) async {
    final response = await DioHelper.postData(
      url: ApiEndpoints.orders,
      data: {
        'templateId': templateId,
        'quantity': quantity,
      },
    );

    final dynamic responseData = response.data;
    if (responseData is Map<String, dynamic>) {
      if (responseData.containsKey('data') && responseData['data'] is Map) {
        return OrderModel.fromJson(responseData['data']);
      }
      return OrderModel.fromJson(responseData);
    }
    throw Exception('Unexpected response format');
  }

  @override
  Future<void> deleteOrder(String orderId) async {
    try {
      await DioHelper.dio.delete(
        '${ApiEndpoints.orders}/$orderId',
        options: Options(headers: _headers()),
      );
    } on DioException catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  @override
  Future<void> completeOrder(String orderId) async {
    try {
      await DioHelper.dio.patch(
        '${ApiEndpoints.orders}/$orderId/complete',
        data: {},
        options: Options(headers: _headers()),
      );
    } on DioException catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  @override
  Future<OrderModel> createOrder({
    required List<CartItemEntity> items,
  }) async {
    try {
      OrderModel? lastOrder;

      for (var item in items) {
        final response = await DioHelper.postData(
          url: ApiEndpoints.orders,
          data: {
            'templateId': item.template.id,
            'quantity': item.quantity,
          },
        );

        final dynamic responseData = response.data;
        if (responseData is Map<String, dynamic>) {
          if (responseData.containsKey('data') && responseData['data'] is Map) {
            lastOrder = OrderModel.fromJson(responseData['data']);
          } else {
            lastOrder = OrderModel.fromJson(responseData);
          }
        } else {
          throw Exception('Unexpected response format');
        }
      }

      if (lastOrder == null) {
        throw Exception('Cart is empty');
      }

      // If the backend doesn't return the items array properly populated,
      // we can reconstruct it from our local cart items to display in UI.
      if (lastOrder.items.isEmpty) {
        double totalAmount = items.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
        lastOrder = OrderModel(
          id: lastOrder.id,
          totalAmount: lastOrder.totalAmount > 0 ? lastOrder.totalAmount : totalAmount,
          orderStatus: lastOrder.orderStatus,
          paymentStatus: lastOrder.paymentStatus,
          items: items.map((e) => CartItemModel(
             id: e.id, 
             template: CartTemplateModel(
               id: e.template.id, 
               title: e.template.title, 
               description: e.template.description, 
               price: e.template.price,
               thumbnail: e.template.thumbnail,
             ), 
             quantity: e.quantity, 
             price: e.price,
          )).toList(),
        );
      }

      return lastOrder;
    } on DioException catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  @override
  Future<String> createCheckoutSession(String orderId) async {
    try {
      final response = await DioHelper.postData(
        url: ApiEndpoints.createCheckoutSession,
        data: {
          'orderId': orderId,
          'successUrl': 'https://www.facebook.com',
          'cancelUrl': 'https://www.google.com',
        },
      );
      final dynamic responseData = response.data;
      if (responseData is Map<String, dynamic>) {
        final url = responseData['url'] ??
            responseData['sessionUrl'] ??
            responseData['data']?['url'];
        if (url != null && url is String && url.isNotEmpty) {
          return url;
        }
      }
      throw Exception('Invalid Stripe checkout response: $responseData');
    } on DioException catch (e) {
      throw ErrorHandler.handle(e);
    }
  }
}

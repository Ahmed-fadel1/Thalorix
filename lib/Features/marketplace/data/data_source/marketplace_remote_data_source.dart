import 'package:thalorix_app/core/network/dio_helper.dart';
import 'package:thalorix_app/core/network/end_point.dart';
import '../models/category_model.dart';
import '../models/template_model.dart';

abstract class MarketplaceRemoteDataSource {
  Future<List<CategoryModel>> getCategories({
    required int page,
    required int limit,
    String? keyword,
  });

  Future<List<TemplateModel>> getTemplates({String? categoryId});

  Future<TemplateModel> getTemplateDetails(String templateId);
}

class MarketplaceRemoteDataSourceImpl implements MarketplaceRemoteDataSource {
  @override
  Future<List<CategoryModel>> getCategories({
    required int page,
    required int limit,
    String? keyword,
  }) async {
    final response = await DioHelper.getData(
      url: ApiEndpoints.categories,
      query: {
        'page': page.toString(),
        'limit': limit.toString(),
        if (keyword != null) 'keyword': keyword,
      },
    );

    final List data = response.data['data'] ?? [];
    return data.map((e) => CategoryModel.fromJson(e)).toList();
  }

  @override
  Future<List<TemplateModel>> getTemplates({String? categoryId}) async {
    final response = await DioHelper.getData(
      url: ApiEndpoints.templates,
      query: {
        if (categoryId != null) 'categoryId': categoryId,
      },
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

    return data.map((e) => TemplateModel.fromJson(e)).toList();
  }

  @override
  Future<TemplateModel> getTemplateDetails(String templateId) async {
    final response = await DioHelper.getData(
      url: '${ApiEndpoints.templates}/$templateId',
    );

  
    final dynamic responseData = response.data;
    if (responseData is Map<String, dynamic>) {
      if (responseData.containsKey('data') && responseData['data'] is Map) {
        return TemplateModel.fromJson(responseData['data']);
      }
      return TemplateModel.fromJson(responseData);
    }

    throw Exception('Unexpected response format');
  }
}
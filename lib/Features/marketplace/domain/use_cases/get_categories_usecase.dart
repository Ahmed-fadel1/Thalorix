import 'package:dartz/dartz.dart';
import 'package:thalorix_app/Features/marketplace/domain/entities/category_entity.dart';
import 'package:thalorix_app/Features/marketplace/domain/repositories/marketplace_repository.dart';
import 'package:thalorix_app/core/errors/failures.dart';

class GetCategoriesUseCase {
  final MarketplaceRepository repository;

  GetCategoriesUseCase(this.repository);

  Future<Either<Failure, List<CategoryEntity>>> call(
    CategoriesParams params,
  ) {
    return repository.getCategories(
      page: params.page,
      limit: params.limit,
      keyword: params.keyword,
    );
  }
}

class CategoriesParams {
  final int page;
  final int limit;
  final String? keyword;

  const CategoriesParams({
    required this.page,
    required this.limit,
    this.keyword,
  });
}
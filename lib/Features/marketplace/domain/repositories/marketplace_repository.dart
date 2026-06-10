import 'package:dartz/dartz.dart';
import 'package:thalorix_app/core/errors/failures.dart';
import '../entities/category_entity.dart';
import '../entities/template_entity.dart';

abstract class MarketplaceRepository {
  Future<Either<Failure, List<CategoryEntity>>> getCategories({
    required int page,
    required int limit,
    String? keyword,
  });

  Future<Either<Failure, List<TemplateEntity>>> getTemplates({
    String? categoryId,
  });

  Future<Either<Failure, TemplateEntity>> getTemplateDetails(
    String templateId,
  );
}
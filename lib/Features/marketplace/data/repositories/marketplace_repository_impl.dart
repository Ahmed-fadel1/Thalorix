import 'package:dartz/dartz.dart';
import 'package:thalorix_app/core/errors/error_handler.dart';
import 'package:thalorix_app/core/errors/failures.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/template_entity.dart';
import '../../domain/repositories/marketplace_repository.dart';
import '../data_source/marketplace_remote_data_source.dart';

class MarketplaceRepositoryImpl implements MarketplaceRepository {
  final MarketplaceRemoteDataSource remoteDataSource;

  MarketplaceRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories({
    required int page,
    required int limit,
    String? keyword,
  }) async {
    try {
      final result = await remoteDataSource.getCategories(
        page: page,
        limit: limit,
        keyword: keyword,
      );
      return Right(result);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, List<TemplateEntity>>> getTemplates({
    String? categoryId,
  }) async {
    try {
      final result = await remoteDataSource.getTemplates(
        categoryId: categoryId,
      );
      return Right(result);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, TemplateEntity>> getTemplateDetails(
    String templateId,
  ) async {
    try {
      final result = await remoteDataSource.getTemplateDetails(templateId);
      return Right(result);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }
}
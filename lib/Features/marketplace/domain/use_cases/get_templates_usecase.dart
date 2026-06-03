import 'package:dartz/dartz.dart';
import 'package:thalorix_app/Features/marketplace/domain/entities/template_entity.dart';
import 'package:thalorix_app/Features/marketplace/domain/repositories/marketplace_repository.dart';
import 'package:thalorix_app/core/errors/failures.dart';

class GetTemplatesUseCase {
  final MarketplaceRepository repository;

  GetTemplatesUseCase(this.repository);

  Future<Either<Failure, List<TemplateEntity>>> call({
    String? categoryId,
  }) {
    return repository.getTemplates(categoryId: categoryId);
  }
}

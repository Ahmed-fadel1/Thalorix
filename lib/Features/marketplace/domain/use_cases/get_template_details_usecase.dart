import 'package:dartz/dartz.dart';
import 'package:thalorix_app/Features/marketplace/domain/entities/template_entity.dart';
import 'package:thalorix_app/Features/marketplace/domain/repositories/marketplace_repository.dart';
import 'package:thalorix_app/core/errors/failures.dart';

class GetTemplateDetailsUseCase {
  final MarketplaceRepository repository;

  GetTemplateDetailsUseCase(this.repository);

  Future<Either<Failure, TemplateEntity>> call(String templateId) {
    return repository.getTemplateDetails(templateId);
  }
}

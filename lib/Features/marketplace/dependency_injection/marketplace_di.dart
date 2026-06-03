import 'package:thalorix_app/Features/marketplace/data/data_source/marketplace_remote_data_source.dart';
import 'package:thalorix_app/Features/marketplace/data/repositories/marketplace_repository_impl.dart';
import 'package:thalorix_app/Features/marketplace/domain/repositories/marketplace_repository.dart';
import 'package:thalorix_app/Features/marketplace/domain/use_cases/get_categories_usecase.dart';
import 'package:thalorix_app/Features/marketplace/domain/use_cases/get_template_details_usecase.dart';
import 'package:thalorix_app/Features/marketplace/domain/use_cases/get_templates_usecase.dart';
import 'package:thalorix_app/Features/marketplace/presentation/cubit/marketplace_cubit.dart';
import 'package:thalorix_app/Features/marketplace/presentation/cubit/template_details_cubit.dart';


class MarketplaceDI {
  MarketplaceDI._();

  //  Data 
  static MarketplaceRemoteDataSource _remoteDataSource() =>
      MarketplaceRemoteDataSourceImpl();

  static MarketplaceRepository _repository() =>
      MarketplaceRepositoryImpl(_remoteDataSource());

  // Use Cases
  static GetCategoriesUseCase _getCategoriesUseCase() =>
      GetCategoriesUseCase(_repository());

  static GetTemplatesUseCase _getTemplatesUseCase() =>
      GetTemplatesUseCase(_repository());

  static GetTemplateDetailsUseCase _getTemplateDetailsUseCase() =>
      GetTemplateDetailsUseCase(_repository());

  // Cubits (public) 
  static MarketplaceCubit provideMarketplaceCubit() => MarketplaceCubit(
        getCategoriesUseCase: _getCategoriesUseCase(),
        getTemplatesUseCase: _getTemplatesUseCase(),
      );

  static TemplateDetailsCubit provideTemplateDetailsCubit() =>
      TemplateDetailsCubit(
        getTemplateDetailsUseCase: _getTemplateDetailsUseCase(),
      );
}

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/use_cases/get_categories_usecase.dart';
import '../../domain/use_cases/get_templates_usecase.dart';
import 'marketplace_state.dart';

class MarketplaceCubit extends Cubit<MarketplaceState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetTemplatesUseCase getTemplatesUseCase;

  MarketplaceCubit({
    required this.getCategoriesUseCase,
    required this.getTemplatesUseCase,
  }) : super(const MarketplaceInitial());

  /// Loads both categories and all templates on first open.
  Future<void> getMarketplaceData() async {
    emit(const MarketplaceLoading());

    final categoriesResult = await getCategoriesUseCase(
      const CategoriesParams(page: 1, limit: 100),
    );

    categoriesResult.fold(
      (failure) => emit(MarketplaceError(failure.message)),
      (categories) async {
        final templatesResult = await getTemplatesUseCase();
        templatesResult.fold(
          (failure) => emit(MarketplaceError(failure.message)),
          (templates) => emit(MarketplaceSuccess(
            categories: categories,
            templates: templates,
          )),
        );
      },
    );
  }

  /// Fetches all templates (category = "All").
  Future<void> getTemplates() async {
    // Preserve categories across reloads
    final List<CategoryEntity> currentCategories =
        state is MarketplaceSuccess ? (state as MarketplaceSuccess).categories : <CategoryEntity>[];

    emit(const MarketplaceLoading());

    final templatesResult = await getTemplatesUseCase();
    templatesResult.fold(
      (failure) => emit(MarketplaceError(failure.message)),
      (templates) => emit(MarketplaceSuccess(
        categories: currentCategories,
        templates: templates,
      )),
    );
  }

  /// Fetches templates filtered by a specific category from the API.
  Future<void> getTemplatesByCategory(String categoryId) async {
    final List<CategoryEntity> currentCategories =
        state is MarketplaceSuccess ? (state as MarketplaceSuccess).categories : <CategoryEntity>[];

    emit(const MarketplaceLoading());

    final templatesResult = await getTemplatesUseCase(categoryId: categoryId);
    templatesResult.fold(
      (failure) => emit(MarketplaceError(failure.message)),
      (templates) => emit(MarketplaceSuccess(
        categories: currentCategories,
        templates: templates,
      )),
    );
  }
}

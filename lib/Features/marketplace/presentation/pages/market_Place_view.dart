import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thalorix_app/Features/auth/presentation/widgets/auth_text_field.dart';
import 'package:thalorix_app/Features/marketplace/dependency_injection/marketplace_di.dart';
import 'package:thalorix_app/Features/marketplace/presentation/cubit/marketplace_cubit.dart';
import 'package:thalorix_app/Features/marketplace/presentation/cubit/marketplace_state.dart';
import 'package:thalorix_app/Features/marketplace/presentation/pages/templete_details_view.dart';
import 'package:thalorix_app/Features/marketplace/presentation/widgets/product_card.dart';
import 'package:thalorix_app/Features/marketplace/presentation/widgets/row_filter_categories.dart';
import 'package:thalorix_app/core/utils/Colors/app_colors.dart';
import 'package:thalorix_app/core/widgets/custom_app_bar.dart';

class MarketPlaceView extends StatelessWidget {
  const MarketPlaceView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MarketplaceDI.provideMarketplaceCubit()
        ..getMarketplaceData(),
      child: const MarketPlaceViewBody(),
    );
  }
}

class MarketPlaceViewBody extends StatefulWidget {
  const MarketPlaceViewBody({super.key});

  @override
  State<MarketPlaceViewBody> createState() => _MarketPlaceViewBodyState();
}

class _MarketPlaceViewBodyState extends State<MarketPlaceViewBody> {
  final TextEditingController searchController = TextEditingController();
  String _searchQuery = '';
  int _selectedCategoryIndex = 0;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Material(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              CustomAppBar(
                leading: const Icon(Icons.store_rounded),
                title: 'Marketplace',
                action: IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined),
                  onPressed: () {},
                ),
              ),
              Divider(
                thickness: 1,
                color: AppColors.border,
                endIndent: 10,
                indent: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 10,
                ),
                child: AuthTextField(
                  controller: searchController,
                  onChanged: (val) {
                    setState(() {
                      _searchQuery = val;
                    });
                  },
                  hint: 'Search templates..',
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  prefixIcon: const Icon(Icons.search),
                  prefixIconColor: AppColors.border,
                ),
              ),
              Expanded(
                child: BlocBuilder<MarketplaceCubit, MarketplaceState>(
                  builder: (context, state) {
                    if (state is MarketplaceLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is MarketplaceError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Error: ${state.message}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.red),
                            ),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: () {
                                context
                                    .read<MarketplaceCubit>()
                                    .getMarketplaceData();
                              },
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      );
                    } else if (state is MarketplaceSuccess) {
                      // Local search filtering (server already filtered by category)
                      final filteredTemplates = state.templates.where((t) {
                        final matchesSearch = _searchQuery.isEmpty ||
                            t.title
                                .toLowerCase()
                                .contains(_searchQuery.toLowerCase()) ||
                            t.description
                                .toLowerCase()
                                .contains(_searchQuery.toLowerCase());
                        return matchesSearch;
                      }).toList();

                      return Column(
                        children: [
                          RowFilterCategories(
                            categories: state.categories,
                            selectedIndex: _selectedCategoryIndex,
                            onCategorySelected: (cat) {
                              setState(() {
                                if (cat == null) {
                                  _selectedCategoryIndex = 0;
                                  context
                                      .read<MarketplaceCubit>()
                                      .getTemplates();
                                } else {
                                  _selectedCategoryIndex =
                                      state.categories.indexOf(cat) + 1;
                                  context
                                      .read<MarketplaceCubit>()
                                      .getTemplatesByCategory(cat.id);
                                }
                              });
                            },
                          ),
                          SizedBox(height: height * 0.02),
                          Expanded(
                            child: filteredTemplates.isEmpty
                                ? const Center(
                                    child: Text(
                                      'No templates found',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  )
                                : GridView.builder(
                                    itemCount: filteredTemplates.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 0.7,
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 12,
                                      mainAxisSpacing: 12,
                                    ),
                                    itemBuilder: (context, index) {
                                      final template =
                                          filteredTemplates[index];

                                      return ProductCard(
                                        imagepath: template.thumbnail,
                                        price: template.price,
                                        title: template.title,
                                        onpressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  TemplateDetailsView(
                                                templateId: template.id,
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                          ),
                        ],
                      );
                    }
                    return const Center(child: Text('Initializing...'));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
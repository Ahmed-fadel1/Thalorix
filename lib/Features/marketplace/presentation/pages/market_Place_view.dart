import 'package:flutter/material.dart';
import 'package:thalorix_app/Features/auth/presentation/widgets/auth_text_field.dart';
import 'package:thalorix_app/Features/marketplace/data/data_source/marketplace_local_data_source.dart';
import 'package:thalorix_app/Features/marketplace/data/models/product_model.dart';
import 'package:thalorix_app/Features/marketplace/presentation/pages/templete_details_view.dart';
import 'package:thalorix_app/Features/marketplace/presentation/widgets/product_card.dart';
import 'package:thalorix_app/Features/marketplace/presentation/widgets/row_filter_categories.dart';
import 'package:thalorix_app/core/utils/Colors/app_colors.dart';

import 'package:thalorix_app/core/widgets/custom_app_bar.dart';


class MarketPlaceView extends StatefulWidget {
  const MarketPlaceView({super.key});

  @override
  State<MarketPlaceView> createState() => _MarketPlaceViewState();
}

class _MarketPlaceViewState extends State<MarketPlaceView> {
  final dataSource = MarketplaceLocalDataSource();
  late final List<ProductModel> products;
  void initState() {
    super.initState();
    products = dataSource.getProducts();
  }

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
  
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            CustomAppBar(
              leading: Icon(Icons.store_rounded),
              title: "Marketplace",
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
                hint: "Search templates..",
                keyboardType: TextInputType.text,
                obscureText: false,
                prefixIcon: Icon(Icons.search),
                prefixIconColor: AppColors.border,
              ),
            ),
            RowFilterCategories(),
            SizedBox(height: height * 0.02),
            Expanded(
              child: GridView.builder(
                itemCount: products.length,

                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.7,
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  return ProductCard(
                    imagepath: products[index].image,
                    onpressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              TemplateDetailsView(product: products[index]),
                        ),
                      );
                    },
                    title: products[index].title,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

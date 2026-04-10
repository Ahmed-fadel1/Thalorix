import 'package:flutter/material.dart';
import 'package:thalorix_app/Features/auth/presentation/widgets/primary_button.dart';
import 'package:thalorix_app/Features/marketplace/data/models/product_model.dart';
import 'package:thalorix_app/Features/marketplace/presentation/widgets/details_features.dart';
import 'package:thalorix_app/Features/marketplace/presentation/widgets/details_header.dart';
import 'package:thalorix_app/Features/marketplace/presentation/widgets/details_reviews.dart';
import 'package:thalorix_app/core/widgets/custom_app_bar.dart';

class TemplateDetailsView extends StatelessWidget {
  final ProductModel product;

  const TemplateDetailsView({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:  Container(
    height: 60,
    color: Colors.teal,
    child: Center(child: Text("Buy - \$29")),
  ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(leading: IconButton(onPressed: (){
                Navigator.pop(context);
              }, icon: Icon(Icons.arrow_back)),centerTitle: true,
                title: "Template Details", action: IconButton(onPressed: (){}, icon: Icon(Icons.share_outlined))),
              DetailsHeader(product: product),

              const SizedBox(height: 20),

              Text(
                product.description,
                style: const TextStyle(height: 1.6, fontSize: 18),
              ),
              Text("by  ${ product.creator}", style: const TextStyle(fontSize: 16 )),

              const SizedBox(height: 20),

              const DetailsFeatures(),

              const SizedBox(height: 20),

              const DetailsReviews(),
              PrimaryButton(height:80, text: "Buy - \$29", backgroundColor: Colors.teal, textColor: Colors.white)            ],
          ),
        ),
      ),
    );
  }
}
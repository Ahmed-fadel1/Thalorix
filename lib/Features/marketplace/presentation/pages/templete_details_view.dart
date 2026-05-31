import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thalorix_app/Features/marketplace/data/models/product_model.dart';
import 'package:thalorix_app/Features/marketplace/dependency_injection/marketplace_di.dart';
import 'package:thalorix_app/Features/marketplace/presentation/cubit/template_details_cubit.dart';
import 'package:thalorix_app/Features/marketplace/presentation/cubit/template_details_state.dart';
import 'package:thalorix_app/Features/marketplace/presentation/pages/payment_view.dart';
import 'package:thalorix_app/Features/marketplace/presentation/widgets/details_features.dart';
import 'package:thalorix_app/Features/marketplace/presentation/widgets/details_header.dart';
import 'package:thalorix_app/Features/marketplace/presentation/widgets/details_reviews.dart';
import 'package:thalorix_app/core/widgets/custom_app_bar.dart';

class TemplateDetailsView extends StatelessWidget {
  final String templateId;

  const TemplateDetailsView({super.key, required this.templateId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MarketplaceDI.provideTemplateDetailsCubit()
        ..getTemplateDetails(templateId),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<TemplateDetailsCubit, TemplateDetailsState>(
            builder: (context, state) {
              if (state is TemplateDetailsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is TemplateDetailsError) {
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
                              .read<TemplateDetailsCubit>()
                              .getTemplateDetails(templateId);
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              } else if (state is TemplateDetailsSuccess) {
                final template = state.template;

                // Build a ProductModel for the PaymentScreen
                // (preserving existing payment flow contract)
                final productModel = ProductModel(
                  image: template.thumbnail ?? '',
                  title: template.title,
                  price: template.price,
                  description: template.description,
                  creator: 'John Doe',
                );

                return Scaffold(
                  bottomNavigationBar: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              PaymentScreen(product: productModel),
                        ),
                      );
                    },
                    child: Container(
                      height: 60,
                      color: Colors.teal,
                      child: Center(
                        child: Text(
                          'Buy - \$${template.price}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  body: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomAppBar(
                          leading: IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.arrow_back),
                          ),
                          centerTitle: true,
                          title: 'Template Details',
                          action: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.share_outlined),
                          ),
                        ),
                        DetailsHeader(
                          imagepath: template.thumbnail,
                          title: template.title,
                          price: template.price,
                        ),

                        const SizedBox(height: 20),

                        Text(
                          template.description,
                          style: const TextStyle(
                            height: 1.6,
                            fontSize: 18,
                          ),
                        ),

                        if (template.categoryName != null &&
                            template.categoryName!.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Text(
                            'Category: ${template.categoryName}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.teal,
                            ),
                          ),
                        ],

                        if (template.status != null &&
                            template.status!.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Text(
                            'Status: ${template.status}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],

                        const SizedBox(height: 20),

                        const DetailsFeatures(),

                        const SizedBox(height: 20),

                        const DetailsReviews(),
                      ],
                    ),
                  ),
                );
              }
              return const Center(child: Text('Loading...'));
            },
          ),
        ),
      ),
    );
  }
}

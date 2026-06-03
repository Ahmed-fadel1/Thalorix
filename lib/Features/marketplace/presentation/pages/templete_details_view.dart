import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thalorix_app/Features/marketplace/dependency_injection/marketplace_di.dart';
import 'package:thalorix_app/Features/marketplace/presentation/cubit/template_details_cubit.dart';
import 'package:thalorix_app/Features/marketplace/presentation/cubit/template_details_state.dart';
import 'package:thalorix_app/Features/marketplace/presentation/widgets/details_features.dart';
import 'package:thalorix_app/Features/marketplace/presentation/widgets/details_header.dart';
import 'package:thalorix_app/Features/marketplace/presentation/widgets/details_reviews.dart';
import 'package:thalorix_app/core/widgets/custom_app_bar.dart';
import 'package:thalorix_app/Features/cart/presentation/cubit/cart_cubit.dart';
import 'package:thalorix_app/Features/cart/presentation/cubit/cart_state.dart';

class TemplateDetailsView extends StatefulWidget {
  final String templateId;

  const TemplateDetailsView({super.key, required this.templateId});

  @override
  State<TemplateDetailsView> createState() => _TemplateDetailsViewState();
}

class _TemplateDetailsViewState extends State<TemplateDetailsView> {
  bool _isBuyNowTriggered = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MarketplaceDI.provideTemplateDetailsCubit()
        ..getTemplateDetails(widget.templateId),
      child: Scaffold(
        body: SafeArea(
          child: BlocListener<CartCubit, CartState>(
            listener: (context, cartState) {
              if (_isBuyNowTriggered) {
                if (cartState is CartLoaded) {
                  setState(() { _isBuyNowTriggered = false; });
                  Navigator.pushNamed(context, '/cart');
                } else if (cartState is CartError || cartState is CartActionError) {
                  setState(() { _isBuyNowTriggered = false; });
                  final String errorMessage = cartState is CartError 
                      ? cartState.message 
                      : (cartState as CartActionError).message;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(errorMessage),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                }
              }
            },
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
                                .getTemplateDetails(widget.templateId);
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                } else if (state is TemplateDetailsSuccess) {
                  final template = state.template;

                  return Scaffold(
                    bottomNavigationBar: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, -4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                        
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {
                                context.read<CartCubit>().addToCart(template.id);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Added to cart!'),
                                    backgroundColor: Colors.teal,
                                  ),
                                );
                              },
                              icon: const Icon(Icons.add_shopping_cart_rounded, color: Colors.teal),
                              label: const Text(
                                'Add To Cart',
                                style: TextStyle(
                                  color: Colors.teal,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                side: const BorderSide(color: Colors.teal, width: 2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                     
                          Expanded(
                            child: BlocBuilder<CartCubit, CartState>(
                              builder: (context, cartState) {
                                final isLoading = _isBuyNowTriggered && cartState is CartLoading;
                                return ElevatedButton(
                                  onPressed: isLoading
                                      ? null
                                      : () {
                                          setState(() { _isBuyNowTriggered = true; });
                                          context.read<CartCubit>().addToCart(template.id);
                                        },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.teal,
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: isLoading
                                      ? const SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : Text(
                                          'Buy - \$${template.price}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                );
                              },
                            ),
                          ),
                        ],
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
      ),
    );
  }
}

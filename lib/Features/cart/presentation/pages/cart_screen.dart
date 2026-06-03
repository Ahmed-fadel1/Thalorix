import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thalorix_app/core/utils/Colors/app_colors.dart';
import 'package:thalorix_app/core/widgets/custom_app_bar.dart';
import '../cubit/cart_cubit.dart';
import '../cubit/cart_state.dart';
import '../widgets/cart_item_widget.dart';
import '../widgets/empty_cart_widget.dart';
import '../widgets/loading_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: 'My Cart',
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CartError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.redAccent,
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else if (state is CartActionError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.redAccent,
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else if (state is OrderDeleted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Cart updated successfully.'),
                backgroundColor: AppColors.teal,
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else if (state is OrderCompleted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Payment completed successfully!'),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
              ),
            );
            Navigator.pushNamed(
              context,
              '/payment',
            );
          }
        },
        builder: (context, state) {
        
          final bool isActionInProgress = state is OrderDeleting || state is OrderCompleting;

          if (state is CartLoading && state is! CartLoaded) {
            return const CartLoadingWidget();
          }

          if (state is CartError && state is! CartLoaded) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline_rounded, size: 60, color: Colors.redAccent),
                    const SizedBox(height: 16),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16, color: AppColors.tealDark),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => context.read<CartCubit>().getMyOrders(),
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.teal),
                      child: const Text('Retry', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            );
          }

   
          final orders = state is CartLoaded ? state.orders : [];

          if (orders.isEmpty && state is! CartLoading) {
            return const EmptyCartWidget();
          }

          return Stack(
            children: [
              Column(
                children: [
                  if (isActionInProgress)
                    const LinearProgressIndicator(
                      color: AppColors.teal,
                      backgroundColor: AppColors.borderSecond,
                    ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        final order = orders[index];
                        return CartItemWidget(
                          order: order,
                          onDelete: () {
                          
                            showDialog(
                              context: context,
                              builder: (dialogCtx) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                title: const Text('Remove Item'),
                                content: Text('Are you sure you want to remove "${order.template.title}" from your cart?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(dialogCtx),
                                    child: const Text('Cancel', style: TextStyle(color: AppColors.textSecondary)),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(dialogCtx);
                                      context.read<CartCubit>().deleteOrder(order.id);
                                    },
                                    child: const Text('Remove', style: TextStyle(color: Colors.redAccent)),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  
               
                  if (state is CartLoaded)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 20,
                            offset: const Offset(0, -4),
                          ),
                        ],
                      ),
                      child: SafeArea(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Total Price',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.textSecondary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  '\$${state.totalPrice.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 22,
                                    color: AppColors.tealDark,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                              
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: isActionInProgress
                                        ? null
                                        : () {
                                            
                                            showDialog(
                                              context: context,
                                              builder: (dialogCtx) => AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(16),
                                                ),
                                                title: const Text('Clear Cart'),
                                                content: const Text('Are you sure you want to cancel and delete all current items?'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () => Navigator.pop(dialogCtx),
                                                    child: const Text('No', style: TextStyle(color: AppColors.textSecondary)),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(dialogCtx);
                                                      context.read<CartCubit>().clearCart();
                                                    },
                                                    child: const Text('Yes, Clear', style: TextStyle(color: Colors.redAccent)),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                    style: OutlinedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      side: const BorderSide(color: Colors.redAccent),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                    ),
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(
                                        color: Colors.redAccent,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                             
                                Expanded(
                                  flex: 2,
                                  child: ElevatedButton(
                                    onPressed: isActionInProgress
                                        ? null
                                        : () async {
                                         await context.read<CartCubit>().completeAllOrders();
                                          
                                          },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.teal,
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                    ),
                                    child: const Text(
                                      'Next To Payment',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
              if (isActionInProgress)
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.05),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

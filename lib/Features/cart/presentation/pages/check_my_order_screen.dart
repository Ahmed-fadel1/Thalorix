import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:thalorix_app/core/utils/Colors/app_colors.dart';
import 'package:thalorix_app/core/widgets/custom_app_bar.dart';
import 'package:thalorix_app/Features/cart/domain/entities/order_entity.dart';
import 'package:thalorix_app/core/utils/router/app_router.dart';
import 'package:thalorix_app/Features/cart/presentation/cubit/cart_cubit.dart';
import 'package:thalorix_app/Features/cart/presentation/cubit/cart_state.dart';
import 'package:thalorix_app/Features/cart/presentation/widgets/cart_item_widget.dart';
import 'package:thalorix_app/Features/cart/presentation/widgets/empty_cart_widget.dart';

class CheckMyOrderScreen extends StatefulWidget {
  final OrderEntity order;

  const CheckMyOrderScreen({super.key, required this.order});

  @override
  State<CheckMyOrderScreen> createState() => _CheckMyOrderScreenState();
}

class _CheckMyOrderScreenState extends State<CheckMyOrderScreen>
    with WidgetsBindingObserver {
  bool _launchedCheckout = false;
  bool _checkingStatus = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// When user comes back from Stripe browser, check payment status
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed &&
        _launchedCheckout &&
        !_checkingStatus) {
      _verifyPaymentStatus();
    }
  }

  /// Verify payment status from backend after user returns from Stripe
  Future<void> _verifyPaymentStatus() async {
    setState(() {
      _checkingStatus = true;
    });

    // Show loading popup while verifying
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: Card(
          margin: EdgeInsets.all(32),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(color: AppColors.teal),
                SizedBox(height: 16),
                Text(
                  'Verifying payment status...',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    final cubit = context.read<CartCubit>();
    final updatedOrder = await cubit.checkOrderStatus(widget.order.id);

    // Dismiss the verifying dialog
    if (mounted) Navigator.pop(context);

    if (updatedOrder != null) {
      final isPaid = updatedOrder.paymentStatus == 'paid' ||
          updatedOrder.orderStatus == 'completed';
      if (isPaid) {
        // ✅ Payment successful → clear order from local storage
        cubit.clearLastSavedOrder();
        _showResultPopup(success: true);
      } else {
        // ❌ Payment not confirmed → DON'T clear local storage
        _showResultPopup(success: false);
      }
    } else {
      // ❌ Couldn't verify → DON'T clear local storage
      _showResultPopup(success: false);
    }

    setState(() {
      _checkingStatus = false;
      _launchedCheckout = false;
    });
  }

  /// Animated popup showing payment result, then navigate to Marketplace
  void _showResultPopup({required bool success}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 350),
          curve: Curves.elasticOut,
          builder: (context, scale, child) {
            return Transform.scale(
              scale: scale,
              child: child,
            );
          },
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            content: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Animated icon with bounce effect
                  TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.bounceOut,
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: value,
                        child: child,
                      );
                    },
                    child: Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: success
                            ? AppColors.teal.withValues(alpha: 0.12)
                            : Colors.redAccent.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        success
                            ? Icons.check_circle_rounded
                            : Icons.cancel_rounded,
                        color: success ? AppColors.teal : Colors.redAccent,
                        size: 48,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    success ? 'Payment Successful!' : 'Payment Failed',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.tealDark,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    success
                        ? 'Your order has been completed successfully. Thank you for your purchase!'
                        : 'Something went wrong during checkout. Please try again.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(dialogContext); // Close dialog
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          Routes.home,
                          (route) => false,
                          arguments: 2, // Index of Marketplace tab in BottomNavigationBar
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.teal,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Go to Marketplace',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: 'Check My Order',
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
          } else if (state is StripeCheckoutReady) {
            final uri = Uri.tryParse(state.checkoutUrl);
            if (uri != null) {
              setState(() {
                _launchedCheckout = true;
              });
              launchUrl(uri, mode: LaunchMode.externalApplication);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Invalid checkout URL received.'),
                  backgroundColor: Colors.redAccent,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          }
        },
        builder: (context, state) {
          final bool isActionInProgress = state is CartLoading;
          final items = widget.order.items;

          if (items.isEmpty) {
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
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return CartItemWidget(
                          item: item,
                          isReadOnly: true,
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 24,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
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
                                '\$${widget.order.totalAmount.toStringAsFixed(2)}',
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
                                      : () => Navigator.pop(context),
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    side: const BorderSide(
                                      color: Colors.redAccent,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                  ),
                                  child: const Text(
                                    'Back',
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
                                      : () {
                                          context
                                              .read<CartCubit>()
                                              .createCheckoutSessionForOrder(
                                                  widget.order.id);
                                        },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.teal,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
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
                      color: Colors.black.withValues(alpha: 0.05)),
                ),
            ],
          );
        },
      ),
    );
  }
}

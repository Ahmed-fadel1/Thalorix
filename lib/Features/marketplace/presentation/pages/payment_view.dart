import 'package:flutter/material.dart';
import 'package:thalorix_app/Features/marketplace/data/models/product_model.dart';
import 'package:thalorix_app/Features/marketplace/presentation/widgets/card_tile.dart';
import 'package:thalorix_app/Features/marketplace/presentation/widgets/price_row.dart';
import 'package:thalorix_app/Features/marketplace/presentation/widgets/radio_dot.dart';
import 'package:thalorix_app/Features/marketplace/presentation/widgets/sectionCard.dart';

import 'package:thalorix_app/core/utils/Colors/app_colors.dart';
import 'package:thalorix_app/core/widgets/custom_app_bar.dart';


class PaymentScreen extends StatefulWidget {
  final ProductModel product;

  const PaymentScreen({super.key, required this.product});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int selectedCard = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.surface,
              border: Border.all(color: AppColors.border),
            ),
            child: const Icon(
              Icons.chevron_left,
              size: 20,
              color: Colors.black87,
            ),
          ),
        ),
        title: const Text(
          'Payment',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ),

      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  sectionCard(
                    title: 'Order Summary',
                    child: Column(
                      children: [
                        Row(
                          children: [
                            // Product icon
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFF2D8FA5),
                                    Color(0xFF1A5F72),
                                  ],
                                ),
                              ),
                              child: const Icon(
                                Icons.layers,
                                color: Colors.white,
                                size: 22,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${widget.product.title}',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'Premium UI & Components',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Divider(color: AppColors.border, height: 1),
                        const SizedBox(height: 12),
                        priceRow(
                          label: 'Template Price',
                          amount: '${widget.product.price}',
                        ),
                        const SizedBox(height: 8),
                        priceRow(label: 'Tax (VAT 20%)', amount: '\$9.80'),
                        const SizedBox(height: 10),
                        const Divider(color: AppColors.border, height: 1),
                        const SizedBox(height: 10),
                        priceRow(
                          label: 'Total',
                          amount: '\$58.80',
                          isTotal: true,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 14),

                  sectionCard(
                    title: 'Payment Method',
                    child: Column(
                      children: [
                        cardTile(
                          index: 0,
                          brand: 'VISA',
                          brandColor: AppColors.visaBlue,
                          last4: '4532',
                          expires: '12/26',
                          isSelected: selectedCard == 0,
                          onTap: () {
                            setState(() {
                              selectedCard = 0;
                            });
                          },
                        ),
                        const SizedBox(height: 8),
                        cardTile(
                          index: 1,
                          brand: 'MC',
                          brandColor: AppColors.mcOrange,
                          last4: '8901',
                          expires: '08/25',
                          isSelected: selectedCard == 1,
                          onTap: () {
                            setState(() {
                              selectedCard = 1;
                            });
                          },
                        ),
                        const SizedBox(height: 8),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.border,
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Row(
                            children: [
                              RadioDot(selected: false),
                              SizedBox(width: 12),
                              Icon(
                                Icons.add,
                                size: 16,
                                color: AppColors.textSecondary,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Add New Card',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 12),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.lock_outline,
                                size: 15,
                                color: AppColors.teal,
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Your payment information is secure and encrypted',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: AppColors.border, width: 0.5),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.lock_outline,
                      size: 16,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Confirm & Pay \$58.80',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.tealDark,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.surface,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(
                          color: AppColors.border,
                          width: 0.5,
                        ),
                      ),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

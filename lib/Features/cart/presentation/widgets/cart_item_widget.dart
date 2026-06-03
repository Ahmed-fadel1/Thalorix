import 'package:flutter/material.dart';
import 'package:thalorix_app/core/utils/Colors/app_colors.dart';
import '../../domain/entities/order_entity.dart';

class CartItemWidget extends StatelessWidget {
  final OrderEntity order;
  final VoidCallback onDelete;

  const CartItemWidget({
    super.key,
    required this.order,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    
    const String placeholderPath = 'assets/images/temp_app2.jpg';
    
    final String? imageUrl = order.template.thumbnail;
    
    Widget imageWidget;
    if (imageUrl != null && imageUrl.isNotEmpty && (imageUrl.startsWith('http://') || imageUrl.startsWith('https://'))) {
      imageWidget = Image.network(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Image.asset(placeholderPath, fit: BoxFit.cover),
      );
    } else {
      imageWidget = Image.asset(placeholderPath, fit: BoxFit.cover);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderSecond, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 80,
                height: 80,
                child: imageWidget,
              ),
            ),
            const SizedBox(width: 16),
         
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.template.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.tealDark,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    order.template.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${order.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.teal,
                        ),
                      ),
                      if (order.quantity > 1)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.borderSecond,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Qty: ${order.quantity}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.tealDark,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Delete Icon
            IconButton(
              onPressed: onDelete,
              icon: const Icon(
                Icons.delete_outline_rounded,
                color: Colors.redAccent,
                size: 26,
              ),
              splashRadius: 24,
            ),
          ],
        ),
      ),
    );
  }
}

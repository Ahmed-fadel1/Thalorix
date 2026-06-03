import 'package:flutter/material.dart';
import 'package:thalorix_app/Features/marketplace/data/models/product_model.dart';

class DetailsHeader extends StatelessWidget {
  final ProductModel product;

  const DetailsHeader({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            product.image,
            height: 220,
            width: double.infinity,
            fit: BoxFit.fill
          ),
        ),

        const SizedBox(height: 16),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                product.title,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              "\$${product.price}",
              style: const TextStyle(
                fontSize: 20 ,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0D3B40),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:thalorix_app/core/utils/constants/app_images.dart';

class DetailsHeader extends StatelessWidget {
  final String? imagepath;
  final String title;
  final double price;

  const DetailsHeader({
    super.key,
    this.imagepath,
    required this.title,
    required this.price,
  });

  /// Same fallback logic as ProductCard — uses AppImages.placeholderTemplate.
  Widget _buildProductImage(String? path) {
    if (path == null || path.isEmpty) {
      return Image.asset(
        AppImages.placeholderTemplate,
        height: 220,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    }

    if (path.startsWith('http://') || path.startsWith('https://')) {
      return Image.network(
        path,
        height: 220,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Image.asset(
          AppImages.placeholderTemplate,
          height: 220,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      );
    }

    if (path.startsWith('/')) {
      final fullUrl = 'http://10.0.2.2:5000$path';
      return Image.network(
        fullUrl,
        height: 220,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Image.asset(
          AppImages.placeholderTemplate,
          height: 220,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      );
    }

    if (path.startsWith('assets/')) {
      return Image.asset(
        path,
        height: 220,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Image.asset(
          AppImages.placeholderTemplate,
          height: 220,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      );
    }

    return Image.asset(
      AppImages.placeholderTemplate,
      height: 220,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: _buildProductImage(imagepath),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              '\$$price',
              style: const TextStyle(
                fontSize: 20,
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
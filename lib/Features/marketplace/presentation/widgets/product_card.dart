import 'package:flutter/material.dart';
import 'package:thalorix_app/Features/auth/presentation/widgets/primary_button.dart';
import 'package:thalorix_app/core/utils/Colors/app_colors.dart';
import 'package:thalorix_app/core/utils/constants/app_images.dart';

class ProductCard extends StatelessWidget {
  final String? imagepath;
  final String title;
  final double price;
  final void Function()? onpressed;

  const ProductCard({
    super.key,
    required this.title,
    this.imagepath,
    required this.price,
    required this.onpressed,
  });

  /// Builds the appropriate image widget with automatic placeholder fallback.
  ///
  /// When the backend starts providing real URLs, this method will
  /// automatically display them — no code changes needed.
  Widget _buildProductImage(String? path) {
    // Null or empty → placeholder
    if (path == null || path.isEmpty) {
      return Image.asset(
        AppImages.placeholderTemplate,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    }

    // Full URL
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return Image.network(
        path,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Image.asset(
          AppImages.placeholderTemplate,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      );
    }

    // Server-relative path (e.g. /uploads/img.png)
    if (path.startsWith('/')) {
      final fullUrl = 'http://10.0.2.2:5000$path';
      return Image.network(
        fullUrl,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Image.asset(
          AppImages.placeholderTemplate,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      );
    }

    // Local asset path
    if (path.startsWith('assets/')) {
      return Image.asset(
        path,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Image.asset(
          AppImages.placeholderTemplate,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      );
    }

    // Anything else → placeholder
    return Image.asset(
      AppImages.placeholderTemplate,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onpressed,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              color: Colors.grey.shade200,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// image
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: AspectRatio(
                  aspectRatio: 1.2,
                  child: _buildProductImage(imagepath),
                ),
              ),
            ),

            /// details
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// title
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: width * 0.04,
                    ),
                  ),

                  /// price
                  Text(
                    '${price.toStringAsFixed(2)}\$',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: AppColors.splashPrimary,
                    ),
                  ),

                  SizedBox(height: height * 0.005),

                  /// button
                  PrimaryButton(
                    height: height * 0.05,
                    text: 'View template',
                    backgroundColor: AppColors.splashPrimary,
                    textColor: Colors.white,
                    onTap: onpressed,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
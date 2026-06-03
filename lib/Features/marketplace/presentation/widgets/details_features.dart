import 'package:flutter/material.dart';

class DetailsFeatures extends StatelessWidget {
  const DetailsFeatures({super.key});

  @override
  Widget build(BuildContext context) {
    final features = [
      "25+ Professional Slides",
      "Editable Graphics & Icons",
      "Free Google Fonts",
      "Documentation & Support",
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "What's Included",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),

        ...features.map(
          (f) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.green, size: 25),
                const SizedBox(width: 8),
                Text(f),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
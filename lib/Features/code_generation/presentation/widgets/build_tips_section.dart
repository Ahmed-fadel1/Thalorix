import 'package:flutter/material.dart';
import 'package:thalorix_app/Features/code_generation/presentation/widgets/tip_item.dart';

class BuildTipsSection extends StatelessWidget {
  const BuildTipsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F8F9),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFFD1E5E7)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Color(0xFF346B6D),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.lightbulb_outline,
                  color: Colors.white,
                  size: 18,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                "Tips for Better Results",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 10),
          TipItem(text: "Specify the programming language or framework"),
          TipItem(text: "Include styling requirements if applicable"),
          TipItem(text: "Describe the functionality and features needed"),
          TipItem(text: "Mention any specific libraries or dependencies"),
        ],
      ),
    );
  }
}

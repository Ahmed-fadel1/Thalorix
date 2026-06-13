import 'package:flutter/material.dart';
import 'package:thalorix_app/Features/code_generation/presentation/widgets/build_header.dart';
import 'package:thalorix_app/Features/code_generation/presentation/widgets/build_prompt_input.dart';
import 'package:thalorix_app/Features/code_generation/presentation/widgets/build_tips_section.dart';
import 'package:thalorix_app/core/utils/router/app_router.dart';

class CodeGenerationView extends StatelessWidget {
  const CodeGenerationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFF346B6D),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.code, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 8),
            const Text(
              "AI Code Gen",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BuildHeader(),
            const SizedBox(height: 25),
            BuildPromptInput(),
            const SizedBox(height: 20),
            BuildTipsSection(),
            const SizedBox(height: 25),
            const Text(
              "Example Prompts",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            _buildExampleCard(
              "Build a Python function that validates email addresses using regex and returns True/False",
            ),
            _buildExampleCard(
              "Create a responsive navigation bar in HTML/CSS with mobile hamburger menu using Tailwind CSS",
            ),
            _buildExampleCard(
              "Write a JavaScript function to sort an array of objects by date property in ascending order",
            ),
            const SizedBox(height: 30),
            _buildGenerateButton(context),
            const SizedBox(height: 15),
            _buildSecurityNote(),
            const SizedBox(height: 30),
            _buildStatisticsRow(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildExampleCard(String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.format_quote, color: Colors.grey, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Color(0xFF587E80), fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenerateButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.pushNamed(context, Routes.codeGenerateprogress);
        },
        icon: const Icon(Icons.auto_awesome_motion, size: 20),
        label: const Text(
          "Generate Code",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF346B6D),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildSecurityNote() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.shield_outlined, size: 16, color: Colors.grey),
        SizedBox(width: 5),
        Text(
          "Your code will be generated securely",
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildStatisticsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatCard("24", "Generated"),
        _buildStatCard("18", "Successful"),
        _buildStatCard("75%", "Success Rate", isPercentage: true),
      ],
    );
  }

  Widget _buildStatCard(
    String value,
    String label, {
    bool isPercentage = false,
  }) {
    return Container(
      width: 110,
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: isPercentage ? const Color(0xFF90B9BD) : Colors.black,
            ),
          ),
          const SizedBox(height: 5),
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }
}

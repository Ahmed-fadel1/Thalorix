import 'package:flutter/material.dart';

class CodeGenerationProgressPage extends StatelessWidget {
  const CodeGenerationProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF346B6D);
    const Color secondaryTextColor = Color(0xFF7BA8AC);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.code, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 10),
            const Text(
              "AI Code Gen",
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  color: Colors.white,
                  size: 60,
                ),
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              "Generating Your Code",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "Our AI is analyzing your prompt and crafting\nthe perfect solution...",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: secondaryTextColor,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 40),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Progress",
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "84%",
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: const LinearProgressIndicator(
                    value: 0.84,
                    minHeight: 10,
                    backgroundColor: Color(0xFFE0EDEE),
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            _buildStatusItem("Prompt analyzed", true, primaryColor),
            _buildStatusItem(
              "Context understanding complete",
              true,
              primaryColor,
            ),
            _buildStatusItem(
              "Generating code structure...",
              false,
              primaryColor,
              isCurrent: true,
            ),
            _buildStatusItem(
              "Optimizing & formatting",
              false,
              Colors.black,
              isLast: true,
            ),

            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "Cancel Generation",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusItem(
    String text,
    bool isDone,
    Color color, {
    bool isCurrent = false,
    bool isLast = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          if (isDone)
            const Icon(Icons.check, color: Colors.green, size: 20)
          else
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: isCurrent
                    ? const Color(0xFF7BA8AC)
                    : const Color(0xFF0D2121),
                shape: BoxShape.circle,
              ),
            ),
          const SizedBox(width: 15),
          Text(
            text,
            style: TextStyle(
              color: isDone || isCurrent
                  ? const Color(0xFF7BA8AC)
                  : Colors.black,
              fontSize: 15,
              fontWeight: isCurrent ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

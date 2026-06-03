import 'package:flutter/material.dart';

class BuildStatusItem extends StatelessWidget {
  const BuildStatusItem({
    super.key,
    required this.text,
    required this.isDone,
    required this.isCurrent,
  });
  final String text;
  final bool isDone;
  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
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

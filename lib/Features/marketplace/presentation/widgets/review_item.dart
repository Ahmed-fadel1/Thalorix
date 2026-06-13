import 'package:flutter/material.dart';

class ReviewItem extends StatelessWidget {
  final String name;
  final String comment;
  final int rating;
  final String time;

  const ReviewItem({
    required this.name,
    required this.comment,
    required this.rating,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(child: Text(name[0])),
            const SizedBox(width: 8),
            Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
            const Spacer(),
            Row(
              children: List.generate(
                5,
                (i) => Icon(
                  i < rating ? Icons.star : Icons.star_border,
                  size: 16,
                  color: Colors.amber,
                ),
              ),
            )
          ],
        ),

        const SizedBox(height: 8),

        Text(comment),

        const SizedBox(height: 4),

        Text(
          time,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }
}
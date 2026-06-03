import 'package:flutter/material.dart';
import 'package:thalorix_app/Features/marketplace/presentation/widgets/review_item.dart';

class DetailsReviews extends StatelessWidget {
  const DetailsReviews({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "Reviews",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "View All",
              style: TextStyle(
                color: Color(0xFF0D3B40),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

     
        const ReviewItem(
          name: "Sarah Ali",
          comment:
              "Amazing template! Very professional and easy to customize. Helped me close my biggest client.",
          rating: 5,
          time: "2 days ago",
        ),

        const SizedBox(height: 16),

        const ReviewItem(
          name: "Omar Ezz",
          comment:
              "Great value for money. Clean design and well organized slides.",
          rating: 4,
          time: "1 week ago",
        ),
      ],
    );
  }
}
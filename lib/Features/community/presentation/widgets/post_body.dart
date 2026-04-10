import 'package:flutter/material.dart';
import 'package:thalorix_app/core/utils/Colors/app_colors.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // 🔹 User Info
          Row(
            children: const [
              CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage(
                  "assets/images/temp_web1.jpg",
                ),
              ),
              SizedBox(width: 10),
              Text(
                "ebrahim ali",
                style: TextStyle(fontWeight: FontWeight.bold,
                fontSize: 16),
              ),
              SizedBox(width: 6),
              Chip(

                label: Text("Developer"),
                backgroundColor:AppColors.welcome_text,
              ),
              SizedBox(width: 6),
              Text("2h"),
            ],
          ),

           SizedBox(height:height*0.03), 

          const Text(
            " Just shipped a new feature that reduces load time by 40%! Here's what worked...",
            style: TextStyle(
              fontSize: 18,
            ),
          ),

          const SizedBox(height: 12),

          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(
              "assets/images/temp_web5.jpg",
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 12),

          // 🔹 Reactions
          Row(
            children: const [
              Icon(Icons.favorite_border, size: 20),
              SizedBox(width: 6),
              Text("24"),
              SizedBox(width: 20),
              Icon(Icons.chat_bubble_outline, size: 20),
              SizedBox(width: 6),
              Text("8"),
            ],
          ),
        ],
      ),
    );
  }
}
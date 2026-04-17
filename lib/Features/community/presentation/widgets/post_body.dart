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
        boxShadow: [BoxShadow(color: Colors.grey.shade100, blurRadius: 8)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 User Info
          Row( mainAxisAlignment:
   MainAxisAlignment.start,
            children:  [
              CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage("assets/images/temp_web1.jpg",),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  "ebrahim ali",
                  style: TextStyle(fontWeight: FontWeight.bold,
                  fontSize: 14,
                    color: Color(0xFF0D3B40),
                  overflow: TextOverflow.ellipsis,),
                ),
              ),
              SizedBox(width: 6),
              // Chip(
              
              //   label: Text("Developer"),
              //   backgroundColor:AppColors.welcome_text,
              // ),
              Container(
                height: 25,
          
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.splashPrimary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "Developer",
                  style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(width: 6),
              Text("2h", style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),

          SizedBox(height: 12),

          const Text(
            " Just shipped a new feature that reduces load time by 40%! Here's what worked...",
            style: TextStyle(fontSize: 15, color: Color(0xFF0D3B40,
            
            ),
            

 
            overflow: TextOverflow.ellipsis,
          
            
            ),
            maxLines: 3,
          ),

          const SizedBox(height: 12),

          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(
              "assets/images/temp_web5.jpg",
              height: 180,
  width: double.infinity,
  fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 12),

          // 🔹 Reactions
          Row(
            children: [
              Icon(Icons.favorite_border, size: 20),
              SizedBox(width: 6),
              Text("24", style: TextStyle(fontSize: 12, color: Colors.grey)),
              SizedBox(width: 20),
              Icon(Icons.chat_bubble_outline, size: 20),
              SizedBox(width: 6),
              Text("8", style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}
// class PostCard extends StatelessWidget {
//   const PostCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(18),
//         boxShadow: [BoxShadow(color: Colors.grey.shade100, blurRadius: 8)],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               const CircleAvatar(
//                 radius: 20,
//                 backgroundImage: AssetImage("assets/images/temp_web1.jpg"),
//               ),
//               const SizedBox(width: 10),
//               Expanded(
//                 child: Text(
//                   "ebrahim ali",
//                   style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//               const SizedBox(width: 8),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                 decoration: BoxDecoration(
//                   color: const Color(0xFF1565C0),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: const Text(
//                   "Developer",
//                   style: TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.w500),
//                 ),
//               ),
//               const SizedBox(width: 8),
//               const Text("2h", style: TextStyle(color: Colors.grey, fontSize: 13)),
//             ],
//           ),

//           const SizedBox(height: 12),

//           const Text(
//             "Just shipped a new feature that reduces load time by 40%! Here's what worked...",
//             style: TextStyle(fontSize: 15),
//           ),

//           const SizedBox(height: 12),

//           ClipRRect(
//             borderRadius: BorderRadius.circular(14),
//             child: Image.asset(
//               "assets/images/temp_web5.jpg",
//               height: 180,
//               width: double.infinity,
//               fit: BoxFit.cover,
//             ),
//           ),

//           const SizedBox(height: 12),

//           Row(
//             children: const [
//               Icon(Icons.favorite_border, size: 20, color: Colors.grey),
//               SizedBox(width: 6),
//               Text("24", style: TextStyle(color: Colors.grey)),
//               SizedBox(width: 20),
//               Icon(Icons.chat_bubble_outline, size: 20, color: Colors.grey),
//               SizedBox(width: 6),
//               Text("8", style: TextStyle(color: Colors.grey)),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:thalorix_app/Features/home/presentation/widgets/bottom_nav_bar.dart';
// import 'package:thalorix_app/Features/home/presentation/widgets/build_activity_item.dart';
// import 'package:thalorix_app/Features/home/presentation/widgets/build_quick_access_card.dart';
// import 'package:thalorix_app/core/utils/Colors/app_colors.dart';

// class HomeView extends StatelessWidget {
//   const HomeView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Header Section
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     children: [
//                       const CircleAvatar(
//                         radius: 25,
//                         backgroundImage:
//                             NetworkImage('https://via.placeholder.com/150'),
//                       ),
//                       const SizedBox(width: 15),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: const [
//                           Text(
//                             "Welcome, Alex",
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                               color: Color(0xFF0D3B40),
//                             ),
//                           ),
//                           SizedBox(height: 4),
//                           Text(
//                             "</> Developer",
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: Color(0xFF0D3B40),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   const CircleAvatar(
//                     backgroundColor: AppColors.splashPrimary,
//                     child: Icon(Icons.notifications, color: Colors.white),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 30),

//               // Quick Access Section
//               const Text(
//                 "Quick Access",
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF0D3B40),
//                 ),
//               ),
//               const SizedBox(height: 15),
//               GridView.count(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 15,
//                 mainAxisSpacing: 15,
//                 childAspectRatio: 1.5,
//                 children: [
//                   BuildQuickAccessCard(
//                     "Upload Template",
//                     "Share your templates",
//                     Icons.upload,
//                     const [Color(0xFFB2D8D8), Color(0xFF8AB6B6)],
//                   ),
//                   BuildQuickAccessCard(
//                     "Community",
//                     "Join discussions",
//                     Icons.group,
//                     const [Color(0xFFB2D8D8), Color(0xFF8AB6B6)],
//                   ),
//                   BuildQuickAccessCard(
//                     "Messages",
//                     "Chat with team",
//                     Icons.chat_bubble_outline,
//                     const [Color(0xFF3B6B6B), Color(0xFF0D3B40)],
//                   ),
//                   BuildQuickAccessCard(
//                     "Analytics",
//                     "Track performance",
//                     Icons.show_chart,
//                     const [Color(0xFF3B6B6B), Color(0xFF0D3B40)],
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 30),

//               // Recent Activity Section
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: const [
//                   Text(
//                     "Recent Activity",
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFF0D3B40),
//                     ),
//                   ),
//                   Text("View All", style: TextStyle(color: Color(0xFF3B6B6B))),
//                 ],
//               ),
//               const SizedBox(height: 15),
//               BuildActivityItem(
//                 "E-commerce Template",
//                 "Purchased 2 hours ago",
//                 "Downloaded",
//                 Icons.shopping_bag_outlined,
//               ),
//               BuildActivityItem(
//                 "React Component",
//                 "Generated 1 day ago",
//                 "Ready",
//                 Icons.code,
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: const BottomNavBar(),
//     );
//   }
// }
import 'package:flutter/material.dart';

import 'package:thalorix_app/Features/home/presentation/widgets/build_activity_item.dart';
import 'package:thalorix_app/Features/home/presentation/widgets/build_quick_access_card.dart';
import 'package:thalorix_app/core/utils/Colors/app_colors.dart';

import 'package:thalorix_app/core/cache/cache_helper.dart';
import 'package:thalorix_app/core/utils/router/app_router.dart';

class HomeBody extends StatelessWidget {
  const HomeBody();

  @override
  Widget build(BuildContext context) {
    String userName = CacheHelper.getName() ?? "User";

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                        'https://via.placeholder.com/150',
                      ),
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome, $userName",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0D3B40),
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "</> Developer",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF0D3B40),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const CircleAvatar(
                  backgroundColor: AppColors.splashPrimary,
                  child: Icon(Icons.notifications, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              "Quick Access",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0D3B40),
              ),
            ),
            const SizedBox(height: 15),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 1.5,
              children: [
                BuildQuickAccessCard(
                  "Upload Template",
                  "Share your templates",
                  Icons.upload,
                  const [Color(0xFFB2D8D8), Color(0xFF8AB6B6)],
                ),
                BuildQuickAccessCard(
                  "Community",
                  "Join discussions",
                  Icons.group,
                  const [Color(0xFFB2D8D8), Color(0xFF8AB6B6)],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.chatsScreen);
                  },
                  child: BuildQuickAccessCard(
                    "Messages",
                    "Chat with team",
                    Icons.chat_bubble_outline,
                    const [Color(0xFF3B6B6B), Color(0xFF0D3B40)],
                  ),
                ),
                BuildQuickAccessCard(
                  "Analytics",
                  "Track performance",
                  Icons.show_chart,
                  const [Color(0xFF3B6B6B), Color(0xFF0D3B40)],
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Recent Activity",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0D3B40),
                  ),
                ),
                Text("View All", style: TextStyle(color: Color(0xFF3B6B6B))),
              ],
            ),
            const SizedBox(height: 15),
            BuildActivityItem(
              "E-commerce Template",
              "Purchased 2 hours ago",
              "Downloaded",
              Icons.shopping_bag_outlined,
            ),
            BuildActivityItem(
              "React Component",
              "Generated 1 day ago",
              "Ready",
              Icons.code,
            ),
          ],
        ),
      ),
    );
  }
}

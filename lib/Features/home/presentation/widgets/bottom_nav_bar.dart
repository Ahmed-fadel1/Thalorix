import 'package:flutter/material.dart';
import 'package:thalorix_app/Features/chats/presentation/chats_screen.dart';
import 'package:thalorix_app/Features/community/presentation/views/community_view.dart';
import 'package:thalorix_app/Features/home/presentation/home_view.dart';
import 'package:thalorix_app/Features/marketplace/presentation/pages/market_Place_view.dart';
import 'package:thalorix_app/Features/profile/presentation/edit_profile_screen.dart';
import 'package:thalorix_app/core/utils/Colors/app_colors.dart';
import 'package:thalorix_app/core/utils/router/app_router.dart';

// class BottomNavBar extends StatelessWidget {
//   const BottomNavBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       backgroundColor: AppColors.splashPrimary,
//       type: BottomNavigationBarType.fixed,
//       selectedItemColor: Colors.white,
//       unselectedItemColor: Colors.grey,
//       showSelectedLabels: false,
//       showUnselectedLabels: false,
//       items: [
        
//         BottomNavigationBarItem(
//           icon: GestureDetector(
//             onTap: () {
//               Navigator.pushNamed(context, Routes.ChatsScreen);
//             },
//             child: Icon(Icons.chat_outlined),
//           ),
//           label: "",
//         ),
//         BottomNavigationBarItem(
//           icon: GestureDetector(
//             onTap: () {
//               Navigator.pushNamed(context, Routes.community);
//             },
//             child: Icon(Icons.group_outlined),
//           ),
//           label: "",
//         ),

//         BottomNavigationBarItem(icon: GestureDetector(
//           onTap: () {
//             Navigator.pushNamed(context, Routes.marketPlace);
//           },
//           child: Icon(Icons.storefront),
//         ), label: "",),
//         BottomNavigationBarItem(
//           icon: GestureDetector(
//             onTap: () {
//               Navigator.pushNamed(context, Routes.editProfile);
//             },
//             child: Icon(Icons.person_outline),
//           ),
//           label: "",
//         ),
//       ],
//     );
//   }
// }
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeBody(),
    const CommunityView(),
    const MarketPlaceView(),
    ChatsScreen(), 
    const EditProfileScreen(), 
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        backgroundColor: AppColors.splashPrimary,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.chat_outlined), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.group_outlined), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.storefront), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.message_outlined), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ""),
        ],
      ),
    );
  }
}
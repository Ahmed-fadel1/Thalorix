import 'package:flutter/material.dart';
import 'package:thalorix_app/core/utils/Colors/app_colors.dart';
import 'package:thalorix_app/core/utils/router/app_router.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppColors.splashPrimary,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: ""),
        BottomNavigationBarItem(
          icon: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Routes.ChatsScreen);
            },
            child: Icon(Icons.chat_outlined),
          ),
          label: "",
        ),
        BottomNavigationBarItem(icon: Icon(Icons.group_outlined), label: ""),
        BottomNavigationBarItem(icon: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, Routes.);
          },
          child: Icon(Icons.storefront)), label: ""),
        BottomNavigationBarItem(
          icon: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Routes.editProfile);
            },
            child: Icon(Icons.person_outline),
          ),
          label: "",
        ),
      ],
    );
  }
}

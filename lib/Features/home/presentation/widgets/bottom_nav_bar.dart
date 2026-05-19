import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thalorix_app/Features/chats/presentation/chats_screen.dart';
import 'package:thalorix_app/Features/community/presentation/views/community_view.dart';
import 'package:thalorix_app/Features/home/presentation/home_view.dart';
import 'package:thalorix_app/Features/marketplace/presentation/pages/market_Place_view.dart';
import 'package:thalorix_app/Features/profile/domain/repo/user_repo.dart';
import 'package:thalorix_app/Features/profile/presentation/cubit/cubit/user_update_cubit.dart';
import 'package:thalorix_app/Features/profile/presentation/edit_profile_screen.dart';
import 'package:thalorix_app/core/cache/cache_helper.dart';
import 'package:thalorix_app/core/utils/Colors/app_colors.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;
  final String _userId = CacheHelper.getUserId() ?? '';

  List<Widget> get _pages => [
    const HomeBody(),
    const CommunityView(),
    const MarketPlaceView(),
    ChatsScreen(),
    BlocProvider(
      create: (_) => UserCubit(UserRepository()),
      child: EditProfileScreen(userId: _userId),
    ),
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
          BottomNavigationBarItem(
            icon: Icon(Icons.message_outlined),
            label: "",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ""),
        ],
      ),
    );
  }
}

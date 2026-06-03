import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thalorix_app/core/utils/router/app_router.dart';
import 'package:thalorix_app/Features/chats/presentation/chats_screen.dart';
import 'package:thalorix_app/Features/community/data/data_sources/community_remote_data_source.dart';
import 'package:thalorix_app/Features/community/data/repositories/community_repository_impl.dart';
import 'package:thalorix_app/Features/community/domain/usecases/create_post_usecase.dart';
import 'package:thalorix_app/Features/community/domain/usecases/delete_post_usecase.dart';
import 'package:thalorix_app/Features/community/domain/usecases/get_feed_usecase.dart';
import 'package:thalorix_app/Features/community/domain/usecases/update_post_usecase.dart';
import 'package:thalorix_app/Features/community/presentation/cubit/community_cubit.dart';
import 'package:thalorix_app/Features/community/presentation/views/community_view.dart';
import 'package:thalorix_app/Features/home/presentation/home_view.dart';
import 'package:thalorix_app/Features/marketplace/presentation/pages/market_Place_view.dart';
import 'package:thalorix_app/Features/profile/presentation/edit_profile_screen.dart';
import 'package:thalorix_app/core/utils/Colors/app_colors.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    final repo = CommunityRepositoryImpl(CommunityRemoteDataSource());
    _pages = [
      const HomeBody(),
      BlocProvider(
        create: (_) => CommunityCubit(
          getFeedUseCase: GetFeedUseCase(repo),
          createPostUseCase: CreatePostUseCase(repo),
          updatePostUseCase: UpdatePostUseCase(repo),
          deletePostUseCase: DeletePostUseCase(repo),
        )..getFeed(),
        child: const CommunityView(),
      ),
      const MarketPlaceView(),
      const ChatsScreen(),
      const EditProfileScreen(),
    ];
  }

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
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ""),
          BottomNavigationBarItem(
            icon: Icon(Icons.commute_outlined),
            label: "",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.storefront), label: ""),
          BottomNavigationBarItem(
            icon: Icon(Icons.message_outlined),
            label: "",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ""),
        ],
      ),
      floatingActionButton: _selectedIndex == 0
          ? Container(
              margin: const EdgeInsets.only(bottom: 16, right: 8),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.aiChat);
                },
                backgroundColor: const Color(0xFFE8F1F2),
                shape: const CircleBorder(
                  side: BorderSide(color: AppColors.splashPrimary, width: 2.5),
                ),
                elevation: 4,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ai',
                      style: TextStyle(
                        color: AppColors.splashPrimary,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.auto_awesome,
                      color: AppColors.splashPrimary,
                      size: 14,
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }
}

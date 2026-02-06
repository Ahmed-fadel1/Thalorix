import 'package:flutter/material.dart';
import 'package:thalorix_app/Features/home/presentation/widgets/bottom_nav_bar.dart';
import 'package:thalorix_app/Features/home/presentation/widgets/build_activity_item.dart';
import 'package:thalorix_app/Features/home/presentation/widgets/build_quick_access_card.dart';
import 'package:thalorix_app/core/utils/Colors/app_colors.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(
                          'https://via.placeholder.com/150',
                        ),
                      ),
                      SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome, Alex",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0D3B40),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFFB2D8D8),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              "</> Developer",
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF0D3B40),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  CircleAvatar(
                    backgroundColor: (AppColors.splashPrimary),
                    child: Icon(Icons.notifications, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                "Quick Access",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D3B40),
                ),
              ),
              SizedBox(height: 15),

              GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 1.5,
                children: [
                  BuildQuickAccessCard(
                    "Upload Template",
                    "Share your templates",
                    Icons.upload,
                    [Color(0xFFB2D8D8), Color(0xFF8AB6B6)],
                  ),
                  BuildQuickAccessCard(
                    "Community",
                    "Join discussions",
                    Icons.group,
                    [Color(0xFFB2D8D8), Color(0xFF8AB6B6)],
                  ),
                  BuildQuickAccessCard(
                    "Messages",
                    "Chat with team",
                    Icons.chat_bubble_outline,
                    [Color(0xFF3B6B6B), Color(0xFF0D3B40)],
                  ),
                  BuildQuickAccessCard(
                    "Analytics",
                    "Track performance",
                    Icons.show_chart,
                    [Color(0xFF3B6B6B), Color(0xFF0D3B40)],
                  ),
                ],
              ),
              SizedBox(height: 30),

              // Recent Activity Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
              SizedBox(height: 15),

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
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

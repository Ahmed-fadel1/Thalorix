import 'package:flutter/material.dart';
import 'package:thalorix_app/Features/community/presentation/widgets/post_body.dart';
import 'package:thalorix_app/Features/community/presentation/widgets/switch_button.dart';
import 'package:thalorix_app/core/utils/Colors/app_colors.dart';
import 'package:thalorix_app/core/widgets/custom_app_bar.dart';

class CommunityView extends StatefulWidget {
  const CommunityView({super.key});

  @override
  State<CommunityView> createState() => _CommunityViewState();
}

class _CommunityViewState extends State<CommunityView> {
  int selectedIndex = 0; 
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
      final width = MediaQuery.of(context).size.width;
    return SafeArea(child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
        CustomAppBar(title: "Community",
        action:Icon(Icons.notifications_on_outlined)
      ),

     Padding(
       padding: const EdgeInsets.all(10.0),
       child: Row(
         children: [
           SwitchButton(
        text: "Latest",
        index: 0,
        selectedIndex: selectedIndex,
        onTap: () {
          setState(() {
            selectedIndex = 0;
          });
        },
           ),
          
           SwitchButton(
        text: "Trending",
        index: 1,
        selectedIndex: selectedIndex,
        onTap: () {
          setState(() {
            selectedIndex = 1;
          });
        },
           ),
         ],
       ),
     ),

Expanded(child: ListView.separated(itemBuilder: (context, index) => PostCard(), separatorBuilder: (context, index) => const SizedBox(height: 10), itemCount: 10)),


      ],
      
        
      ),
    ));
  }
}
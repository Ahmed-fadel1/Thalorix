import 'package:flutter/material.dart';
import 'package:thalorix_app/Features/home/presentation/widgets/bottom_nav_bar.dart';
import 'package:thalorix_app/core/utils/Colors/app_colors.dart';
import 'chat_detail_screen.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  final List<Map<String, dynamic>> chats = const [
    {
      "name": "yasmen",
      "lastMessage": "send me your code please......",
      "time": "09:20 am",
      "unread": 2,
      "online": true,
      "avatar": "https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png",
    },
    {
      "name": "marc",
      "lastMessage": "ok, thanks!",
      "time": "09:20 am",
      "unread": 1,
      "online": false,
      "avatar": "https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png"
    },
    {
      "name": "jack",
      "lastMessage": "okay, i will try ......",
      "time": "08:30 am",
      "unread": 0,
      "online": false,
      "avatar": "https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png"},
    {
      "name": "omar",
      "lastMessage": "where are you......",
      "time": "07:32 am",
      "unread": 0,
      "online": true,
      "avatar": "https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chats"),
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.border, width: 2),
              ),
              padding: const EdgeInsets.all(8),
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 20,
              ),
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.border, width: 2),
              ),
              padding: const EdgeInsets.all(8),
              child: const Icon(
                Icons.more_horiz,
                color: AppColors.iconbutton,
                size: 20,
              ),
            ),
          ),
        ],
      ),

      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            height: 1,
            width: double.infinity,
            color: AppColors.border,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search by name or email....",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.border, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.border, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),

          // Stories horizontal scroll
          SizedBox(
            height: 80,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: AppColors.border,
                      child: const Icon(
                        Icons.add,
                        size: 28,
                        color: AppColors.iconbutton,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text("Add story", style: TextStyle(fontSize: 12)),
                  ],
                ),
                const SizedBox(width: 12),
                ...chats.map(
                  (chat) => Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundImage: NetworkImage(chat["avatar"]),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          chat["name"],
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            height: 1,
            width: double.infinity,
            color: Colors.grey[300],
          ),

          Expanded(
            child: ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final chat = chats[index];
                return ListTile(
                  leading: Stack(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(chat["avatar"]),
                        radius: 24,
                      ),
                      if (chat["online"])
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                          ),
                        ),
                    ],
                  ),
                  title: Text(chat["name"]),
                  subtitle: Text(chat["lastMessage"]),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(chat["time"]),
                      if (chat["unread"] > 0)
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.iconbutton,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            chat["unread"].toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChatDetailScreen(
                          name: chat["name"],
                          avatar: chat["avatar"],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      // bottomNavigationBar: const BottomNavBar(),
    );
  }
}

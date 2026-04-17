import 'package:flutter/material.dart';
import 'package:thalorix_app/core/utils/Colors/app_colors.dart';

class ChatDetailScreen extends StatefulWidget {
  final String name;
  final String avatar;

  const ChatDetailScreen({super.key, required this.name, required this.avatar});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final List<Map<String, dynamic>> messages = [
    {
      "text": "Hey! I saw your project on GitHub.",
      "isMe": false,
      "time": "10:32 AM",
    },
    {
      "text": "Thanks! Glad you liked it. Are you working on ?",
      "isMe": true,
      "time": "10:33 AM",
    },
    {
      "text": "Yes! I'm building a mobile app.",
      "isMe": false,
      "time": "10:34 AM",
    },
    {"text": "I'd be happy to help!", "isMe": true, "time": "10:35 AM"},
    {
      "text": "React Native with TypeScript.",
      "isMe": false,
      "time": "10:36 AM",
    },
    {
      "text": "Let me check the timeout configuration.",
      "isMe": true,
      "time": "10:37 AM",
    },
    {
      "text":
          "Also, have you tried increasing the timeout value in your axios config?",
      "isMe": false,
      "time": "10:38 AM",
      "failed": true,
    },
  ];

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        title: Row(
          children: [
            CircleAvatar(backgroundImage: NetworkImage(widget.avatar)),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.name),
                const Text("Online", style: TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.call, color: AppColors.iconbutton),

            onPressed: () {
            },
          ),
          IconButton(
            icon: const Icon(Icons.videocam, color: AppColors.iconbutton),
            onPressed: () {
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(height: 1, width: double.infinity, color: Colors.grey[300]),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                bool isMe = msg["isMe"];
                return Row(
                  mainAxisAlignment: isMe
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (!isMe)
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: CircleAvatar(
                          radius: 16,
                          backgroundImage: NetworkImage(widget.avatar
                          ),
                        ),
                      ),
                    Flexible(
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isMe ? AppColors.border : Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(msg["text"]),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  msg["time"],
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.black54,
                                  ),
                                ),
                                if (msg["failed"] == true)
                                  const Text(
                                    "  Failed  Retry",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.red,
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (isMe)
                      const SizedBox(
                        width: 40, 
                      ),
                  ],
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: AppColors.welcome_text,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.emoji_emotions_outlined,
                          color: AppColors.splashPrimary,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            cursorColor: Colors.black,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              hintText: "Type a message...",
                              hintStyle: TextStyle(
                                color: AppColors.splashPrimary,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: AppColors.border,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.send, color: AppColors.splashPrimary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

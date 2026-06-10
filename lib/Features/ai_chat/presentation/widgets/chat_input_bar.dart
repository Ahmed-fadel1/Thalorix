import 'package:flutter/material.dart';

class ChatInputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final VoidCallback onAttach;

  const ChatInputBar({
    super.key,
    required this.controller,
    required this.onSend,
    required this.onAttach,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      decoration: BoxDecoration(
        color: const Color(0xFF386B72),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF386B72).withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Text field row
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 12, 4),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                    maxLines: 4,
                    minLines: 1,
                    decoration: const InputDecoration(
                      hintText: 'Ask anything',
                      hintStyle: TextStyle(
                        color: Colors.white54,
                        fontSize: 15,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => onSend(),
                  ),
                ),
              ],
            ),
          ),

          // Bottom row: + button and send
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: Row(
              children: [
                // + Attach button
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: onAttach,
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Colors.white38, width: 1.5),
                      ),
                      child: const Icon(Icons.add,
                          color: Colors.white, size: 20),
                    ),
                  ),
                ),

                const Spacer(),

                // Send button
                ValueListenableBuilder<TextEditingValue>(
                  valueListenable: controller,
                  builder: (context, value, child) {
                    final hasText = value.text.trim().isNotEmpty;
                    return AnimatedOpacity(
                      opacity: hasText ? 1.0 : 0.4,
                      duration: const Duration(milliseconds: 200),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: hasText ? onSend : null,
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: hasText
                                  ? Colors.white
                                  : Colors.white24,
                            ),
                            child: Icon(
                              Icons.arrow_upward,
                              color: hasText
                                  ? const Color(0xFF386B72)
                                  : Colors.white54,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

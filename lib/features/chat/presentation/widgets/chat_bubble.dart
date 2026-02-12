import 'package:flutter/material.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/core/widget/alex_text.dart';
import 'package:lavender/core/widget/custom_cached_network_image.dart';
import 'package:lavender/features/chat/data/models/chat/message_model.dart';
import 'package:intl/intl.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.isMe,
    required this.msg,
  });

  final bool isMe;
  final MessageModel msg;

  @override
  Widget build(BuildContext context) {
    // Format timestamp to 11:15
    final String formattedTime = DateFormat('HH:mm').format(msg.timestamp);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Avatar for the other person
          if (!isMe) const SizedBox(width: 8),

          Flexible(
            child: Column(
              // Pushes timestamp to the right if isMe, left if not
              crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: const BoxConstraints(maxWidth: 260),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isMe ? AppColors.purple50 : AppColors.purple600,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(16),
                      topRight: const Radius.circular(16),
                      bottomLeft: const Radius.circular(16),
                      bottomRight: const Radius.circular(16),
                    ).copyWith(
                      // The "Tail" logic
                      bottomRight: !isMe ? Radius.zero : const Radius.circular(16),
                      bottomLeft: isMe ? Radius.zero : const Radius.circular(16),
                    ),
                  ),
                  child: AlexText(
                    text: msg.message,
                    color: isMe ? AppColors.purple600 : Colors.white,
                    overflow: null,
                    maxLines: null,
                  ),
                ),
                const SizedBox(height: 4),
                // Timestamp and Status Row
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.done_all,
                      size: 16,
                      color: msg.isRead ? AppColors.purple600 : Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    AlexText(
                      text: formattedTime,
                      fontSize: 10,
                      color: Colors.grey,
                    ),
                  ],
                )
              ],
            ),
          ),

          if (isMe) const SizedBox(width: 8),
          // Your Avatar
          if (isMe) SenderAvatar(url: "${msg.senderProfile.profilePic}"),
        ],
      ),
    );
  }
}

class SenderAvatar extends StatelessWidget {
  const SenderAvatar({super.key, required this.url});
  final String url;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: CustomCachedNetworkImage(
        imageUrl: url ?? "",
        fit: BoxFit.cover,
      ),
    );
  }
}

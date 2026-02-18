import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavender/core/helpers/secure_storage_helper.dart';
import 'package:lavender/core/widget/circularIcon.dart';
import 'package:lavender/features/chat/presentation/cubit/chat_cubit.dart';

import '../../data/models/chat/inbox_user_profile.dart' show InboxUserProfile;

class InputSection extends StatelessWidget {
  final TextEditingController messageController;
  final int currentUserId;
  final InboxUserProfile receiverProfile;

  const InputSection({
    super.key,
    required this.messageController,
    required this.currentUserId,
    required this.receiverProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messageController,
              decoration: InputDecoration(
                hintText: "Type a message...",
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              final text = messageController.text.trim();
              if (text.isNotEmpty) {
                // INSTANT execution - no await delay
                context.read<ChatCubit>().sendMessage(
                  text: text,
                  currentUserId: currentUserId,
                  receiverProfile: receiverProfile,
                );
                messageController.clear();
              }
            },
            child: CircularIcon(icon: 'send-2.png',),
          ),

          // IconButton(
          //   onPressed: () {
          //     final text = messageController.text.trim();
          //     if (text.isNotEmpty) {
          //       // INSTANT execution - no await delay
          //       context.read<ChatCubit>().sendMessage(
          //         text: text,
          //         currentUserId: currentUserId,
          //         receiverProfile: receiverProfile,
          //       );
          //       messageController.clear();
          //     }
          //   },
          //   icon: const Icon(Icons.send, color: Colors.purple),
          // ),
        ],
      ),
    );
  }
}
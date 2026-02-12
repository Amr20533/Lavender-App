import 'package:flutter/material.dart';
import 'package:lavender/core/routing/router.dart';
import 'package:lavender/features/chat/data/models/chat/message_model.dart';
import 'package:lavender/features/chat/presentation/widgets/inbox_card.dart';

class InboxList extends StatelessWidget {
  final List<MessageModel> messages;
  final int currentUserId;

  const InboxList({super.key, required this.messages, required this.currentUserId});

  @override
  Widget build(BuildContext context) {

    return ListView.separated(
      itemCount: messages.length,
      // Optimization flags
      addAutomaticKeepAlives: true,
      addRepaintBoundaries: true,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      itemBuilder: (context, index) {
        final inbox = messages[index];

        final bool isMeSender = inbox.sender == currentUserId;

        final displayProfile = isMeSender
            ? inbox.receiverProfile
            : inbox.senderProfile;

        if (displayProfile == null) {
          return const SizedBox.shrink();
        }

        return InboxCard(
          key: ValueKey(inbox.id),
          user: displayProfile,
          message: inbox.message,
          // Pass extra data to the card for UI
          isMe: isMeSender,
          time: inbox.timestamp,
          onTap: () => Navigator.pushNamed(
            context,
            Routes.chatDetails,
            arguments: displayProfile,
          ),
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 12),
    );
  }

}



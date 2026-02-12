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
    // نستخدم SliverList بدلاً من ListView لتعمل داخل CustomScrollView
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
              (context, index) {
            final inbox = messages[index];
            final bool isMeSender = inbox.sender == currentUserId;

            // تحديد الملف الشخصي للطرف الآخر في المحادثة
            final displayProfile = isMeSender ? inbox.receiverProfile : inbox.senderProfile;

            if (displayProfile == null) return const SizedBox.shrink();

            return Padding(
              padding: const EdgeInsets.only(bottom: 12), // بديل للـ separator
              child: InboxCard(
                key: ValueKey(inbox.id),
                user: displayProfile,
                message: inbox.message,
                isMe: isMeSender,
                time: inbox.timestamp,
                isRead: inbox.isRead,
                onTap: () => Navigator.pushNamed(
                  context,
                  Routes.chatDetails,
                  arguments: displayProfile,
                ),
              ),
            );
          },
          childCount: messages.length,
        ),
      ),
    );
  }
}


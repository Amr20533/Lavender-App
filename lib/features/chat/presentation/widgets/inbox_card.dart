
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/core/widget/alex_text.dart';
import 'package:lavender/core/widget/custom_cached_network_image.dart';
import 'package:lavender/features/chat/data/models/chat/inbox_user_profile.dart';
import 'package:lavender/features/chat/presentation/widgets/inbox_card_skeleton.dart';

class InboxCard extends StatelessWidget {
  final InboxUserProfile user;
  final String message;
  final VoidCallback onTap;
  final bool isLoading;
  final DateTime time;
  final bool isRead;
  final bool isMe;

  const InboxCard({
    super.key,
    required this.user,
    required this.onTap,
    required this.message,
    this.isLoading = false,
    required this.time,
    this.isRead = false,
    this.isMe = false,
  });

  @override
  Widget build(BuildContext context) {

    final String formattedTime = DateFormat('HH:mm').format(time);

    if (isLoading) {
      return const InboxCardSkeleton();
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.doctorCardColor
          // gradient: AppColors.inboxGradient
          // border: Border.all(color: AppColors.secondDividerColor), // Border added
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Image
              Container(
                width: 50,
                height: 50,
                padding: EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: ClipOval(
                  child: CustomCachedNetworkImage(
                    imageUrl: '${user.profilePic}',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Text Info
              Expanded( // Use Expanded instead of Fixed Width for better responsiveness
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AlexText(
                      text: '${user.user.firstName} ${user.user.lastName}',
                      color: AppColors.primaryColorDarkText,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                    const SizedBox(height: 4),
                    AlexText(
                      text: message,
                      color: AppColors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AlexText(
                    text: formattedTime,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.purple600,
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    isRead ? Icons.done_all_sharp : Icons.done_all,
                    size: 16,
                    color: isRead ? AppColors.purple600 : AppColors.grey,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

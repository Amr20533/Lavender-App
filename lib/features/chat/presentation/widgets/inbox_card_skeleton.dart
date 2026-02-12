import 'package:flutter/material.dart';
import 'package:lavender/core/themes/app_colors.dart';

class InboxCardSkeleton extends StatelessWidget {
  const InboxCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(radius: 24,backgroundColor: AppColors.grey100,),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 14, width: 120, color: AppColors.dividerColor),
              const SizedBox(height: 8),
              Container(height: 12, width: 180, color: AppColors.dividerColor),
            ],
          ),
        ),
      ],
    );
  }
}

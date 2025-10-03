import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/core/widget/alex_text.dart';
import 'package:lavender/core/widget/custom_cached_network_image.dart';
import 'package:lavender/features/community/data/models/post.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.dividerColor,
        borderRadius: BorderRadius.circular(16.sp),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor:
                AppColors.primaryColorLavenderLangAndText,
              ),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AlexText(
                    text: "شروق تمام",
                    color: Colors.black,
                  ),
                  AlexText(
                    text: timeago.format(post.createdAt),
                    color: AppColors.grey,
                    fontSize: 12,
                  ),
                ],
              ),
              Spacer(),
              Icon(Icons.more_vert_sharp,
                  color: AppColors.primaryColorLavenderLangAndText,
                  size: 30),
            ],
          ),
          SizedBox(height: 12.h),
          AlexText(
            text: post.caption,
            color: Colors.black,
            fontSize: 12,
          ),
          SizedBox(height: 8.h),
          if (post.image != null) ...[
            CustomCachedNetworkImage(
              width: double.infinity,
              height: 260.h,
              imageUrl: post.image!,
            ),
            SizedBox(height: 8.h),
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset('assets/icons/heart.png'),
                  SizedBox(width: 5.w),
                  AlexText(
                    text: "${post.likesCount} اعجاب",
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ],
              ),
              Row(
                children: [
                  Image.asset('assets/icons/message-notif.png'),
                  SizedBox(width: 5.w),
                  AlexText(
                    text: "${post.comments.length} تعليق",
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ],
              ),
              Row(
                children: [
                  Image.asset('assets/icons/send-2.png'),
                  SizedBox(width: 5.w),
                  AlexText(
                    text: "مشاركة",
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

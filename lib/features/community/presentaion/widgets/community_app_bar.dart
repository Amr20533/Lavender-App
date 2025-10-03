import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/core/widget/alex_text.dart';
import 'package:lavender/core/widget/circularIcon.dart';

class CommunityAppBar extends StatelessWidget {
  const CommunityAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      padding: EdgeInsetsDirectional.only(top: 20, start: 16, end: 16,),
      decoration: BoxDecoration(
          color: Colors.white
      ),
      child:Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
                color: AppColors.purple50,
                shape: BoxShape.circle
            ),
          ),
          CircularIcon(icon: 'search.png',),
          const Spacer(),
          AlexText(text: "المجتمع"),
          const Spacer(),
          CircularIcon(icon: 'message-notif.png',),
          CircularIcon(icon: 'notification.png',),
        ],
      ),
    );
  }
}

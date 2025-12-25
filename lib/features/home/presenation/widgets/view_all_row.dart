import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/core/themes/stylesdart.dart';
import 'package:lavender/core/widget/alex_text.dart';
import '../../../../../../l10n/app_localizations.dart';

class ViewAllRow extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const ViewAllRow({
    super.key,
    required this.title,
    required this.onTap,
  });

 @override
Widget build(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AlexText(
          text: title,
        ),
        GestureDetector(
          onTap: onTap,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AlexText(
                text: AppLocalizations.of(context)?.view_all ?? "عرض الكل",
                fontSize: 12.sp,
                color: AppColors.lightBlack,
              ),
              SizedBox(height: 1.5.h),
              Container(
                height: 1.2.h, 
                width: 60.w,
                color: AppColors.lightBlack,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
}
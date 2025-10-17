import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/core/themes/stylesdart.dart';
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
        Text(
          title,
          style: TextStyles.bodyMedium.copyWith(
            color: AppColors.primaryColorLavenderLangAndText,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppLocalizations.of(context)?.view_all ?? "عرض الكل",
                style: TextStyles.smallMedium.copyWith(
                  fontSize: 15.sp,
                  color: AppColors.primaryColorLavenderLangAndText,
                ),
              ),
              SizedBox(height: 1.h),
              Container(
                height: 1.2.h, 
                width: 56.w,
                color: AppColors.primaryColorLavenderLangAndText,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
}
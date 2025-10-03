import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/core/widget/alex_text.dart';


class ToolCard extends StatelessWidget {
  final String text;
  final String imagePath;
  final double? width;
  final double? height;
  final void Function()? onTap;

  const ToolCard({
    super.key,
    required this.text,
    required this.imagePath,
    this.width,
    this.height,
    this.onTap,

  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width:width ?? 163.w,
        height:height ?? 72.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: AppColors.purple50,
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.only(start: 12.w),
              child: AlexText(text: text, color: Colors.black, fontSize: 12,),
            ),

            Image.asset(imagePath, fit: BoxFit.cover),

          ],
        ),
      ),
    );
  }
}

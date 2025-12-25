import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/core/widget/alex_text.dart';
import 'package:lavender/core/widget/custom_cached_network_image.dart';
import '../../../../core/widget/custom_rich_text.dart';
import '../../data/models/free_programs/free_program.dart';

class ProgramCard extends StatelessWidget {
  final FreeProgram program;
  final void Function()? onTap;

  const ProgramCard({
    super.key,
    required this.program,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 240,
        decoration: BoxDecoration(
          color: Colors.white,
          // gradient: AppColors.softRedCardGradient,
          border: Border.all(width: 1, color: AppColors.lightBorder),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // CustomCachedNetworkImage(imageUrl: program.image),
            Stack(
              clipBehavior: Clip.none,
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                CustomCachedNetworkImage(
                  imageUrl: program.image,
                  height: 120.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  sided: true,
                ),
                PositionedDirectional(
                  bottom: -20,
                  end: 16,
                  child: Container(
                    width: 55,
                    height: 55,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(width: 3, color: Colors.white)
                    ),
                    child: Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: CustomCachedNetworkImage(
                        imageUrl: program.author.profilePic,
                      ),
                    ),
                  ),
                ),

              ],
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                spacing: 8,
                children: [
                  AlexText(
                    text: program.title,
                    fontSize: 16.sp,
                    color: AppColors.lightBlack,
                    fontWeight: FontWeight.w600,
                  ),
                  AlexText(
                    text: '${program.sessions.length} لقاءات',
                    fontSize: 12,
                    color: AppColors.lightBlack,
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomRichText(title: 'اللقاء القادم: ', secondTitle: program.sessions.last.title),
            ),
            SizedBox(height: 8.h),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomRichText(title: 'الموعد: ', secondTitle: program.sessions.last.formattedDate),
            ),

            AlexText(
              text: '${program.category}',
              fontSize: 12,
              color: AppColors.lightBlack,
            ),

          ],
        ),
      ),
    );
  }
}


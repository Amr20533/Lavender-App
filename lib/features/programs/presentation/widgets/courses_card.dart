import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/core/widget/alex_text.dart';
import 'package:lavender/core/widget/app_icons.dart';
import 'package:lavender/core/widget/custom_cached_network_image.dart';
import 'package:lavender/features/programs/data/models/course_model.dart';

class CoursesCard extends StatelessWidget {
  final CourseModel course;
  final void Function()? onTap;

  const CoursesCard({
    super.key,
    required this.course,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 170.w,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          gradient: AppColors.softRedCardGradient,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // CustomCachedNetworkImage(imageUrl: course.image),
            Stack(
              clipBehavior: Clip.none,
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                CustomCachedNetworkImage(
                  imageUrl: course.image,
                  height: 105.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: -20,
                  child: Container(
                    width: 50,
                    height: 50,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: CustomCachedNetworkImage(
                      imageUrl: course.instructor.profilePic,
                    ),
                  ),
                ),

              ],
            ),
            SizedBox(height: 20.h),

            AlexText(
              text: course.title,
              fontSize: 12.sp,
              color: Colors.black,
            ),

            SizedBox(height: 4.h),

            Row(
              children: [
                AlexText(
                    text: '(${course.avgRating})',
                    // '(${widget.course.reviewsCount}) ${widget.rating.toStringAsFixed(1)}',
                    fontSize: 12.sp,
                    color: Colors.black
                ),
                const SizedBox(width: 4),
                ...List.generate(course.avgRating.toInt(), (index) {
                  bool lastStar = course.avgRating.toInt() -1 == index;
                  return Padding(
                    padding: const EdgeInsetsDirectional.only(end: 4),
                    child: Icon(AppIcons.star_9, color: Colors.amber, size: 16),
                    // child: Icon(!lastStar ? AppIcons.star_9 : Icons.star_border_outlined, color: Colors.amber, size: 16),
                  );
                }),
              ],
            ),

            SizedBox(height: 8.h),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: AppColors.purple300,
                borderRadius: BorderRadius.circular(25.r),
              ),
              child: Row(
                spacing: 4.w,
                children: [
                  CircleAvatar(
                    radius: 4,
                    backgroundColor: AppColors.purple200,
                  ),
                  AlexText(
                    text: course.category,
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ],
              ),
            ),

            SizedBox(height: 8.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AlexText(
                  text: '${course.totalSessions} دروس 📖',
                  fontSize: 12,
                  color: Colors.black,
                ),
                AlexText(
                  text: '${course.price} جنيه',
                  fontSize: 12,
                  color: Colors.black,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class CourseCardShimmer extends StatelessWidget {
  const CourseCardShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
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
            Container(
              height: 105.h,
              width: double.infinity,
              color: Colors.white,
            ),
            SizedBox(height: 8.h),
            CircleAvatar(radius: 25.r, backgroundColor: Colors.white),
            SizedBox(height: 8.h),
            Container(height: 14.h, width: 100.w, color: Colors.white),
            SizedBox(height: 4.h),
            Container(height: 12.h, width: 60.w, color: Colors.white),
            SizedBox(height: 8.h),
            Container(height: 20.h, width: 70.w, color: Colors.white),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(height: 12.h, width: 60.w, color: Colors.white),
                Container(height: 12.h, width: 40.w, color: Colors.white),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
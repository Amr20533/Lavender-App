import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class PostCardShimmer extends StatelessWidget {
  const PostCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: AppColors.softRedCardGradient,
          borderRadius: BorderRadius.circular(16.r),

        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Avatar and Name/Date
            Row(
              children: [
                Container(
                  width: 45,
                  height: 45,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 8.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 12.h,
                      width: 100.w,
                      color: Colors.white,
                    ),
                    SizedBox(height: 6.h),
                    Container(
                      height: 10.h,
                      width: 60.w,
                      color: Colors.white,
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  width: 8.w,
                  height: 30.h,
                  color: Colors.white,
                ),
              ],
            ),

            SizedBox(height: 12.h),


            // Main Post Image
            Container(
              width: double.infinity,
              height: 260.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),

            SizedBox(height: 12.h),

            // Caption lines
            Container(
              height: 12.h,
              width: double.infinity,
              color: Colors.white,
            ),
            SizedBox(height: 6.h),
            Container(
              height: 12.h,
              width: 200.w,
              color: Colors.white,
            ),

            SizedBox(height: 12.h),

            // Footer: Like, Comment, Share actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(3, (index) => Row(
                children: [
                  Container(
                    width: 24.w,
                    height: 24.w,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Container(
                    height: 10.h,
                    width: 40.w,
                    color: Colors.white,
                  ),

                ],
              )),
            ),
          ],
        ),
      ),
    );
  }
}
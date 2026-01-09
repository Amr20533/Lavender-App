import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class DoctorCardShimmer extends StatelessWidget {
  const DoctorCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: AppColors.doctorCardColor, // Keeps the card background visible
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Doctor Image Placeholder
                Container(
                  height: 70.w,
                  width: 70.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                SizedBox(width: 12.w),

                // Doctor Info Placeholders
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(height: 14.h, width: 120.w, color: Colors.white),
                          Container(height: 20.h, width: 20.w, color: Colors.white), // Fav icon
                        ],
                      ),
                      SizedBox(height: 6.h),
                      Container(height: 10.h, width: 100.w, color: Colors.white), // Experience
                      SizedBox(height: 8.h),
                      Container(height: 10.h, width: 140.w, color: Colors.white), // Attendance
                      SizedBox(height: 6.h),
                      Container(height: 10.h, width: 130.w, color: Colors.white), // Stories
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 12.h),

            // Appointment text line
            Container(height: 10.h, width: 200.w, color: Colors.white),

            SizedBox(height: 16.h),

            // Bottom Row: Button and Price
            Row(
              children: [
                // Book Now Button placeholder
                Expanded(
                  child: Container(
                    height: 45.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                // Price placeholder
                Column(
                  children: [
                    Container(height: 12.h, width: 50.w, color: Colors.white),
                    SizedBox(height: 4.h),
                    Container(height: 10.h, width: 60.w, color: Colors.white),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
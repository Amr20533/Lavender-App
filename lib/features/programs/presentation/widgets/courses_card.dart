import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class CoursesCard extends StatefulWidget {
  final String title;
  final String category;
  final String imageUrl; 
  final String doctorImage; 
  final double rating;
  final int reviewsCount;
  final int lessonsCount;
  final double price;

  const CoursesCard({
    super.key,
    required this.title,
    required this.category,
    required this.imageUrl,
    required this.doctorImage,
    required this.rating,
    required this.reviewsCount,
    required this.lessonsCount,
    required this.price,
  });

  @override
  State<CoursesCard> createState() => _CoursesCardState();
}

class _CoursesCardState extends State<CoursesCard> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
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

    return Container(
      width: 170.w,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        gradient: AppColors.softRedCardGradient,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: SvgPicture.asset(
              widget.imageUrl,
              height: 105.h,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8.h),

          CircleAvatar(
            radius: 25.r,
            backgroundColor: Colors.white,
            child: ClipOval(
              child: Image.asset(
                widget.doctorImage,
                height: 50.h,
                width: 50.w,
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(height: 8.h),

          Text(
            widget.title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
          ),

          SizedBox(height: 4.h),

          Row(
            children: [
              Text(
                '(${widget.reviewsCount}) ${widget.rating.toStringAsFixed(1)}',
                style: TextStyle(fontSize: 12.sp, color: Colors.grey[700]),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.star, color: Colors.amber, size: 16),
            ],
          ),

          SizedBox(height: 8.h),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: AppColors.purple300,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              widget.category,
              style: TextStyle(
                color: AppColors.w,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          SizedBox(height: 8.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${widget.lessonsCount} دروس 📖',
                style: TextStyle(fontSize: 12.sp),
              ),
              Text(
                '${widget.price} جنيه',
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

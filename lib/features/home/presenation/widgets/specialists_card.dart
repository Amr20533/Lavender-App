import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpecialistCard extends StatelessWidget {
  final String text;
  final String imagePath;
  final double? width;
  final double? height;

  const SpecialistCard({
    super.key,
    required this.text,
    required this.imagePath,
    this.width,
     this.height,
    
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width:width ?? 176.w,
      height:height ?? 100.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: Colors.grey.shade200,
      ),
      clipBehavior: Clip.antiAlias, // عشان الصورة تتقص مع الحواف
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child:
                imagePath.endsWith('.asset')
                    ? Image.asset(imagePath, fit: BoxFit.cover)
                    : Image.asset(imagePath, fit: BoxFit.cover),
          ),

          Container(
            alignment: Alignment.center,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

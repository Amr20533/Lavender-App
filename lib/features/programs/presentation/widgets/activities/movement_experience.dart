import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'activity_experience_overlay.dart';
import 'package:lavender/core/widget/alex_text.dart';

class MovementExperience extends StatelessWidget {
  const MovementExperience({super.key});

  @override
  Widget build(BuildContext context) {
    return ActivityExperienceOverlay(
      title: "حركة.. مرونة",
      bgColor: const Color(0xFFE8F5E9),
      onComplete: () => Navigator.pop(context),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AlexText(
            text: "افرد ضهرك وحرك رقبتك بهدوء الآن..",
            fontSize: 18,
            textAlign: TextAlign.center,
            color: Colors.black87,
          ),
          SizedBox(height: 40.h),
          Container(
            width: 200.w,
            height: 200.w,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.green.shade100,
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                "assets/icons/yoga-01.png",
                fit: BoxFit.contain,
                scale: 0.5,
              ),
            ),
          ),
          SizedBox(height: 40.h),
          AlexText(
            text: "١٠ ثواني تكفي لتجديد الدورة الدموية 🌿",
            fontSize: 16,
            color: Colors.black54,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

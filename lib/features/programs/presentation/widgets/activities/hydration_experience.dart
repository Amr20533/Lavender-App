import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'activity_experience_overlay.dart';
import 'package:lavender/core/widget/alex_text.dart';

class HydrationExperience extends StatefulWidget {
  const HydrationExperience({super.key});

  @override
  State<HydrationExperience> createState() => _HydrationExperienceState();
}

class _HydrationExperienceState extends State<HydrationExperience>
    with SingleTickerProviderStateMixin {
  late AnimationController _waterController;
  late Animation<double> _waterAnimation;

  @override
  void initState() {
    super.initState();
    _waterController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..forward();
    _waterAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _waterController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _waterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ActivityExperienceOverlay(
      title: "ارتوِ.. بوعي",
      bgColor: AppColors.w,
      onComplete: () => Navigator.pop(context),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AlexText(
            text: "اشرب كوب ماء ببطء الآن..",
            fontSize: 18,
            textAlign: TextAlign.center,
            color: Colors.black87,
          ),
          SizedBox(height: 40.h),
          Container(
            width: 120.w,
            height: 180.h,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue.shade200, width: 4),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.r),
                bottomRight: Radius.circular(20.r),
              ),
            ),
            padding: const EdgeInsets.all(4),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                AnimatedBuilder(
                  animation: _waterAnimation,
                  builder: (context, child) {
                    return Container(
                      width: double.infinity,
                      height: 180.h * _waterAnimation.value,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade300.withOpacity(0.6),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16.r),
                          bottomRight: Radius.circular(16.r),
                          topLeft: Radius.circular(5.r),
                          topRight: Radius.circular(5.r),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 40.h),
          AlexText(
            text: "المياه بتجدد طاقتك 💧",
            fontSize: 16,
            color: Colors.black54,
          ),
        ],
      ),
    );
  }
}

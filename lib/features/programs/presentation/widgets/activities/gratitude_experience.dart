import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'activity_experience_overlay.dart';
import 'package:lavender/core/widget/alex_text.dart';

class GratitudeExperience extends StatefulWidget {
  const GratitudeExperience({super.key});

  @override
  State<GratitudeExperience> createState() => _GratitudeExperienceState();
}

class _GratitudeExperienceState extends State<GratitudeExperience>
    with SingleTickerProviderStateMixin {
  late AnimationController _heartController;
  late Animation<double> _heartAnimation;

  @override
  void initState() {
    super.initState();
    _heartController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    _heartAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _heartController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _heartController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ActivityExperienceOverlay(
      title: "امتنان..",
      bgColor: const Color(0xFFFFF3E0),
      onComplete: () => Navigator.pop(context),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AlexText(
            text: "غمض عينيك وفكر في شخص غالي عليك..",
            fontSize: 18,
            textAlign: TextAlign.center,
            color: Colors.black87,
          ),
          SizedBox(height: 40.h),
          ScaleTransition(
            scale: _heartAnimation,
            child: Icon(
              Icons.favorite,
              color: Colors.red.shade400,
              size: 100.w,
            ),
          ),
          SizedBox(height: 40.h),
          AlexText(
            text: "ادعيله دعوة حلوة من قلبك ✨",
            fontSize: 16,
            color: Colors.black54,
          ),
        ],
      ),
    );
  }
}

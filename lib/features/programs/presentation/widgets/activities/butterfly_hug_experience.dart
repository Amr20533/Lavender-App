import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'activity_experience_overlay.dart';
import 'package:lavender/core/widget/alex_text.dart';

class ButterflyHugExperience extends StatefulWidget {
  const ButterflyHugExperience({super.key});

  @override
  State<ButterflyHugExperience> createState() => _ButterflyHugExperienceState();
}

class _ButterflyHugExperienceState extends State<ButterflyHugExperience>
    with SingleTickerProviderStateMixin {
  late AnimationController _swingController;
  late Animation<double> _leftWingAnimation;
  late Animation<double> _rightWingAnimation;

  @override
  void initState() {
    super.initState();
    _swingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _leftWingAnimation = Tween<double>(begin: 0.8, end: 1.1).animate(
      CurvedAnimation(
        parent: _swingController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeInOut),
      ),
    );
    _rightWingAnimation = Tween<double>(begin: 0.8, end: 1.1).animate(
      CurvedAnimation(
        parent: _swingController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeInOut),
      ),
    );
  }

  @override
  void dispose() {
    _swingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ActivityExperienceOverlay(
      title: "حضن الفراشة 🦋",
      bgColor: const Color(0xFFFFF3E0),
      onComplete: () => Navigator.pop(context),
      content: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AlexText(
              text: "ضعي يديكِ على كتافك بشكل متعاكس..",
              fontSize: 18,
              textAlign: TextAlign.center,
              color: Colors.black87,
            ),
            SizedBox(height: 12.h),
            AlexText(
              text: "وابدأي بالضغط ببطء بالتناوب (يمين - شمال)",
              fontSize: 14,
              textAlign: TextAlign.center,
              color: Colors.black54,
            ),
            SizedBox(height: 50.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ScaleTransition(
                  scale: _leftWingAnimation,
                  child: Icon(
                    Icons.pan_tool,
                    color: Colors.purple.shade300,
                    size: 80.w,
                  ),
                ),
                SizedBox(width: 20.w),
                ScaleTransition(
                  scale: _rightWingAnimation,
                  child: Transform.flip(
                    flipX: true,
                    child: Icon(
                      Icons.pan_tool,
                      color: Colors.purple.shade300,
                      size: 80.w,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50.h),
            AlexText(
              text:
                  "هذا التمرين يساعد على توازن فصي الدماغ وتقليل القلق فوراً ✨",
              fontSize: 14,
              color: Colors.black54,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

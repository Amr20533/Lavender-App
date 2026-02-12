import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'activity_experience_overlay.dart';

class PauseExperience extends StatefulWidget {
  const PauseExperience({super.key});

  @override
  State<PauseExperience> createState() => _PauseExperienceState();
}

class _PauseExperienceState extends State<PauseExperience>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ActivityExperienceOverlay(
      title: "توقف.. تنفس",
      bgColor: const Color(0xFFF3E5F5),
      onComplete: () => Navigator.pop(context),
      content: AnimatedBuilder(
        animation: _pulseAnimation,
        builder: (context, child) {
          return Container(
            width: 150.w * _pulseAnimation.value,
            height: 150.w * _pulseAnimation.value,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFCE93D8).withOpacity(0.3),
              border: Border.all(
                color: const Color(0xFFAB47BC).withOpacity(0.5),
                width: 2,
              ),
            ),
            child: Center(
              child: Container(
                width: 100.w,
                height: 100.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFAB47BC),
                ),
                child: Center(
                  child: Text(
                    _pulseController.status == AnimationStatus.forward
                        ? "شهيق"
                        : "زفير",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'activity_experience_overlay.dart';
import 'package:lavender/core/widget/alex_text.dart';

class GroundingExperience extends StatefulWidget {
  const GroundingExperience({super.key});

  @override
  State<GroundingExperience> createState() => _GroundingExperienceState();
}

class _GroundingExperienceState extends State<GroundingExperience>
    with SingleTickerProviderStateMixin {
  late AnimationController _searchController;
  late Animation<double> _searchAnimation;

  @override
  void initState() {
    super.initState();
    _searchController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _searchAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _searchController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ActivityExperienceOverlay(
      title: "تركيز وتأريض..",
      bgColor: const Color(0xFFFFF3E0),
      onComplete: () => Navigator.pop(context),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AlexText(
            text: "بص حواليك دلوقتي بتركيز..",
            fontSize: 18,
            textAlign: TextAlign.center,
            color: Colors.black87,
          ),
          SizedBox(height: 30.h),
          AlexText(
            text: "طلع ٣ حاجات لونها [أزرق] في المكان",
            fontSize: 20,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
            color: Colors.blue.shade700,
          ),
          SizedBox(height: 40.h),
          ScaleTransition(
            scale: _searchAnimation,
            child: Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.shade100.withOpacity(0.5),
              ),
              child: Icon(
                Icons.search,
                color: Colors.blue.shade400,
                size: 60.w,
              ),
            ),
          ),
          SizedBox(height: 40.h),
          AlexText(
            text: "التمرين ده بيساعد عقلك يهدأ ويركز في اللحظة 🦋",
            fontSize: 14,
            color: Colors.black54,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

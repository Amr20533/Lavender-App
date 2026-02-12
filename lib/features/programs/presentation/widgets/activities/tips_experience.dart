import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/core/widget/alex_text.dart';
import 'activity_experience_overlay.dart';
import 'dart:math';

class TipsExperience extends StatefulWidget {
  const TipsExperience({super.key});

  @override
  State<TipsExperience> createState() => _TipsExperienceState();
}

class _TipsExperienceState extends State<TipsExperience> {
  final List<String> _tips = [
    "لا بأس بأن لا تطلب الكمال؛ يكفي أنك تحاول.",
    "صحتك النفسية ليست رفاهية، بل هي الأساس.",
    "الحدود التي ترسمها مع الآخرين هي تعبير عن حبك لذاتك.",
    "تحدث مع نفسك كما تتحدث مع صديق تحبه.",
    "مشاعرك حقيقية تماماً، ولها الحق في الوجود.",
    "الراحة جزء من الإنتاجية، وليست عائقاً لها.",
    "أنت لست أفكارك القلقة؛ أنت من يراقبها.",
  ];

  late String _currentTip;

  @override
  void initState() {
    super.initState();
    _currentTip = _tips[Random().nextInt(_tips.length)];
  }

  @override
  Widget build(BuildContext context) {
    return ActivityExperienceOverlay(
      title: "نصيحة لافندر 🌿",
      bgColor: AppColors.w,
      onComplete: () => Navigator.pop(context),
      content: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.r),
                boxShadow: [
                  BoxShadow(color: Colors.purple.shade100, blurRadius: 15),
                ],
              ),
              child: AlexText(
                text: _currentTip,
                fontSize: 18,
                textAlign: TextAlign.center,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 40.h),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _currentTip = _tips[Random().nextInt(_tips.length)];
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple.shade300,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              ),
              child: const AlexText(
                text: "نصيحة أخرى",
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

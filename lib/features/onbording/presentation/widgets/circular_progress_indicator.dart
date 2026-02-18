import 'package:flutter/material.dart';
import 'package:lavender/features/onbording/presentation/widgets/segmented_circle_painter.dart';

class CircularProgressIndicatorWidget extends StatelessWidget {
  final double progress; // من 0.0 إلى 1.0
  final int totalSegments; // عدد الصفحات الكلي
  final VoidCallback? onNext;

  const CircularProgressIndicatorWidget({
    super.key,
    required this.progress,
    required this.totalSegments,
    this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: const Size(65, 65), // تكبير الحجم قليلاً ليعطي مساحة للرسم
          painter: SegmentedCirclePainter(
            segmentCount: totalSegments,
            progress: progress,
            strokeWidth: 8,
            gapAngle: 0.46,
            backgroundColor: Colors.white.withValues(alpha: 0.3),
            foregroundColor: const Color.fromARGB(255, 162, 161, 245),
          ),
        ),
        GestureDetector(
          onTap: onNext,
          child: Container(
            width: 45,
            height: 45,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_forward_ios,
              color: Color.fromARGB(255, 152, 151, 232),
              size: 18,
            ),
          ),
        ),
      ],
    );
  }
}
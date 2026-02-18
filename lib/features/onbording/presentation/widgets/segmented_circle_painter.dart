import 'dart:math';
import 'package:flutter/material.dart';

class SegmentedCirclePainter extends CustomPainter {
  final int segmentCount;
  final double progress;
  final double strokeWidth;
  final double gapAngle; // الفجوة بين القطع
  final Color backgroundColor;
  final Color foregroundColor;

  SegmentedCirclePainter({
    required this.segmentCount,
    required this.progress,
    required this.strokeWidth,
    required this.gapAngle,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (min(size.width, size.height) - strokeWidth) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    // زاوية كل قطعة شاملة الفجوة
    double totalArcPerSegment = (2 * pi) / segmentCount;
    // الزاوية الفعلية للرسم بعد خصم الفجوة
    double drawArcAngle = totalArcPerSegment - gapAngle;

    Paint backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Paint foregroundPaint = Paint()
      ..color = foregroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // رسم جميع القطع (الخلفية)
    for (int i = 0; i < segmentCount; i++) {
      double startAngle = (i * totalArcPerSegment) - (pi / 2) + (gapAngle / 2);
      canvas.drawArc(rect, startAngle, drawArcAngle, false, backgroundPaint);
    }

    // رسم القطع المكتملة بناءً على التقدم (Foreground)
    double currentProgressAngle = progress * (2 * pi);
    int completedSegments = (progress * segmentCount).floor();

    for (int i = 0; i < segmentCount; i++) {
      double startAngle = (i * totalArcPerSegment) - (pi / 2) + (gapAngle / 2);

      // إذا كان التقدم يغطي هذه القطعة بالكامل أو جزئياً
      if (i < completedSegments) {
        // قطعة كاملة
        canvas.drawArc(rect, startAngle, drawArcAngle, false, foregroundPaint);
      } else if (i == completedSegments) {
        // قطعة جزئية (لإعطاء تأثير سلس أثناء الانتقال)
        double segmentProgress = (progress * segmentCount) - completedSegments;
        canvas.drawArc(rect, startAngle, drawArcAngle * segmentProgress, false, foregroundPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant SegmentedCirclePainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.segmentCount != segmentCount;
  }
}
import 'package:flutter/material.dart';

class QuotePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();


    // Path number 1

    paint.color = Color(0xff7270E4);
    path = Path();
    path.lineTo(size.width / 2, 0);
    path.cubicTo(size.width * 0.52, 0, size.width * 0.55, size.height * 0.02, size.width * 0.57, size.height * 0.05);
    path.cubicTo(size.width * 0.6, size.height * 0.09, size.width * 0.63, size.height * 0.16, size.width * 0.66, size.height * 0.16);
    path.cubicTo(size.width * 0.66, size.height * 0.16, size.width * 0.91, size.height * 0.16, size.width * 0.91, size.height * 0.16);
    path.cubicTo(size.width * 0.96, size.height * 0.16, size.width, size.height * 0.26, size.width, size.height * 0.38);
    path.cubicTo(size.width, size.height * 0.38, size.width, size.height * 0.77, size.width, size.height * 0.77);
    path.cubicTo(size.width, size.height * 0.9, size.width * 0.96, size.height, size.width * 0.91, size.height);
    path.cubicTo(size.width * 0.91, size.height, size.width * 0.09, size.height, size.width * 0.09, size.height);
    path.cubicTo(size.width * 0.04, size.height, 0, size.height * 0.9, 0, size.height * 0.77);
    path.cubicTo(0, size.height * 0.77, 0, size.height * 0.38, 0, size.height * 0.38);
    path.cubicTo(0, size.height * 0.26, size.width * 0.04, size.height * 0.16, size.width * 0.09, size.height * 0.16);
    path.cubicTo(size.width * 0.09, size.height * 0.16, size.width * 0.34, size.height * 0.16, size.width * 0.34, size.height * 0.16);
    path.cubicTo(size.width * 0.37, size.height * 0.16, size.width * 0.4, size.height * 0.09, size.width * 0.43, size.height * 0.05);
    path.cubicTo(size.width * 0.45, size.height * 0.02, size.width * 0.48, 0, size.width / 2, 0);
    path.cubicTo(size.width / 2, 0, size.width / 2, 0, size.width / 2, 0);
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

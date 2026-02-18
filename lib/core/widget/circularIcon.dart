import 'package:flutter/material.dart';
import 'package:lavender/core/themes/app_colors.dart';

class CircularIcon extends StatelessWidget {
  const CircularIcon({
    super.key, required this.icon,this.color = AppColors.purple50,this.borderColor = AppColors.lightBorder,
  });
  final String icon;
  final Color color;
  final Color borderColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(start: 15),
      width: 42,
      height: 42,
      decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        border: Border.all(width: 1, color: borderColor)
      ),
      child: Image.asset("assets/icons/$icon"),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lavender/core/themes/app_colors.dart';

class CircularIcon extends StatelessWidget {
  const CircularIcon({
    super.key, required this.icon,
  });
  final String icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(start: 15),
      width: 42,
      height: 42,
      decoration: BoxDecoration(
          color: AppColors.purple50,
          shape: BoxShape.circle
      ),
      child: Image.asset("assets/icons/$icon"),
    );
  }
}

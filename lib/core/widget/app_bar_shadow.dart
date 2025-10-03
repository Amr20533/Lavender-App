import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lavender/core/themes/app_colors.dart';

class AppBarShadow extends StatelessWidget {
  const AppBarShadow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2.h,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
    );
  }
}

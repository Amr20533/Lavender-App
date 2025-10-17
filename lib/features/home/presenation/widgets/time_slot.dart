import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/themes/app_colors.dart';

class TimeSlot extends StatelessWidget {
  final String label;
  final bool booked;
  final bool selected;
  final VoidCallback onTap;

  const TimeSlot({
    super.key,
    required this.label,
    this.booked = false,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return !booked ? GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          gradient: !selected ? null : AppColors.linearGradient,
          color: selected ? AppColors.primaryColorLavenderLangAndText : AppColors.inactiveBorderColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: selected ? AppColors.primaryColorDarkText : AppColors.purpleShade,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    ) : Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1.w, color: AppColors.inactiveBorderColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        "Booked $label",
        style: TextStyle(
          color: AppColors.shadePurpleColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class DayChip extends StatelessWidget {
  final String day;
  final String date;
  final bool selected;
  final VoidCallback onTap;

  const DayChip({
    super.key,
    required this.day,
    required this.date,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60.w,
        height: 64.h,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          gradient: selected ? AppColors.linearGradient : null,
          color: selected ? null : AppColors.inactiveBorderColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                day,
                style: GoogleFonts.poppins(
                  color: AppColors.primaryColorDarkText,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600
                ),
              ),
              Text(
                date,
                style: GoogleFonts.alexandria(
                  color: selected
                      ? AppColors.primaryColorDarkText
                      : AppColors.inActiveDateColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

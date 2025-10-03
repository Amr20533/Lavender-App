import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lavender/core/themes/app_colors.dart';

class InterText extends StatelessWidget {
  const InterText({super.key,
    required this.text,
    this.fontSize= 16,
    this.fontWeight = FontWeight.w500,
    this.color = AppColors.primaryColorLavenderLangAndText,
    this.textAlign = TextAlign.start
  });
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: GoogleFonts.inter(
      fontSize: fontSize.sp,
      fontWeight: FontWeight.w500,
      color: color,),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign,
    );
  }
}

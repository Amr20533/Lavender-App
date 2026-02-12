import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lavender/core/themes/app_colors.dart';

class AlexText extends StatelessWidget {
  const AlexText({super.key,
    required this.text,
    this.fontSize= 16,
    this.fontWeight = FontWeight.w500,
    this.color = AppColors.primaryColorLavenderLangAndText,
    this.textAlign = TextAlign.start,
    this.maxLines = 2,
    this.overflow = TextOverflow.ellipsis,
    });
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: GoogleFonts.alexandria(
        fontSize: fontSize.sp,
        fontWeight: FontWeight.w500,
        color: color,),
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
    );
  }
}

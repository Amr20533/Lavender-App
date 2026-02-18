import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../themes/app_colors.dart';

class CustomRichText extends StatelessWidget {
  const CustomRichText({
    super.key, required this.title, required this.secondTitle,
  });
  final String title;
  final String secondTitle;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textDirection: TextDirection.rtl,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: GoogleFonts.alexandria(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          // TextSpan(
          //   text: ' لقاء 1 ',
          //   style: TextStyle(
          //     fontSize: 15,
          //     fontWeight: FontWeight.bold,
          //     color: AppColors.lightBlack,
          //   ),
          // ),
          TextSpan(
            text: secondTitle,
            style: GoogleFonts.alexandria(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.lightBlack,
            ),
          ),
        ],
      ),
    );
  }
}
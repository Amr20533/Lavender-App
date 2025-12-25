import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lavender/core/themes/app_colors.dart';

// Progress Indicator Widget
class QuizProgressIndicator extends StatelessWidget {
  final int currentQuestion;
  final int totalQuestions;

  const QuizProgressIndicator({
    super.key,
    required this.currentQuestion,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$currentQuestion',
            style: GoogleFonts.poppins(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColorDarkText,
            ),
          ),
          Text(
            ' / $totalQuestions',
            style: GoogleFonts.poppins(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(width: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(totalQuestions, (index) {
              final questionNumber = index + 1;
              final isAnswered = questionNumber < currentQuestion;
              final isCurrent = questionNumber == currentQuestion;

              return Container(
                margin: const EdgeInsets.only(right: 6),
                width: 8.w,
                height: 8.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient:
                      isAnswered || isCurrent
                          ? AppColors.linearGradient
                          : null,
                  color:
                      isAnswered || isCurrent
                          ? null
                          : const Color(0xFFE0E0FF),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

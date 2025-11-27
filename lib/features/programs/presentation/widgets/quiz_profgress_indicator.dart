import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lavender/core/themes/app_colors.dart';

// Progress Indicator Widget
class QuizProgressIndicator extends StatelessWidget {
  final int currentQuestion;
  final int totalQuestions;

  const QuizProgressIndicator({
    Key? key,
    required this.currentQuestion,
    required this.totalQuestions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
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
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(totalQuestions, (index) {
                  final questionNumber = index + 1;
                  final isAnswered = questionNumber < currentQuestion;
                  final isCurrent = questionNumber == currentQuestion;

                  return Container(
                    margin: const EdgeInsets.only(right: 6),
                    width: 25.w,
                    height: 8.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
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
            ),
          ),
        ],
      ),
    );
  }
}

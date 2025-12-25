import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lavender/core/routing/router.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/core/widget/alex_text.dart';
import 'package:lavender/core/widget/back_icon.dart';
import 'package:lavender/features/programs/data/models/quizzes/quizzes_response.dart';
import 'package:lavender/features/programs/presentation/cubit/quiz_cubit.dart';
import 'package:lavender/features/programs/presentation/cubit/quiz_states.dart';
import 'package:lavender/features/programs/presentation/widgets/quiz_progress_indicator.dart';

import '../../../core/widget/custom_cached_network_image.dart';

class FirstQuizScreen extends StatefulWidget {
  const FirstQuizScreen({super.key, required this.initialQuiz});
  final Quiz initialQuiz;

  @override
  State<FirstQuizScreen> createState() => _FirstQuizScreenState();
}

class _FirstQuizScreenState extends State<FirstQuizScreen> {
  int currentQuestionIndex = 0;
  int? selectedAnswerIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AlexText(text: "مقياس"),
        leading: const BackIcon(),
      ),
      body: BlocConsumer<QuizCubit, QuizState>(
        listener: (context, state) {
          if (state is QuizSubmissionSuccess) {
            final totalQuestions = widget.initialQuiz.questions.length;

            // Trigger navigation only on the final question
            if (currentQuestionIndex == totalQuestions - 1) {
              Navigator.pushReplacementNamed(
                context,
                Routes.quizResultScreen,
                arguments: state.response,
              );
            }
          }
        },
        builder: (context, state) {
          // Since we are taking a single quiz, we don't need .first or .isEmpty
          final activeQuiz = widget.initialQuiz;
          final questionsCount = activeQuiz.questions.length;
          final currentQuestion = activeQuiz.questions[currentQuestionIndex];

          if (state is QuizError) {
            return Center(child: Text(state.message, style: const TextStyle(color: Colors.red)));
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: AlexText(text: activeQuiz.title, fontSize: 18, fontWeight: FontWeight.bold),
              ),

              if (activeQuiz.image != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 22),
                  child: CustomCachedNetworkImage(
                    imageUrl: activeQuiz.image!,
                    width: 80,
                    height: 80,
                  ),
                ),

              QuizProgressIndicator(
                currentQuestion: currentQuestionIndex + 1,
                totalQuestions: questionsCount,
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 26),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: AlexText(
                          text: currentQuestion.text,
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Answer mapping
                      ...currentQuestion.answers.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () => setState(() => selectedAnswerIndex = entry.key),
                          child: QuizAnswerTile(
                            text: entry.value.text,
                            isSelected: selectedAnswerIndex == entry.key,
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),

              // Button Logic
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: (selectedAnswerIndex != null && state is! QuizSubmissionLoading)
                        ? () => goToNextQuestion(
                      questionsCount,
                      currentQuestion.id,
                      currentQuestion.answers[selectedAnswerIndex!].id,
                    )
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColorLavenderLangAndText,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    child: (state is QuizSubmissionLoading)
                        ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                    )
                        : AlexText(
                      text: currentQuestionIndex == questionsCount - 1 ? 'إنهاء' : 'التالي',
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void goToNextQuestion(int totalQuestions, int questionId, int answerValue) {
    // 1. Submit to API via Cubit
    context.read<QuizCubit>().submitAnswer(
      questionId: questionId,
      answerValue: answerValue,
    );

    // 2. Local transition
    if (currentQuestionIndex < totalQuestions - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswerIndex = null;
      });
    }
  }
}

class QuizAnswerTile extends StatelessWidget {
  final String text;
  final bool isSelected;

  const QuizAnswerTile({super.key, required this.text, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        width: 343.w,
        height: 48.h,
        padding: isSelected ? const EdgeInsets.all(2) : null,
        decoration: BoxDecoration(
          gradient: isSelected ? AppColors.linearGradient : null,
          color: isSelected ? null : AppColors.doctorCardColor,
          borderRadius: BorderRadius.circular(32.r),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : AppColors.doctorCardColor,
            borderRadius: BorderRadius.circular(32.r),
          ),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AlexText(text: text, fontSize: 14.sp),
        ),
      ),
    );
  }
}
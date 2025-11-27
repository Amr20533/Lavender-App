import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lavender/core/routing/router.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/core/widget/alex_text.dart';
import 'package:lavender/core/widget/back_icon.dart';
import 'package:lavender/features/programs/presentation/cubit/quiz_cubit.dart';
import 'package:lavender/features/programs/presentation/cubit/quiz_states.dart';
import 'package:lavender/features/programs/presentation/widgets/quiz_progress_indicator.dart';

class FirstQuizScreen extends StatefulWidget {
  const FirstQuizScreen({Key? key}) : super(key: key);

  @override
  State<FirstQuizScreen> createState() => _FirstQuizScreenState();
}

class _FirstQuizScreenState extends State<FirstQuizScreen> {
  int currentQuestionIndex = 0;
  int? selectedAnswerIndex;

  @override
  void initState() {
    super.initState();
    context.read<QuizCubit>().fetchMeasurementQuizzes();
  }

  void goToNextQuestion(int totalQuestions) {
    if (currentQuestionIndex < totalQuestions - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswerIndex = null;
      });
    } else {
      Navigator.pushNamed(context, Routes.quizResultScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AlexText(text: "مقياس"),
        toolbarHeight: 70,
        leading: BackIcon(),
      ),
      body: BlocBuilder<QuizCubit, QuizState>(
        builder: (context, state) {
          if (state is QuizLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is QuizError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 60, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${state.message}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              ),
            );
          }

          if (state is QuizLoaded) {
            if (state.quizzes.isEmpty) {
              return const Center(child: Text('No quizzes available'));
            }

            final firstQuiz = state.quizzes.first;
            final questions = firstQuiz.questions;

            if (questions.isEmpty) {
              return const Center(child: Text('No questions available'));
            }

            // Get current question only
            final currentQuestion = questions[currentQuestionIndex];

            return Column(
              children: [
                // Quiz Title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: AlexText(text: firstQuiz.title),
                ),
                const SizedBox(height: 8),

                // Quiz Image
                if (firstQuiz.image != null) ...[
                  Image.asset("assets/images/image.png"),
                  const SizedBox(height: 16),

                  QuizProgressIndicator(
                    currentQuestion: currentQuestionIndex + 1,
                    totalQuestions: questions.length,
                  ),
                ],

                // Scrollable content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 26),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),

                        // Question text
                        Text(
                          currentQuestion.text,
                          style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColorDarkText,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Answers
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                              currentQuestion.answers.asMap().entries.map((
                                entry,
                              ) {
                                int index = entry.key;
                                var answer = entry.value;
                                bool isSelected = selectedAnswerIndex == index;

                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedAnswerIndex = index;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child:
                                        isSelected
                                            ? Container(
                                              width: 343,
                                              height: 48,
                                              padding: const EdgeInsets.all(1),
                                              decoration: BoxDecoration(
                                                gradient:
                                                    AppColors.linearGradient,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                alignment:
                                                    Alignment.centerRight,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                    ),
                                                child: Text(
                                                  answer.text,
                                                  style: GoogleFonts.alexandria(
                                                    color: AppColors.button,
                                                    fontSize: 16.sp,
                                                  ),
                                                ),
                                              ),
                                            )
                                            : Text(
                                              answer.text,
                                              style: GoogleFonts.alexandria(
                                                color:
                                                    AppColors
                                                        .primaryColorDarkText,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                  ),
                                );
                              }).toList(),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),

                // Next Button at the bottom
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed:
                          selectedAnswerIndex != null
                              ? () => goToNextQuestion(questions.length)
                              : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                          255,
                          151,
                          149,
                          245,
                        ),
                        disabledBackgroundColor: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        currentQuestionIndex == questions.length - 1
                            ? 'إنهاء'
                            : 'التالي',
                        style: GoogleFonts.alexandria(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          return const Center(child: Text('Unknown state'));
        },
      ),
    );
  }
}

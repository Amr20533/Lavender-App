import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lavender/core/routing/router.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/core/widget/alex_text.dart';
import 'package:lavender/core/widget/app_bar_shadow.dart';
import 'package:lavender/core/widget/back_icon.dart';
import 'package:lavender/features/programs/presentation/cubit/quiz_cubit.dart';
import 'package:lavender/features/programs/presentation/cubit/quiz_states.dart';

class MeasurementsScreen extends StatelessWidget {
  const MeasurementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AlexText(text: "المقاييس"),
        toolbarHeight: 70,
        leading: BackIcon(),
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(3, 3, 10, 0),
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppColors.purple50.withOpacity(0.6),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.more_vert_sharp,
                color: AppColors.primaryColorLavenderLangAndText,
                size: 26,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        spacing: 30.h,
        children: [
          AppBarShadow(),
          Expanded(
            child: BlocBuilder<QuizCubit, QuizState>(
              builder: (context, state) {
                if (state is QuizLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is QuizLoaded) {
                  return GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 3 / 4,
                      mainAxisExtent: 164,
                    ),
                    itemCount: state.quizzes.length,
                    itemBuilder: (context, index) {
                      final quiz = state.quizzes[index];
                      return GestureDetector(
                        onTap: () {
                          _navigateToQuizScreen(context, index, quiz);
                        },
                        child: Container(
                          width: 164.w,
                          height: 164.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white,
                            border: Border.all(
                              color: AppColors.purple50,
                              width: 1.w,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: AlexText(
                                  text: quiz.title,
                                  textAlign: TextAlign.center,
                                  fontSize: 12,
                                ),
                              ),
                              Container(
                                width: 72,
                                height: 72,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.grey[200],
                                  image: DecorationImage(
                                    image: NetworkImage(quiz.image!),
                                    fit: BoxFit.fill,
                                    onError: (error, stackTrace) {},
                                  ),
                                ),
                                child: quiz.image!.isEmpty
                                    ? const Icon(
                                        Icons.broken_image,
                                        size: 50,
                                        color: Colors.grey,
                                      )
                                    : null,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is QuizError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToQuizScreen(BuildContext context, int index, dynamic quiz) {
  
    final Map<int, String> quizRoutes = {
      0: Routes.firstQuizScreen,             
     // 1: Routes.reviewsScreen,          
     // 2: Routes.allDoctorsScreen,       
    //  3: Routes.courseOne,            
    //  4: Routes.reviewsScreen,         
     // 5: Routes.allDoctorsScreen,     
    };

    final route = quizRoutes[index] ?? Routes.quizResultScreen;
    
    Navigator.pushNamed(context, route);
  }
}




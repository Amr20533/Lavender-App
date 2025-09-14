import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavender/features/home/widgets/alex_text.dart';
import 'package:lavender/features/programs/presentation/cubit/quiz_cubit.dart';
import 'package:lavender/features/programs/presentation/cubit/quiz_states.dart';

class MeasurementsScreen extends StatelessWidget {
  const MeasurementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const AlexText(text: "المقاييس"), centerTitle: true,),
      body: BlocBuilder<QuizCubit, QuizState>(
        builder: (context, state) {
          if (state is QuizLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is QuizLoaded) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3 / 4,
                ),
                itemCount: state.quizzes.length,
                itemBuilder: (context, index) {
                  final quiz = state.quizzes[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AlexText(
                            text: quiz.title,
                            textAlign: TextAlign.center,

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
                              onError: (error, stackTrace) {
                              },
                            ),
                          ),
                          child: quiz.image!.isEmpty
                              ? const Icon(Icons.broken_image, size: 50, color: Colors.grey)
                              : null,
                        ),


                      ],
                    ),
                  );
                },
              ),
            );
          } else if (state is QuizError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavender/features/programs/logic/repository_interface/quiz_repository.dart';
import 'package:lavender/features/programs/presentation/cubit/quiz_states.dart';

class QuizCubit extends Cubit<QuizState> {
  final QuizRepository repository;

  QuizCubit(this.repository) : super(QuizInitial());

  Future<void> fetchMeasurementQuizzes() async {
    emit(QuizLoading());
    try {
      final quizzes = await repository.getMeasurementQuizzes();
      emit(QuizLoaded(quizzes));
    } catch (e) {
      emit(QuizError(e.toString()));
    }
  }

  Future<void> submitAnswer({required int questionId, required int answerValue}) async {
    // Note: We don't emit Loading here if we want to keep the UI showing the quiz
    // during individual question transitions, OR we can emit a specific loading.
    try {
      final response = await repository.submitMeasurementQuizzes(
        questionId: questionId,
        answerValue: answerValue,
      );
      emit(QuizSubmissionSuccess(response));
    } catch (e) {
      emit(QuizSubmissionError(e.toString()));
    }
  }
}

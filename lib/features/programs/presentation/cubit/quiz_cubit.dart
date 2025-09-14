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
}

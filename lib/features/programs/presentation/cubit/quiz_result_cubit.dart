import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavender/features/programs/data/repositories/quizzes_repository_impl.dart';
import 'package:lavender/features/programs/presentation/cubit/quiz_result_states.dart';

class QuizResultCubit extends Cubit<QuizResultState> {
  final QuizRepositoryImpl repository;

  QuizResultCubit(this.repository) : super(QuizResultInitial());

  Future<void> fetchQuizResults(String quizId) async {
    emit(QuizResultLoading());
    try {
      final quizResultModel = await repository.getQuizResults( quizId: quizId,);
      emit(QuizResultLoaded(quizResultModel));
    } catch (e) {
      emit(QuizResultError(e.toString()));
    }
  }
}

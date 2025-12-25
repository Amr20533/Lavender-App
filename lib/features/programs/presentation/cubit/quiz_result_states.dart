
import 'package:lavender/features/programs/data/models/quizzes/quiz_result_model.dart';
import 'package:lavender/features/programs/data/models/quizzes/quizzes_response.dart';
import 'package:meta/meta.dart';


@immutable
sealed class QuizResultState {}

final class QuizResultInitial extends QuizResultState {}

final class QuizResultLoading extends QuizResultState {}

final class QuizResultLoaded extends QuizResultState {
  final QuizResultModel quizResultModel;
  QuizResultLoaded(this.quizResultModel);
}

final class QuizResultError extends QuizResultState {
  final String message;
  QuizResultError(this.message);
}
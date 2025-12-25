
import 'package:lavender/features/programs/data/models/quizzes/quiz_submission_response.dart';
import 'package:lavender/features/programs/data/models/quizzes/quizzes_response.dart';
import 'package:meta/meta.dart';


@immutable
sealed class QuizState {}

final class QuizInitial extends QuizState {}

final class QuizLoading extends QuizState {}

final class QuizLoaded extends QuizState {
  final List<Quiz> quizzes;
  QuizLoaded(this.quizzes);
}

final class QuizError extends QuizState {
  final String message;
  QuizError(this.message);
}

final class QuizSubmissionLoading extends QuizState {}
final class QuizSubmissionSuccess extends QuizState {
  final QuizSubmissionResponse response;
  QuizSubmissionSuccess(this.response);
}
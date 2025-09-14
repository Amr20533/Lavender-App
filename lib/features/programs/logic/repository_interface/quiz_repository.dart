import 'package:lavender/features/programs/data/models/quizzes/quizzes_response.dart';

abstract class QuizRepository {
  Future<List<Quiz>> getMeasurementQuizzes();
}

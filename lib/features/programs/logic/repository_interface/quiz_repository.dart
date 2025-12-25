import 'package:lavender/features/programs/data/models/quizzes/quiz_submission_response.dart';
import 'package:lavender/features/programs/data/models/quizzes/quizzes_response.dart';

import '../../data/models/quizzes/quiz_result_model.dart';

abstract class QuizRepository {
  Future<List<Quiz>> getMeasurementQuizzes();
  Future<QuizSubmissionResponse> submitMeasurementQuizzes({
    required int questionId,
    required int answerValue,
  });

  Future<QuizResultModel> getQuizResults({required String quizId});

}

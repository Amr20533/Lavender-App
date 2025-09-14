import 'package:dio/dio.dart';
import 'package:lavender/core/networking/api_constants.dart';
import 'package:lavender/core/networking/dio_helper.dart';
import 'package:lavender/features/programs/data/models/quizzes/quizzes_response.dart';
import 'package:lavender/features/programs/logic/repository_interface/quiz_repository.dart';


class QuizRepositoryImpl implements QuizRepository {
  @override
  Future<List<Quiz>> getMeasurementQuizzes() async {
    try {
      final response = await DioHelper.getData(
        url: ApiConstants.getMeasurementQuizzes,
      );

      final data = response.data as List;
      return data.map((e) => Quiz.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception("Network error: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }
}

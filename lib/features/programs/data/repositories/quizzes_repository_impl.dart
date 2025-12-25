import 'package:dio/dio.dart';
import 'package:lavender/core/helpers/secure_storage_helper.dart';
import 'package:lavender/core/networking/api_constants.dart';
import 'package:lavender/core/networking/dio_helper.dart';
import 'package:lavender/features/programs/data/models/quizzes/quiz_result_model.dart';
import 'package:lavender/features/programs/data/models/quizzes/quiz_submission_response.dart';
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

  @override
  Future<QuizResultModel> getQuizResults({required String quizId}) async {
    String? token = await SecureStorageHelper.getAccessToken();
    if (token == null) throw Exception("No access token");

    try {
      final response = await DioHelper.getData(
        url: '${ApiConstants.getMeasurementQuizResults}/$quizId/result/',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      // Return the parsed model
      return QuizResultModel.fromJson(response.data);

    } on DioException catch (e) {
      throw Exception("Network error: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  @override
  Future<QuizSubmissionResponse> submitMeasurementQuizzes({
    required int questionId,
    required int answerValue,
  }) async {
    String? token = await SecureStorageHelper.getAccessToken();
    if (token == null) throw Exception("No access token");

    try {

      final response = await DioHelper.postData(
        url: ApiConstants.submitMeasurementQuizzesAnswer,
        data: {
          "question": questionId,
          "answer": answerValue,
        },
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      return QuizSubmissionResponse.fromJson(response.data);

    } on DioException catch (e) {
      final errorMessage = e.response?.data?['message'] ?? e.message;
      throw Exception("Network error: $errorMessage");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

}

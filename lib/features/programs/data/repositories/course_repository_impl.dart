import 'package:dio/dio.dart';
import 'package:lavender/core/helpers/app_exception.dart';
import 'package:lavender/core/helpers/secure_storage_helper.dart';
import 'package:lavender/core/networking/api_constants.dart';
import 'package:lavender/core/networking/dio_helper.dart';
import 'package:lavender/features/programs/data/models/course_model.dart';
import 'package:lavender/features/programs/data/models/free_programs/free_program.dart';
import 'package:lavender/features/programs/logic/repository_interface/course_repository.dart';

class CoursesRepositoryImpl implements CoursesRepository {
  @override
  Future<List<CourseModel>> getCourses() async {
    String? token = await SecureStorageHelper.getAccessToken();
    if (token == null) {
      throw Exception("No access token");
    }

    try {
      final response = await DioHelper.getData(
        url: ApiConstants.getCourses,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      
      Future.delayed(const Duration(seconds: 2), () {});
      final data = response.data is List ? response.data : response.data['courses'];
      return (data as List).map((json) => CourseModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception("Network error: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  @override
  Future<List<FreeProgram>> getFreePrograms() async {
    final token = await SecureStorageHelper.getAccessToken();
    if (token == null) {
      throw const UnauthorizedException();
    }

    try {
      final response = await DioHelper.getData(
        url: ApiConstants.getFreePrograms,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final List data = response.data;
      return data.map((json) => FreeProgram.fromJson(json)).toList();

    } on DioException catch (e) {
      // Better error handling for Dio
      // String errorMsg = e.response?.data?['message'] ?? e.message;
      throw NetworkException();
    } catch (e) {
      throw const UnknownException();
    }
  }

}

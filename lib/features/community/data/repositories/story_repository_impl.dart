import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:lavender/core/helpers/secure_storage_helper.dart';
import 'package:lavender/core/networking/api_constants.dart';
import 'package:lavender/core/networking/dio_helper.dart';
import 'package:lavender/features/community/data/models/user_stories.dart';
import 'package:lavender/features/community/logic/repositories_interface/story_repo.dart';

class StoryRepositoryImpl implements StoryRepo {
  @override
  Future<List<UserStories>> getStories() async {
    String? token = await SecureStorageHelper.getAccessToken();
    if (token == null) {
      throw Exception("No access token");
    }

    try {
      final response = await DioHelper.getData(
        url: ApiConstants.getStatus,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      // Expected response: { "status": "success", "data": [ {user + stories}, ... ] }
      final List<dynamic> data = response.data["data"];

      // Convert each user object into UserStories
      debugPrint("Loaded Stories: ${data.length}");
      return data.map((json) => UserStories.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception("Network error: ${e.message}");
    } catch (e) {
      debugPrint("Unexpected error: $e");

      throw Exception("Unexpected error: $e");
    }
  }


}

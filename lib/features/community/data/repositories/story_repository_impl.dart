import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:lavender/core/helpers/app_exception.dart';
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
      throw UnauthorizedException();
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
      final dynamic responseData = response.data["data"];

      if (responseData is! List) {
        debugPrint("API Error: 'data' is not a list: $responseData");
        return [];
      }

      return responseData.map((json) {
        try {
          return UserStories.fromJson(json as Map<String, dynamic>);
        } catch (e) {
          debugPrint("Error parsing UserStories: $e");
          return UserStories(
            id: 0,
            firstName: "Error",
            lastName: "",
            stories: [],
          );
        }
      }).toList();
    } on DioException catch (e) {
      throw NetworkException();
    } catch (e) {
      throw UnknownException();
    }
  }
}

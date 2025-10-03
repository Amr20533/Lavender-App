import 'package:dio/dio.dart';
import 'package:lavender/core/helpers/secure_storage_helper.dart';
import 'package:lavender/core/networking/api_constants.dart';
import 'package:lavender/core/networking/dio_helper.dart';
import 'package:lavender/features/home/data/models/specialists_response.dart';
import 'package:lavender/features/profile/data/models/current_user_info_response.dart';
import 'package:lavender/features/profile/data/models/users_response.dart';
import 'package:lavender/features/profile/logic/repositories_interface/profile_repo.dart';

class ProfileRepositoryImpl implements ProfileRepository {

  @override
  Future<UsersResponse> getUsers() async {
    try {
      final response = await DioHelper.getData(
        url: ApiConstants.getUsers,
      );
      return UsersResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception("Network error: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  @override
  Future<CurrentUserInfoResponse> getCurrentUser() async {
    String? token = await SecureStorageHelper.getAccessToken();
    if (token == null) {
      throw Exception("No access token");
    }

    try {
      final response = await DioHelper.getData(
        url: ApiConstants.getCurrentUser,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      return CurrentUserInfoResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception("Network error: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }
}

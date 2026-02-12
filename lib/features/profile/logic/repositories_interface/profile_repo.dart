import 'package:lavender/features/profile/data/models/current_user_info_response.dart';
import 'package:lavender/features/profile/data/models/users_response.dart';

abstract class ProfileRepository {
  Future<UsersResponse> getUsers();
  Future<CurrentUserInfoResponse> getCurrentUser();
  Future<void> updateProfile({required Map<String, dynamic> data, dynamic image});
}


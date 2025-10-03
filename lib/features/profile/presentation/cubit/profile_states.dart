import 'package:lavender/features/profile/data/models/current_user_info_response.dart';
import 'package:lavender/features/profile/data/models/users_response.dart';

abstract class ProfileStates {}

class ProfileInitial extends ProfileStates {}

class ProfileLoading extends ProfileStates {}

class ProfileLoaded extends ProfileStates {
  final UsersResponse usersResponse;

  ProfileLoaded(this.usersResponse);
}

class ProfileError extends ProfileStates {
  final String message;

  ProfileError(this.message);
}


import 'package:lavender/features/profile/data/models/current_user_info_response.dart';

abstract class CurrentUserStates {}

class CurrentUserInitial extends CurrentUserStates {}

class CurrentUserProfileLoading extends CurrentUserStates {}

class CurrentUserProfileLoaded extends CurrentUserStates {
  final CurrentUserInfoResponse currentUserInfoResponse;

  CurrentUserProfileLoaded(this.currentUserInfoResponse);
}

class CurrentUserProfileError extends CurrentUserStates {
  final String message;

  CurrentUserProfileError(this.message);
}

class CurrentUserUpdateLoading extends CurrentUserStates {}

class CurrentUserUpdateSuccess extends CurrentUserStates {}

class CurrentUserUpdateError extends CurrentUserStates {
  final String message;
  CurrentUserUpdateError(this.message);
}
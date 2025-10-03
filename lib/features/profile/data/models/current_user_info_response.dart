import 'package:lavender/features/profile/data/models/UserProfile.dart';

class CurrentUserInfoResponse {
  final String status;
  final UserProfile profile;

  CurrentUserInfoResponse({
    required this.status,
    required this.profile,
  });

  factory CurrentUserInfoResponse.fromJson(Map<String, dynamic> json) {
    return CurrentUserInfoResponse(
      status: json['status'] as String,
      profile: UserProfile.fromJson(json['profile'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'profile': profile.toJson(),
    };
  }

  @override
  String toString() {
    return 'CurrentUserInfoResponse(status: $status, UserProfile: $UserProfile)';
  }
}

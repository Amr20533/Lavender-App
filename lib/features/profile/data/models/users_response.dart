import 'package:lavender/features/profile/data/models/user_with_profile.dart';

class UsersResponse {
  final String status;
  final List<UserWithProfile> users;

  UsersResponse({
    required this.status,
    required this.users,
  });

  factory UsersResponse.fromJson(Map<String, dynamic> json) {
    return UsersResponse(
      status: json['status'] as String,
      users: (json['users'] as List<dynamic>)
          .map((e) => UserWithProfile.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'users': users.map((u) => u.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'UsersResponse(status: $status, users: $users)';
  }
}

import 'package:lavender/features/profile/data/models/user.dart';

class InboxUserProfile {
  final User user;
  final String? profilePic;
  final String? bio;
  final String? role;
  // final String? phoneNumber;
  // final String? gender;

  InboxUserProfile({
    required this.user,
    this.profilePic,
    this.bio,
    this.role,
    // this.phoneNumber,
    // this.gender,
  });

  factory InboxUserProfile.empty() {
    return InboxUserProfile(user: User.empty());
  }

  factory InboxUserProfile.fromJson(Map<String, dynamic> json) {
    return InboxUserProfile(
      // Access the nested 'user' Map
      user: json['user'] != null
          ? User.fromJson(json['user'] as Map<String, dynamic>)
          : User.empty(),
      profilePic: json['profile_pic'] as String?,
      bio: json['bio'] as String?,
      role: json['role'] as String?,
      // phoneNumber: json['phone_number'] as String?,
      // gender: json['gender'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'profile_pic': profilePic,
      'bio': bio,
      'role': role,
      // 'phone_number': phoneNumber,
      // 'gender': gender,
    };
  }
}
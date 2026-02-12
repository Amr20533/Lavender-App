import 'package:lavender/features/profile/data/models/user.dart';

class UserProfile {
  final User user;
  final String? profilePic;
  final DateTime? dateOfBirth;
  final String? gender;
  final String? phoneNumber;
  final String? role;
  final String? bio;
  final String? country;

  UserProfile({
    required this.user,
    this.profilePic,
    this.dateOfBirth,
    this.gender,
    this.phoneNumber,
    this.role,
    this.bio,
    this.country,
  });

  factory UserProfile.empty() {
    return UserProfile(
      user: User.empty(),
      role: 'Guest',
    );
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      // FIX: Check if 'user' key exists. If not, the 'json' itself might BE the user data.
      user: json.containsKey('user') && json['user'] != null
          ? User.fromJson(json['user'] as Map<String, dynamic>)
          : User.fromJson(json), // Try parsing the top-level keys

      profilePic: json['profile_pic'] as String?,
      dateOfBirth: json['date_of_birth'] != null
          ? DateTime.tryParse(json['date_of_birth'] as String)
          : null,
      gender: json['gender'] as String?,
      phoneNumber: json['phone_number'] as String?,
      role: json['role'] as String?,
      bio: json['bio'] as String?,
      country: json['country'] as String?,
    );
  }  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      if (profilePic != null) 'profile_pic': profilePic,
      if (dateOfBirth != null) 'date_of_birth': dateOfBirth!.toIso8601String(),
      if (gender != null) 'gender': gender,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (role != null) 'role': role,
      if (bio != null) 'bio': bio,
      if (country != null) 'country': country,
    };
  }

  @override
  String toString() {
    return 'UserProfile(user: $user, profilePic: $profilePic, dateOfBirth: $dateOfBirth, '
        'gender: $gender, phoneNumber: $phoneNumber, role: $role, bio: $bio, country: $country)';
  }
}

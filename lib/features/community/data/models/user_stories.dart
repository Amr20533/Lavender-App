import 'package:lavender/features/community/data/models/story_model.dart';

class UserStories {
  final int id;
  final String firstName;
  final String lastName;
  final String? profilePic;
  final List<Story> stories;

  UserStories({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.profilePic,
    required this.stories,
  });

  factory UserStories.fromJson(Map<String, dynamic> json) {
    return UserStories(
      id: json["id"] ?? 0,
      firstName: json["first_name"] ?? "",
      lastName: json["last_name"] ?? "",
      profilePic: json["profile_pic"],
      stories:
      json["statuses"] != null
          ? (json["statuses"] as List<dynamic>)
          .map((e) => Story.fromJson(e))
          .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "first_name": firstName,
      "last_name": lastName,
      "profile_pic": profilePic,
      "statuses": stories.map((e) => e.toJson()).toList(),
    };
  }
}
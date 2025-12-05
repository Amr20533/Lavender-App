import 'package:lavender/features/community/data/models/story_reply.dart';

class Story {
  final String id;
  final int user;
  final String? caption;
  final String? image;
  final DateTime createdAt;
  final int likesCount;
  final bool isSeen;
  final List<StoryReply> replies;

  Story({
    required this.id,
    required this.user,
    this.caption,
    this.image,
    required this.createdAt,
    required this.likesCount,
    required this.isSeen,
    required this.replies,
  });

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      id: json["id"] as String,
      caption: json["caption"] as String?,
      image: json["image"] as String?,
      user: json["user"],
      createdAt: DateTime.parse(json["created_at"]),
      likesCount: json["likes_count"],
      isSeen: json["is_seen"],
      replies: (json["replies"] as List<dynamic>)
          .map((e) => StoryReply.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user": user,
      "caption": caption,
      "image": image,
      "created_at": createdAt.toIso8601String(),
      "likes_count": likesCount,
      "is_seen": isSeen,
      "replies": replies.map((e) => e.toJson()).toList(),
    };
  }
}

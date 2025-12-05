
class StoryReply {
  final String id;
  final int user;
  final String reply;
  final DateTime createdAt;
  final bool edited;

  StoryReply({
    required this.id,
    required this.user,
    required this.reply,
    required this.createdAt,
    required this.edited,
  });

  factory StoryReply.fromJson(Map<String, dynamic> json) {
    return StoryReply(
      id: json["id"],                 // String
      user: json["user"],             // int
      reply: json["content"],         // FIXED
      createdAt: DateTime.parse(json["created_at"]),
      edited: json["edited"] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user": user,
      "content": reply,
      "created_at": createdAt.toIso8601String(),
      "edited": edited,
    };
  }
}

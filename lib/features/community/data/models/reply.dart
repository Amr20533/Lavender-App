class Reply {
  final String id;
  final String comment;
  final int user;
  final String content;
  final String createdAt;
  final bool edited;
  final int likesCount;

  Reply({
    required this.id,
    required this.comment,
    required this.user,
    required this.content,
    required this.createdAt,
    required this.edited,
    required this.likesCount,
  });

  factory Reply.fromJson(Map<String, dynamic> json) => Reply(
    id: json["id"],
    comment: json["comment"],
    user: json["user"],
    content: json["content"],
    createdAt: json["created_at"],
    edited: json["edited"],
    likesCount: json["likes_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "comment": comment,
    "user": user,
    "content": content,
    "created_at": createdAt,
    "edited": edited,
    "likes_count": likesCount,
  };
}

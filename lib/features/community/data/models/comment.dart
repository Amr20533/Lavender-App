import 'package:lavender/features/community/data/models/reply.dart';

class Comment {
  final String id;
  final String post;
  final int user;
  final String content;
  final String createdAt;
  final bool edited;
  final bool isLiked;
  final int likesCount;
  final List<Reply> replies;

  Comment({
    required this.id,
    required this.post,
    required this.user,
    required this.content,
    required this.createdAt,
    required this.edited,
    required this.isLiked,
    required this.likesCount,
    required this.replies,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    id: json["id"],
    post: json["post"],
    user: json["user"],
    content: json["content"],
    createdAt: json["created_at"],
    edited: json["edited"],
    isLiked: json["is_liked"] ?? false,
    likesCount: json["likes_count"] ?? 0,
    replies: json["replies"] == null
        ? []
        : List<Reply>.from(json["replies"].map((x) => Reply.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "post": post,
    "user": user,
    "content": content,
    "created_at": createdAt,
    "edited": edited,
    "is_liked": isLiked,
    "likes_count": likesCount,
    "replies": List<dynamic>.from(replies.map((x) => x.toJson())),
  };

  Comment copyWith({
    String? id,
    String? post,
    int? user,
    String? content,
    String? createdAt,
    bool? edited,
    bool? isLiked,
    int? likesCount,
    List<Reply>? replies,
  }) {
    return Comment(
      id: id ?? this.id,
      post: post ?? this.post,
      user: user ?? this.user,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      edited: edited ?? this.edited,
      isLiked: isLiked ?? this.isLiked,
      likesCount: likesCount ?? this.likesCount,
      replies: replies ?? this.replies,
    );
  }
}

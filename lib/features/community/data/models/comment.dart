
class Comment {
  final String? id;
  final String? text;
  final int? user;
  final DateTime? createdAt;

  Comment({
    this.id,
    this.text,
    this.user,
    this.createdAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] as String?,
      text: json['text'] as String?,
      user: json['user'] as int?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (text != null) 'text': text,
      if (user != null) 'user': user,
      if (createdAt != null)
        'created_at': createdAt!.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'Comment(id: $id, text: $text, user: $user, createdAt: $createdAt)';
  }
}

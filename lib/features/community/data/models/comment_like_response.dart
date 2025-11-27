class CommentLikeResponse {
  final String status;
  final int likesCount;
  final bool isLiked;

  CommentLikeResponse({
    required this.status,
    required this.likesCount,
    required this.isLiked,
  });

  factory CommentLikeResponse.fromJson(Map<String, dynamic> json) {
    return CommentLikeResponse(
      status: json['status'] as String,
      likesCount: json['likes_count'] as int,
      isLiked: json['is_liked'] as bool,
    );
  }
}


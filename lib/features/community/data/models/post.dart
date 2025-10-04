import 'package:lavender/features/community/data/models/comment.dart';

class Post {
  final String id;
  final int user;
  final String caption;
  final DateTime createdAt;
  final int likesCount;
  final String? image;
  final String? video;
  final List<Comment> comments;
  final bool isLiked;

  Post({
    required this.id,
    required this.user,
    required this.caption,
    required this.createdAt,
    required this.likesCount,
    this.image,
    this.video,
    required this.comments,
    this.isLiked = false,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as String,
      user: json['user'] as int,
      caption: json['caption'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      likesCount: json['likes_count'] as int,
      image: json['image'] as String?,
      video: json['video'] as String?,
      comments: (json['comments'] as List<dynamic>)
          .map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
      isLiked: json['is_liked'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      'caption': caption,
      'created_at': createdAt.toIso8601String(),
      'likes_count': likesCount,
      'image': image,
      'video': video,
      'comments': comments.map((c) => c.toJson()).toList(),
      'is_liked': isLiked,
    };
  }

  /// ✅ Add this copyWith method
  Post copyWith({
    String? id,
    int? user,
    String? caption,
    DateTime? createdAt,
    int? likesCount,
    String? image,
    String? video,
    List<Comment>? comments,
    bool? isLiked,
  }) {
    return Post(
      id: id ?? this.id,
      user: user ?? this.user,
      caption: caption ?? this.caption,
      createdAt: createdAt ?? this.createdAt,
      likesCount: likesCount ?? this.likesCount,
      image: image ?? this.image,
      video: video ?? this.video,
      comments: comments ?? this.comments,
      isLiked: isLiked ?? this.isLiked,
    );
  }

  @override
  String toString() {
    return 'Post(id: $id, user: $user, caption: $caption, createdAt: $createdAt, '
        'likesCount: $likesCount, image: $image, video: $video, comments: $comments, isLiked: $isLiked)';
  }
}

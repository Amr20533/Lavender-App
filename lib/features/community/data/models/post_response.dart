import 'package:lavender/features/community/data/models/post.dart';

class PostResponse {
  final String status;
  final List<Post> data;

  PostResponse({
    required this.status,
    required this.data,
  });

  factory PostResponse.fromJson(Map<String, dynamic> json) {
    return PostResponse(
      status: json['status'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => Post.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data.map((post) => post.toJson()).toList(),
    };
  }

  PostResponse copyWith({
    String? status,
    List<Post>? data,
  }) {
    return PostResponse(
      status: status ?? this.status,
      data: data ?? this.data,
    );
  }

  @override
  String toString() => 'PostResponse(status: $status, data: $data)';
}

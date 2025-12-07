import 'package:lavender/features/community/data/models/post.dart';

class CreatePostResponseModel{
  final String status;
  final Post data;

  CreatePostResponseModel({
    required this.status,
    required this.data,
  });

  factory CreatePostResponseModel.fromJson(Map<String, dynamic> json) {
    return CreatePostResponseModel(
      status: json["status"],
      data: Post.fromJson(json["data"]),
    );
  }
}
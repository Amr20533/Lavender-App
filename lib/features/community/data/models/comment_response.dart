import 'dart:convert';

import 'package:lavender/features/community/data/models/comment.dart';

CommentResponse commentResponseFromJson(String str) =>
    CommentResponse.fromJson(json.decode(str));

String commentResponseToJson(CommentResponse data) =>
    json.encode(data.toJson());

class CommentResponse {
  final String status;
  final List<Comment> data;

  CommentResponse({
    required this.status,
    required this.data,
  });

  factory CommentResponse.fromJson(Map<String, dynamic> json) => CommentResponse(
    status: json["status"],
    data: List<Comment>.from(json["data"].map((x) => Comment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

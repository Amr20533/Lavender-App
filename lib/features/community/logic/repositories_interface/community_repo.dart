import 'dart:io';

import 'package:lavender/features/community/data/models/comment.dart';
import 'package:lavender/features/community/data/models/comment_like_response.dart';
import 'package:lavender/features/community/data/models/create_post_response_model.dart';
import 'package:lavender/features/community/data/models/like_post_response.dart';
import 'package:lavender/features/community/data/models/post_response.dart';

abstract class CommunityRepository {
  Future<PostResponse> getPosts();
  Future<LikePostResponse> likePost(String postId);
  Future<Comment> addComment(String postId, String text);
  Future<List<Comment>> getComments(String postId);
  Future<CommentLikeResponse> likeComment(String commentId);
  Future<CreatePostResponseModel> addPost(String text, File? imageFile);
}



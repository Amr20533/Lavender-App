import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:lavender/core/helpers/secure_storage_helper.dart';
import 'package:lavender/core/networking/api_constants.dart';
import 'package:lavender/core/networking/dio_helper.dart';
import 'package:lavender/features/community/data/models/comment.dart';
import 'package:lavender/features/community/data/models/comment_like_response.dart';
import 'package:lavender/features/community/data/models/comment_response.dart';
import 'package:lavender/features/community/data/models/create_post_response_model.dart';
import 'package:lavender/features/community/data/models/like_post_response.dart';
import 'package:lavender/features/community/data/models/post_response.dart';
import '../../logic/repositories_interface/community_repo.dart';

class CommunityRepositoryImpl implements CommunityRepository {
  @override
  Future<PostResponse> getPosts() async {
    String? token = await SecureStorageHelper.getAccessToken();
    if (token == null) {
      throw Exception("No access token");
    }

    try {
      final response = await DioHelper.getData(
        url: ApiConstants.getPosts,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      return PostResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception("Network error: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  @override
  Future<LikePostResponse> likePost(String postId) async {
    String? token = await SecureStorageHelper.getAccessToken();
    if (token == null) {
      throw Exception("No access token");
    }

    try {
      final response = await DioHelper.postData(
        url: "${ApiConstants.likePost}/$postId/like/",
        data: {},
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      return LikePostResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception("Network error: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  @override
  Future<List<Comment>> getComments(String postId) async {
    String? token = await SecureStorageHelper.getAccessToken();
    if (token == null) throw Exception("No access token");

    try {
      final response = await DioHelper.getData(
        url: "${ApiConstants.getPostComments}/$postId/comments/",
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final commentResponse = CommentResponse.fromJson(response.data);
      return commentResponse.data;
    } on DioException catch (e) {
      throw Exception("Network error: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }


  @override
  Future<Comment> addComment(String postId, String text) async {
    String? token = await SecureStorageHelper.getAccessToken();
    if (token == null) throw Exception("No access token");

    try {
      final response = await DioHelper.postData(
        url: "${ApiConstants.addPostComments}/$postId/comments/add/",
        data: {'content': text},
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      return Comment.fromJson(response.data["data"]);
    } on DioException catch (e) {
      throw Exception("Failed to add comment: ${e.message}");
    } catch (e) {
      debugPrint("Unexpected error: $e");
      throw Exception("Unexpected error: $e");
    }
  }

  @override
  Future<CommentLikeResponse> likeComment(String commentId) async {
    String? token = await SecureStorageHelper.getAccessToken();
    if (token == null) throw Exception("No access token");

    final response = await DioHelper.postData(
      url: "${ApiConstants.likeComment}/$commentId/like/",
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      data: {}
    );

    return CommentLikeResponse.fromJson(response.data);
  }


  @override
  Future<CreatePostResponseModel> addPost(String text) async {
    String? token = await SecureStorageHelper.getAccessToken();
    if (token == null) throw Exception("No access token");

    try {
      final response = await DioHelper.postData(
        url: ApiConstants.addPost,
        data: {'caption': text},
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      return CreatePostResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception("Failed to add post: ${e.message}");
    } catch (e) {
      debugPrint("Unexpected error: $e");
      throw Exception("Unexpected error: $e");
    }
  }



}
